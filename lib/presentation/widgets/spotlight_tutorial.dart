import 'package:flutter/material.dart';
import 'package:my_skin_routine/core/extensions/context_extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpotlightStep {
  final GlobalKey targetKey;
  final String title;
  final String description;
  final IconData? icon;

  const SpotlightStep({
    required this.targetKey,
    required this.title,
    required this.description,
    this.icon,
  });
}

class SpotlightTutorial {
  /// Shows a spotlight tutorial if it hasn't been shown before.
  /// [tutorialKey] is used to track if this tutorial was already shown.
  /// [steps] defines the sequence of highlighted elements.
  /// Call this AFTER the first frame is rendered (in addPostFrameCallback).
  static Future<void> showIfFirstTime({
    required BuildContext context,
    required String tutorialKey,
    required List<SpotlightStep> steps,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final shown = prefs.getBool('spotlight_$tutorialKey') ?? false;
    if (shown || !context.mounted) return;

    await prefs.setBool('spotlight_$tutorialKey', true);

    if (!context.mounted) return;

    await Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.transparent,
        pageBuilder: (_, __, ___) => _SpotlightOverlay(steps: steps),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }
}

class _SpotlightOverlay extends StatefulWidget {
  final List<SpotlightStep> steps;
  const _SpotlightOverlay({required this.steps});

  @override
  State<_SpotlightOverlay> createState() => _SpotlightOverlayState();
}

class _SpotlightOverlayState extends State<_SpotlightOverlay>
    with SingleTickerProviderStateMixin {
  int _currentStep = 0;
  late AnimationController _animController;
  late Animation<double> _animation;

  Rect? _targetRect;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animation =
        CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic);
    _updateTarget();
    _animController.forward();
  }

  void _updateTarget() {
    final step = widget.steps[_currentStep];
    final renderBox =
        step.targetKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null && renderBox.hasSize) {
      final position = renderBox.localToGlobal(Offset.zero);
      setState(() {
        _targetRect = Rect.fromLTWH(
          position.dx - 8,
          position.dy - 8,
          renderBox.size.width + 16,
          renderBox.size.height + 16,
        );
      });
    } else {
      // Widget not rendered yet — retry after next frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _updateTarget();
      });
    }
  }

  void _next() {
    if (_currentStep < widget.steps.length - 1) {
      _animController.reverse().then((_) {
        setState(() => _currentStep++);
        _updateTarget();
        _animController.forward();
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final step = widget.steps[_currentStep];
    final isLast = _currentStep == widget.steps.length - 1;
    final colorScheme = Theme.of(context).colorScheme;
    final screenSize = MediaQuery.sizeOf(context);

    // Determine tooltip position (above or below the target)
    final targetCenter =
        _targetRect?.center ?? Offset(screenSize.width / 2, screenSize.height / 2);
    final showAbove = targetCenter.dy > screenSize.height / 2;

    return GestureDetector(
      onTap: _next,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Stack(
            children: [
              // Dark overlay with hole
              CustomPaint(
                size: screenSize,
                painter: _SpotlightPainter(
                  targetRect: _targetRect,
                  opacity: _animation.value * 0.7,
                ),
              ),
              // Tooltip card (centered if no target found)
              Positioned(
                  left: 24,
                  right: 24,
                  top: _targetRect != null && !showAbove ? (_targetRect!.bottom + 16) : null,
                  bottom: _targetRect != null && showAbove
                      ? (screenSize.height - _targetRect!.top + 16)
                      : _targetRect == null ? screenSize.height * 0.3 : null,
                  child: Opacity(
                    opacity: _animation.value,
                    child: Material(
                      elevation: 8,
                      borderRadius: BorderRadius.circular(16),
                      color: colorScheme.surface,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Step counter
                            Row(
                              children: [
                                if (step.icon != null) ...[
                                  Icon(step.icon,
                                      color: colorScheme.primary, size: 20),
                                  const SizedBox(width: 8),
                                ],
                                Text(
                                  '${_currentStep + 1}/${widget.steps.length}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        color: colorScheme.outline,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              step.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              step.description,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                            ),
                            const SizedBox(height: 12),
                            Align(
                              alignment: Alignment.centerRight,
                              child: FilledButton.tonal(
                                onPressed: _next,
                                child: Text(isLast ? context.l10n.commonGotIt : context.l10n.commonNext),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _SpotlightPainter extends CustomPainter {
  final Rect? targetRect;
  final double opacity;

  _SpotlightPainter({this.targetRect, required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black.withValues(alpha: opacity);

    if (targetRect != null) {
      // Draw dark overlay with a rounded rect hole
      final path = Path()
        ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
        ..addRRect(RRect.fromRectAndRadius(targetRect!, const Radius.circular(12)))
        ..fillType = PathFillType.evenOdd;
      canvas.drawPath(path, paint);

      // Draw subtle border around the hole
      final borderPaint = Paint()
        ..color = Colors.white.withValues(alpha: opacity * 0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawRRect(
        RRect.fromRectAndRadius(targetRect!, const Radius.circular(12)),
        borderPaint,
      );
    } else {
      canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _SpotlightPainter old) =>
      old.targetRect != targetRect || old.opacity != opacity;
}

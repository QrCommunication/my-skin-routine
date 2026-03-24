import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A step in a guided tutorial
class TutorialStep {
  final String title;
  final String description;
  final IconData icon;

  const TutorialStep({
    required this.title,
    required this.description,
    required this.icon,
  });
}

/// Shows a guided tutorial overlay with multiple steps.
/// Each tutorial is shown only once (tracked by SharedPreferences key).
class GuidedTutorial {
  static Future<void> showIfFirstTime({
    required BuildContext context,
    required String tutorialKey,
    required List<TutorialStep> steps,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final alreadyShown = prefs.getBool('tutorial_$tutorialKey') ?? false;
    if (alreadyShown || !context.mounted) return;

    await prefs.setBool('tutorial_$tutorialKey', true);

    if (!context.mounted) return;

    await showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black54,
      builder: (ctx) => _TutorialDialog(steps: steps),
    );
  }
}

class _TutorialDialog extends StatefulWidget {
  final List<TutorialStep> steps;
  const _TutorialDialog({required this.steps});

  @override
  State<_TutorialDialog> createState() => _TutorialDialogState();
}

class _TutorialDialogState extends State<_TutorialDialog> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final step = widget.steps[_currentStep];
    final isLast = _currentStep == widget.steps.length - 1;
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Container(
        margin: const EdgeInsets.all(32),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Step indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.steps.length, (i) =>
                Container(
                  width: i == _currentStep ? 24 : 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: i == _currentStep
                        ? colorScheme.primary
                        : colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Icon
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(step.icon, size: 32, color: colorScheme.primary),
            ).animate().scale(
              begin: const Offset(0.5, 0.5),
              duration: 400.ms,
              curve: Curves.easeOutBack,
            ),
            const SizedBox(height: 20),
            // Title
            Text(
              step.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            // Description
            Text(
              step.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            // Button
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  if (isLast) {
                    Navigator.pop(context);
                  } else {
                    setState(() => _currentStep++);
                  }
                },
                child: Text(isLast ? 'C\'est parti !' : 'Suivant'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

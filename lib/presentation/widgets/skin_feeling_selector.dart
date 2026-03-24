import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_skin_routine/core/extensions/context_extensions.dart';

class SkinFeelingSelector extends StatelessWidget {
  final int? selectedFeeling;
  final ValueChanged<int> onChanged;

  const SkinFeelingSelector({
    super.key,
    required this.selectedFeeling,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final feelings = [
      (value: 1, emoji: '😣', label: context.l10n.journalFeelingTerrible),
      (value: 2, emoji: '😕', label: context.l10n.journalFeelingNotGreat),
      (value: 3, emoji: '😐', label: context.l10n.journalFeelingNormal),
      (value: 4, emoji: '😊', label: context.l10n.journalFeelingGood),
      (value: 5, emoji: '🤩', label: context.l10n.journalFeelingRadiant),
    ];

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: feelings
            .map((feeling) => _FeelingButton(
                  emoji: feeling.emoji,
                  label: feeling.label,
                  value: feeling.value,
                  isSelected: selectedFeeling == feeling.value,
                  onPressed: () => onChanged(feeling.value),
                ))
            .toList()
            .asMap()
            .entries
            .map(
              (entry) => entry.value
                  .animate()
                  .scale(
                    delay: (entry.key * 80).ms,
                    duration: 300.ms,
                  )
                  .fadeIn(
                    delay: (entry.key * 80).ms,
                    duration: 300.ms,
                  ),
            )
            .toList(),
      ),
    );
  }
}

class _FeelingButton extends StatefulWidget {
  final String emoji;
  final String label;
  final int value;
  final bool isSelected;
  final VoidCallback onPressed;

  const _FeelingButton({
    required this.emoji,
    required this.label,
    required this.value,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  State<_FeelingButton> createState() => _FeelingButtonState();
}

class _FeelingButtonState extends State<_FeelingButton> {
  late double _scaleValue;

  @override
  void initState() {
    super.initState();
    _scaleValue = widget.isSelected ? 1.1 : 1.0;
  }

  @override
  void didUpdateWidget(_FeelingButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      _scaleValue = widget.isSelected ? 1.1 : 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            widget.onPressed();
          },
          customBorder: const CircleBorder(),
          child: AnimatedScale(
            scale: _scaleValue,
            duration: const Duration(milliseconds: 200),
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.isSelected
                    ? Theme.of(context).colorScheme.primaryContainer
                    : Colors.transparent,
              ),
              child: Center(
                child: Text(widget.emoji, style: const TextStyle(fontSize: 28)),
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          widget.label,
          style: Theme.of(context).textTheme.labelSmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

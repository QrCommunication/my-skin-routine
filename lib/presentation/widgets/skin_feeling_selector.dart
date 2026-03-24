import 'package:flutter/material.dart';

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
      (value: 1, emoji: '😣', label: 'Terrible'),
      (value: 2, emoji: '😕', label: 'Pas top'),
      (value: 3, emoji: '😐', label: 'Normale'),
      (value: 4, emoji: '😊', label: 'Bien'),
      (value: 5, emoji: '🤩', label: 'Radieuse'),
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
            .toList(),
      ),
    );
  }
}

class _FeelingButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  ? Theme.of(context).colorScheme.primaryContainer
                  : Colors.transparent,
            ),
            child: Center(
              child: Text(emoji, style: const TextStyle(fontSize: 28)),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

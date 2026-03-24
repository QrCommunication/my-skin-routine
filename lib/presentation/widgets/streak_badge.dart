import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class StreakBadge extends StatelessWidget {
  final int streakDays;
  const StreakBadge({super.key, required this.streakDays});

  @override
  Widget build(BuildContext context) {
    if (streakDays <= 0) return const SizedBox.shrink();
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('🔥', style: const TextStyle(fontSize: 16))
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scale(begin: const Offset(1, 1), end: const Offset(1.15, 1.15), duration: 1000.ms),
          const SizedBox(width: 4),
          Text(
            '$streakDays',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: colorScheme.onTertiaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ).animate().fadeIn().scale(begin: const Offset(0.8, 0.8), curve: Curves.easeOutBack);
  }
}

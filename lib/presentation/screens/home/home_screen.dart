import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/enums.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/extensions/date_extensions.dart';
import '../../../core/utils/recurrence_utils.dart';
import '../../../domain/models/action_completion.dart';
import '../../../domain/models/routine.dart';
import '../../../domain/models/routine_action.dart';
import '../../providers/routine_providers.dart';
import '../../providers/streak_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeRoutinesAsync = ref.watch(activeRoutinesProvider);
    final today = DateTime.now().toDateString();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Large AppBar with greeting and controls
          SliverAppBar.large(
            title: const Text('Bonjour 💜'),
            actions: [
              // Streak badge
              ref.watch(streakForRoutineProvider(0)).when(
                data: (streak) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Center(
                      child: Badge(
                        label: Text(streak.toString()),
                        child: Icon(Icons.local_fire_department,
                            color: context.colorScheme.error),
                      ),
                    ),
                  );
                },
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () => context.push('/settings'),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                _formatDateForDisplay(DateTime.now()),
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
          // Routines list or empty state
          activeRoutinesAsync.when(
            data: (routines) {
              if (routines.isEmpty) {
                return SliverFillRemaining(
                  child: _EmptyState(context),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final routine = routines[index];
                    return _RoutineCard(
                      routine: routine,
                      today: today,
                      ref: ref,
                    );
                  },
                  childCount: routines.length,
                ),
              );
            },
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, st) => SliverFillRemaining(
              child: Center(
                child: Text('Erreur: $error'),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/progress/journal/new'),
        icon: const Icon(Icons.edit_note_rounded),
        label: const Text('Journal'),
      ),
    );
  }

  String _formatDateForDisplay(DateTime date) {
    final monthFr = [
      'janvier',
      'février',
      'mars',
      'avril',
      'mai',
      'juin',
      'juillet',
      'août',
      'septembre',
      'octobre',
      'novembre',
      'décembre'
    ];
    final dayFr = [
      'dimanche',
      'lundi',
      'mardi',
      'mercredi',
      'jeudi',
      'vendredi',
      'samedi'
    ];
    return '${dayFr[date.weekday % 7]} ${date.day} ${monthFr[date.month - 1]}';
  }
}

class _RoutineCard extends ConsumerWidget {
  final Routine routine;
  final String today;
  final WidgetRef ref;

  const _RoutineCard({
    required this.routine,
    required this.today,
    required this.ref,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completionsAsync = ref.watch(completionsForDateProvider(today));

    return completionsAsync.when(
      data: (completions) {
        final todayActions = routine.actions.where((action) {
          return isActionScheduledForDate(
            action.recurrenceType,
            action.recurrenceInterval,
            action.recurrenceStartDate,
            DateTime.parse('$today 00:00:00'),
          );
        }).toList();

        final completedCount = todayActions
            .where((action) =>
                completions.any((c) => c.actionId == action.id))
            .length;
        final allCompleted = completedCount == todayActions.length && todayActions.isNotEmpty;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Card(
            color: allCompleted
                ? context.colorScheme.primaryContainer.withAlpha(40)
                : context.colorScheme.surfaceContainerLow,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Routine name
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          routine.name,
                          style: context.textTheme.titleLarge,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (allCompleted)
                        Icon(Icons.check_circle,
                            color: context.colorScheme.primary),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Filter chips for body zone and skin goal
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      FilterChip(
                        label: Text(routine.bodyZone.labelFr),
                        onSelected: (_) {},
                      ),
                      FilterChip(
                        label: Text(
                          '${routine.skinGoal.emoji} ${routine.skinGoal.labelFr}',
                        ),
                        onSelected: (_) {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Progress bar
                  LinearProgressIndicator(
                    value: todayActions.isEmpty
                        ? 0
                        : completedCount / todayActions.length,
                    minHeight: 8,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$completedCount/${todayActions.length} complétées',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Actions list
                  if (todayActions.isEmpty)
                    Text(
                      'Aucune action prévu aujourd\'hui',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    )
                  else
                    Column(
                      children: List.generate(
                        todayActions.length,
                        (index) {
                          final action = todayActions[index];
                          final isCompleted = completions
                              .any((c) => c.actionId == action.id);
                          return _ActionItem(
                            action: action,
                            isCompleted: isCompleted,
                            onToggle: (completed) {
                              _toggleActionCompletion(
                                ref,
                                action.id,
                                today,
                                completed,
                              );
                            },
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
      loading: () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(routine.name,
                    style: context.textTheme.titleLarge),
                const SizedBox(height: 12),
                const CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
      error: (error, st) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Erreur: $error'),
          ),
        ),
      ),
    );
  }

  void _toggleActionCompletion(
    WidgetRef ref,
    int actionId,
    String date,
    bool completed,
  ) async {
    final repository = ref.read(routineRepositoryProvider);
    try {
      if (completed) {
        await repository.markActionCompleted(actionId, date);
      } else {
        await repository.unmarkActionCompleted(actionId, date);
      }
      // Invalidate the completions provider to refresh the UI
      ref.invalidate(completionsForDateProvider(date));
    } catch (e) {
      // Handle error silently for now
    }
  }
}

class _ActionItem extends StatefulWidget {
  final RoutineAction action;
  final bool isCompleted;
  final Function(bool) onToggle;

  const _ActionItem({
    required this.action,
    required this.isCompleted,
    required this.onToggle,
  });

  @override
  State<_ActionItem> createState() => _ActionItemState();
}

class _ActionItemState extends State<_ActionItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    if (widget.isCompleted) {
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(_ActionItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isCompleted != oldWidget.isCompleted) {
      if (widget.isCompleted) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Checkbox(
            value: widget.isCompleted,
            onChanged: (value) {
              widget.onToggle(value ?? false);
            },
          ),
          Expanded(
            child: Text(
              widget.action.name,
              style: context.textTheme.bodyMedium?.copyWith(
                decoration: widget.isCompleted
                    ? TextDecoration.lineThrough
                    : null,
                color: widget.isCompleted
                    ? context.colorScheme.onSurfaceVariant
                    : context.colorScheme.onSurface,
              ),
            ),
          ),
          if (widget.action.product != null)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Chip(
                label: Text(
                  widget.action.product!.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final BuildContext context;

  const _EmptyState(this.context);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.spa,
            size: 64,
            color: context.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'Aucune routine active',
            style: context.textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Créez votre première routine pour commencer',
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => context.push('/routines/new'),
            icon: const Icon(Icons.add),
            label: const Text('Créer ma première routine'),
          ),
        ],
      ),
    );
  }
}

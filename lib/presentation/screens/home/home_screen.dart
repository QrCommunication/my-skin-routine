import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/enums.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/extensions/date_extensions.dart';
import '../../../core/utils/recurrence_utils.dart';
import '../../../domain/models/action_completion.dart';
import '../../../domain/models/routine.dart';
import '../../../domain/models/routine_action.dart';
import '../../providers/profile_provider.dart';
import '../../providers/routine_providers.dart';
import '../../providers/streak_providers.dart';
import '../../theme/app_motion.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/guided_tooltip.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _tutorialShown = false;

  @override
  Widget build(BuildContext context) {
    if (!_tutorialShown) {
      _tutorialShown = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        GuidedTutorial.showIfFirstTime(
          context: context,
          tutorialKey: 'home',
          steps: [
            TutorialStep(
              icon: Icons.home_rounded,
              title: 'Votre tableau de bord',
              description: 'Retrouvez ici vos routines du jour avec les actions à compléter.',
            ),
            TutorialStep(
              icon: Icons.check_circle_outline,
              title: 'Cochez vos actions',
              description: 'Appuyez sur chaque action pour la marquer comme faite. La barre de progression se remplit !',
            ),
            TutorialStep(
              icon: Icons.local_fire_department,
              title: 'Construisez votre streak',
              description: 'Complétez toutes vos actions chaque jour pour maintenir votre série de jours consécutifs.',
            ),
          ],
        );
      });
    }

    final activeRoutinesAsync = ref.watch(activeRoutinesProvider);
    final profileAsync = ref.watch(profileProvider);
    final today = DateTime.now().toDateString();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Large AppBar with greeting and controls
          SliverAppBar.large(
            title: profileAsync.when(
              data: (profile) {
                if (profile?.firstName.isNotEmpty ?? false) {
                  return Text(context.l10n.greetingPersonalized(profile!.firstName));
                }
                return Text(context.l10n.greetingDefault);
              },
              loading: () => Text(context.l10n.greetingDefault),
              error: (_, __) => Text(context.l10n.greetingDefault),
            ),
            actions: [
              // Streak badge
              ref.watch(streakForRoutineProvider(0)).when(
                data: (streak) {
                  final days = streak?.currentStreak ?? 0;
                  if (days <= 0) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Center(
                      child: Badge(
                        label: Text('$days'),
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
                  child: EmptyState(
                    icon: Icons.spa,
                    title: context.l10n.homeEmpty,
                    subtitle: context.l10n.homeEmptySubtitle,
                    actionLabel: context.l10n.homeCreateFirst,
                    onAction: () => context.push('/routines/new'),
                  ),
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
                      index: index,
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
        label: Text(context.l10n.progressTitle),
      ).animate().scale(delay: 500.ms, duration: AppMotion.durationLong, curve: AppMotion.expressiveCurve),
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
  final int index;

  const _RoutineCard({
    required this.routine,
    required this.today,
    required this.ref,
    required this.index,
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
                            color: context.colorScheme.primary)
                            .animate()
                            .fadeIn(duration: AppMotion.durationMedium)
                            .scale(begin: const Offset(0.5, 0.5), curve: AppMotion.expressiveCurve),
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: todayActions.isEmpty
                          ? 0
                          : completedCount / todayActions.length,
                      minHeight: 8,
                    ).animate()
                      .scaleX(
                        begin: 0,
                        duration: AppMotion.durationMedium,
                        delay: (index * 50).ms,
                        curve: AppMotion.standardCurve,
                      ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    context.l10n.completedOf(completedCount, todayActions.length),
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Actions list
                  if (todayActions.isEmpty)
                    Text(
                      context.l10n.homeToday,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    )
                  else
                    Column(
                      children: List.generate(
                        todayActions.length,
                        (actionIndex) {
                          final action = todayActions[actionIndex];
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
                            index: actionIndex,
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        ).animate()
          .fadeIn(duration: AppMotion.durationMedium, delay: (index * 100).ms)
          .slideX(begin: 0.1, duration: AppMotion.durationMedium, delay: (index * 100).ms, curve: AppMotion.standardCurve);
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
  final int index;

  const _ActionItem({
    required this.action,
    required this.isCompleted,
    required this.onToggle,
    required this.index,
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
          GestureDetector(
            onTap: () {
              widget.onToggle(!widget.isCompleted);
              _animationController.forward();
            },
            child: Checkbox(
              value: widget.isCompleted,
              onChanged: (value) {
                widget.onToggle(value ?? false);
              },
            ).animate(target: widget.isCompleted ? 1 : 0)
              .scale(
                end: const Offset(1.2, 1.2),
                duration: AppMotion.durationShort,
                curve: AppMotion.expressiveCurve,
              )
              .then()
              .scale(
                begin: const Offset(1.2, 1.2),
                end: const Offset(1, 1),
                duration: AppMotion.durationShort,
                curve: AppMotion.expressiveCurve,
              ),
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


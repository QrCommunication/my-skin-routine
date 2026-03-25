import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

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
import '../../widgets/spotlight_tutorial.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _tutorialShown = false;
  final _fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    if (!_tutorialShown) {
      _tutorialShown = true;
      // Delay to let FAB animation finish before spotlight finds its position
      Future.delayed(const Duration(milliseconds: 1000), () {
        if (!mounted) return;
        SpotlightTutorial.showIfFirstTime(
          context: context,
          tutorialKey: 'home_v2',
          steps: [
            SpotlightStep(
              targetKey: _fabKey,
              title: context.l10n.tutorialHomeSkinJournalTitle,
              description: context.l10n.tutorialHomeSkinJournalDescription,
              icon: Icons.edit_note,
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
                _formatDateForDisplay(context, DateTime.now()),
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
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
                    return _RoutineSection(
                      routine: routine,
                      today: today,
                      ref: ref,
                      index: index,
                      hideWhenComplete: true,
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
                child: Text(context.l10n.commonErrorWithDetails(error.toString())),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        key: _fabKey,
        onPressed: () => context.push('/progress/journal/new'),
        icon: const Icon(Icons.edit_note_rounded),
        label: Text(context.l10n.progressTitle),
      ).animate().scale(delay: 500.ms, duration: AppMotion.durationLong, curve: AppMotion.expressiveCurve),
    );
  }

  String _formatDateForDisplay(BuildContext context, DateTime date) {
    final locale = Localizations.localeOf(context).languageCode;
    final formatter = DateFormat.MMMMEEEEd(locale);
    return formatter.format(date);
  }
}

class _RoutineSection extends ConsumerWidget {
  final Routine routine;
  final String today;
  final WidgetRef ref;
  final int index;
  final bool hideWhenComplete;

  const _RoutineSection({
    required this.routine,
    required this.today,
    required this.ref,
    required this.index,
    this.hideWhenComplete = false,
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

        // Hide completed routines from dashboard
        if (allCompleted && hideWhenComplete) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Routine header
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                routine.name,
                                style: context.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              routine.skinGoal.emoji,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          context.l10n.completedOf(completedCount, todayActions.length),
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
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
              const SizedBox(height: 8),

              // Progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: todayActions.isEmpty
                      ? 0
                      : completedCount / todayActions.length,
                  minHeight: 6,
                  backgroundColor: context.colorScheme.surfaceContainerHighest,
                  valueColor: AlwaysStoppedAnimation(
                    allCompleted
                        ? context.colorScheme.primary
                        : context.colorScheme.primary,
                  ),
                ).animate()
                  .scaleX(
                    begin: 0,
                    duration: AppMotion.durationMedium,
                    delay: (index * 50).ms,
                    curve: AppMotion.standardCurve,
                  ),
              ),
              const SizedBox(height: 12),

              // Actions list (directly visible, no collapse)
              if (todayActions.isEmpty)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: context.colorScheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    context.l10n.homeToday,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                )
              else
                Container(
                  decoration: BoxDecoration(
                    color: allCompleted
                        ? context.colorScheme.primaryContainer.withAlpha(40)
                        : context.colorScheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: List.generate(
                      todayActions.length,
                      (actionIndex) {
                        final action = todayActions[actionIndex];
                        final isCompleted = completions
                            .any((c) => c.actionId == action.id);
                        return Column(
                          children: [
                            _ActionCheckItem(
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
                            ),
                            if (actionIndex < todayActions.length - 1)
                              Divider(
                                height: 1,
                                indent: 48,
                                endIndent: 12,
                                color: context.colorScheme.outlineVariant,
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              const SizedBox(height: 12),
              Divider(
                color: context.colorScheme.outlineVariant,
              ),
            ],
          ),
        ).animate()
          .fadeIn(duration: AppMotion.durationMedium, delay: (index * 100).ms)
          .slideX(begin: 0.1, duration: AppMotion.durationMedium, delay: (index * 100).ms, curve: AppMotion.standardCurve);
      },
      loading: () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(routine.name, style: context.textTheme.titleMedium),
            const SizedBox(height: 12),
            const LinearProgressIndicator(),
            const SizedBox(height: 12),
          ],
        ),
      ),
      error: (error, st) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text(context.l10n.commonErrorWithDetails(error.toString())),
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
      ref.invalidate(completionsForDateProvider(date));
    } catch (e) {
      // Handle error silently
    }
  }
}

class _ActionCheckItem extends StatefulWidget {
  final RoutineAction action;
  final bool isCompleted;
  final Function(bool) onToggle;

  const _ActionCheckItem({
    required this.action,
    required this.isCompleted,
    required this.onToggle,
  });

  @override
  State<_ActionCheckItem> createState() => _ActionCheckItemState();
}

class _ActionCheckItemState extends State<_ActionCheckItem>
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
  void didUpdateWidget(_ActionCheckItem oldWidget) {
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
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              widget.onToggle(!widget.isCompleted);
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
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
                if (widget.action.product != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      widget.action.product!.name,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

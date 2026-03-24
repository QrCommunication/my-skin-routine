import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_skin_routine/presentation/providers/routine_providers.dart';

class RoutineDetailScreen extends ConsumerWidget {
  final int id;

  const RoutineDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routineAsync = ref.watch(routineByIdProvider(id));
    final actionsAsync = ref.watch(routineActionsProvider(id));

    return Scaffold(
      body: routineAsync.when(
        data: (routine) {
          if (routine == null) {
            return CustomScrollView(
              slivers: [
                const SliverAppBar.large(
                  title: Text('Routine non trouvée'),
                ),
                SliverFillRemaining(
                  child: Center(
                    child: Text('La routine n\'existe pas'),
                  ),
                ),
              ],
            );
          }

          return CustomScrollView(
            slivers: [
              SliverAppBar.large(
                title: Text(routine.name),
                pinned: true,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => context.push('/routines/${routine.id}/edit'),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _showDeleteConfirmation(context, ref, routine.id),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (routine.description != null) ...[
                        Text(
                          routine.description!,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 16),
                      ],
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          Chip(
                            label: Text(routine.bodyZone.localizedLabel(Localizations.localeOf(context).languageCode)),
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          )
                              .animate()
                              .fadeIn(
                                delay: 100.ms,
                                duration: 300.ms,
                              )
                              .slideX(
                                begin: -0.05,
                                delay: 100.ms,
                                duration: 300.ms,
                              ),
                          Chip(
                            avatar: Text(routine.skinGoal.emoji),
                            label: Text(routine.skinGoal.localizedLabel(Localizations.localeOf(context).languageCode)),
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          )
                              .animate()
                              .fadeIn(
                                delay: 150.ms,
                                duration: 300.ms,
                              )
                              .slideX(
                                begin: -0.05,
                                delay: 150.ms,
                                duration: 300.ms,
                              ),
                          if (routine.reminderTime != null)
                            Chip(
                              avatar: const Icon(Icons.schedule, size: 18),
                              label: Text(routine.reminderTime!),
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            )
                                .animate()
                                .fadeIn(
                                  delay: 200.ms,
                                  duration: 300.ms,
                                )
                                .slideX(
                                  begin: -0.05,
                                  delay: 200.ms,
                                  duration: 300.ms,
                                ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Actions (${routine.actions.length})',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ),
              actionsAsync.when(
                data: (actions) {
                  if (actions.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Center(
                          child: Text(
                            'Aucune action',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final action = actions[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          child: Dismissible(
                            key: Key('action_${action.id}'),
                            direction: DismissDirection.startToEnd,
                            onDismissed: (direction) async {
                              await ref.read(routineRepositoryProvider).deleteAction(action.id);
                              ref.invalidate(routineActionsProvider(id));
                            },
                            confirmDismiss: (direction) => _showDeleteActionConfirmation(context),
                            background: Container(
                              alignment: Alignment.centerLeft,
                              color: Theme.of(context).colorScheme.errorContainer,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Icon(
                                  Icons.delete,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                            ),
                            child: Card(
                              child: InkWell(
                                onTap: () => context.push('/routines/${routine.id}/actions/${action.id}/edit'),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    children: [
                                      MouseRegion(
                                        cursor: SystemMouseCursors.move,
                                        child: GestureDetector(
                                          onLongPress: () {
                                            HapticFeedback.mediumImpact();
                                          },
                                          child: const Icon(Icons.drag_handle),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              action.name,
                                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            if (action.description != null) ...[
                                              const SizedBox(height: 4),
                                              Text(
                                                action.description!,
                                                style: Theme.of(context).textTheme.bodySmall,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                            const SizedBox(height: 8),
                                            Row(
                                              children: [
                                                if (action.product != null)
                                                  Chip(
                                                    label: Text(action.product!.name),
                                                    side: BorderSide(
                                                      color: Theme.of(context).colorScheme.outline,
                                                    ),
                                                  ),
                                                const SizedBox(width: 8),
                                                Chip(
                                                  label: Text('${action.recurrenceType} x${action.recurrenceInterval}'),
                                                  side: BorderSide(
                                                    color: Theme.of(context).colorScheme.outline,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                            .animate()
                            .fadeIn(
                              delay: (index * 80).ms,
                              duration: 300.ms,
                            )
                            .slideY(
                              begin: 0.05,
                              delay: (index * 80).ms,
                              duration: 300.ms,
                            );
                      },
                      childCount: actions.length,
                    ),
                  );
                },
                loading: () => SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                ),
                error: (error, stack) => SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text('Erreur: $error'),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 80),
              ),
            ],
          );
        },
        loading: () => Scaffold(
          appBar: AppBar(),
          body: const Center(child: CircularProgressIndicator()),
        ),
        error: (error, stack) => Scaffold(
          appBar: AppBar(),
          body: Center(child: Text('Erreur: $error')),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/routines/$id/actions/new'),
        icon: const Icon(Icons.add),
        label: const Text('Nouvelle action'),
      ),
    );
  }

  Future<bool?> _showDeleteActionConfirmation(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer l\'action?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, WidgetRef ref, int routineId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer la routine?'),
        content: const Text('Cette action est irréversible.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(context);
              await ref.read(routineRepositoryProvider).deleteRoutine(routineId);
              ref.invalidate(routineListProvider);
              if (context.mounted) {
                context.pop();
              }
            },
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_skin_routine/core/constants/enums.dart';
import 'package:my_skin_routine/presentation/providers/routine_providers.dart';

class RoutineListScreen extends ConsumerStatefulWidget {
  const RoutineListScreen({super.key});

  @override
  ConsumerState<RoutineListScreen> createState() => _RoutineListScreenState();
}

class _RoutineListScreenState extends ConsumerState<RoutineListScreen> {
  SkinGoal? _selectedGoal;

  @override
  Widget build(BuildContext context) {
    final routineListAsync = ref.watch(routineListProvider);
    final selectedGoal = _selectedGoal;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text('Mes routines'),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FilterChip(
                      label: const Text('Tous'),
                      selected: selectedGoal == null,
                      onSelected: (selected) {
                        setState(() {
                          _selectedGoal = null;
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    ...SkinGoal.values.map((goal) {
                      final isSelected = selectedGoal == goal;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          avatar: Text(goal.emoji),
                          label: Text(goal.localizedLabel(Localizations.localeOf(context).languageCode)),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              _selectedGoal = selected ? goal : null;
                            });
                          },
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
          routineListAsync.when(
            data: (routines) {
              final filtered = selectedGoal == null
                  ? routines
                  : routines.where((r) => r.skinGoal == selectedGoal).toList();

              if (filtered.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.spa_outlined,
                          size: 48,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Aucune routine',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 24),
                        FilledButton.icon(
                          onPressed: () => context.push('/routines/new'),
                          icon: const Icon(Icons.add),
                          label: const Text('Créer une routine'),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final routine = filtered[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Card(
                        child: InkWell(
                          onTap: () => context.push('/routines/${routine.id}'),
                          onLongPress: () => _showOptionsBottomSheet(context, ref, routine),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        routine.name,
                                        style: Theme.of(context).textTheme.titleMedium,
                                      ),
                                    ),
                                    Consumer(
                                      builder: (context, ref, child) {
                                        return Switch(
                                          value: routine.isActive,
                                          onChanged: (value) async {
                                            final updated = routine.copyWith(isActive: value);
                                            await ref.read(routineRepositoryProvider).updateRoutine(updated);
                                            ref.invalidate(routineListProvider);
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Chip(
                                      label: Text(routine.bodyZone.localizedLabel(Localizations.localeOf(context).languageCode)),
                                      side: BorderSide(
                                        color: Theme.of(context).colorScheme.outline,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Chip(
                                      avatar: Text(routine.skinGoal.emoji),
                                      label: Text(routine.skinGoal.localizedLabel(Localizations.localeOf(context).languageCode)),
                                      side: BorderSide(
                                        color: Theme.of(context).colorScheme.outline,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Badge(
                                      label: Text('${routine.actions.length}'),
                                      child: const Icon(Icons.assignment_outlined),
                                    ),
                                  ],
                                ),
                              ],
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
                        .slideX(
                          begin: 0.05,
                          delay: (index * 80).ms,
                          duration: 300.ms,
                        );
                  },
                  childCount: filtered.length,
                ),
              );
            },
            loading: () => SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            error: (error, stack) => SliverFillRemaining(
              child: Center(
                child: Text('Erreur: $error'),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/routines/new'),
        icon: const Icon(Icons.add),
        label: const Text('Nouvelle routine'),
      ),
    );
  }

  void _showOptionsBottomSheet(BuildContext context, WidgetRef ref, dynamic routine) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Modifier'),
            onTap: () {
              Navigator.pop(context);
              context.push('/routines/${routine.id}/edit');
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.red),
            title: const Text('Supprimer', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context);
              _showDeleteConfirmation(context, ref, routine.id);
            },
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
            },
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
  }
}


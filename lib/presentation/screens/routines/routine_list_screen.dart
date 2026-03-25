import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_skin_routine/core/constants/enums.dart';
import 'package:my_skin_routine/core/extensions/context_extensions.dart';
import 'package:my_skin_routine/presentation/providers/routine_providers.dart';
import 'package:my_skin_routine/presentation/widgets/spotlight_tutorial.dart';

class RoutineListScreen extends ConsumerStatefulWidget {
  const RoutineListScreen({super.key});

  @override
  ConsumerState<RoutineListScreen> createState() => _RoutineListScreenState();
}

class _RoutineListScreenState extends ConsumerState<RoutineListScreen> {
  SkinGoal? _selectedGoal;
  bool _tutorialShown = false;
  final GlobalKey _filterChipsKey = GlobalKey();
  final GlobalKey _firstRoutineKey = GlobalKey();
  final GlobalKey _fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    if (!_tutorialShown) {
      _tutorialShown = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        SpotlightTutorial.showIfFirstTime(
          context: context,
          tutorialKey: 'routines',
          steps: [
            SpotlightStep(
              targetKey: _filterChipsKey,
              title: 'Filtrez vos routines',
              description: 'Sélectionnez un objectif cutané pour afficher uniquement les routines correspondantes.',
              icon: Icons.filter_list,
            ),
            SpotlightStep(
              targetKey: _firstRoutineKey,
              title: 'Vos routines',
              description: 'Chaque routine contient des actions : appliquer un sérum, nettoyer, etc. Activez ou désactivez une routine avec le switch.',
              icon: Icons.favorite_rounded,
            ),
            SpotlightStep(
              targetKey: _fabKey,
              title: 'Créer une nouvelle routine',
              description: 'Appuyez sur le bouton + pour créer une nouvelle routine personnalisée.',
              icon: Icons.add_circle_outline,
            ),
          ],
        );
      });
    }

    final routineListAsync = ref.watch(routineListProvider);
    final selectedGoal = _selectedGoal;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text(context.l10n.routinesTitle),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  key: _filterChipsKey,
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
                          context.l10n.routinesEmpty,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 24),
                        FilledButton.icon(
                          onPressed: () => context.push('/routines/new'),
                          icon: const Icon(Icons.add),
                          label: Text(context.l10n.routineNew),
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
                      key: index == 0 ? _firstRoutineKey : null,
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
        key: _fabKey,
        onPressed: () => context.push('/routines/new'),
        icon: const Icon(Icons.add),
        label: Text(context.l10n.routineNew),
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
            title: Text(context.l10n.commonEdit),
            onTap: () {
              Navigator.pop(context);
              context.push('/routines/${routine.id}/edit');
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.red),
            title: Text(context.l10n.commonDelete, style: const TextStyle(color: Colors.red)),
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
        title: Text(context.l10n.routineDelete),
        content: const Text('Cette action est irréversible.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(context.l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(context);
              await ref.read(routineRepositoryProvider).deleteRoutine(routineId);
              ref.invalidate(routineListProvider);
            },
            child: Text(context.l10n.commonDelete),
          ),
        ],
      ),
    );
  }
}


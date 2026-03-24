import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_skin_routine/presentation/providers/journal_providers.dart';
import 'package:my_skin_routine/presentation/providers/routine_providers.dart';
import 'package:my_skin_routine/presentation/providers/streak_providers.dart';

class ProgressScreen extends ConsumerStatefulWidget {
  const ProgressScreen({super.key});

  @override
  ConsumerState<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends ConsumerState<ProgressScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suivi'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Calendrier'),
            Tab(text: 'Streaks'),
            Tab(text: 'Journal'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _CalendarTab(),
          _StreaksTab(),
          _JournalTab(),
        ],
      ),
    );
  }
}

class _CalendarTab extends ConsumerStatefulWidget {
  const _CalendarTab();

  @override
  ConsumerState<_CalendarTab> createState() => _CalendarTabState();
}

class _CalendarTabState extends ConsumerState<_CalendarTab> {
  late DateTime _selectedMonth;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedMonth = DateTime(now.year, now.month, 1);
  }

  void _previousMonth() {
    setState(() {
      _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month - 1, 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month + 1, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _previousMonth,
              ),
              Text(
                '${_selectedMonth.month}/${_selectedMonth.year}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: _nextMonth,
              ),
            ],
          ),
        ),
        Expanded(
          child: _CalendarGrid(
            year: _selectedMonth.year,
            month: _selectedMonth.month,
          ),
        ),
      ],
    );
  }
}

class _CalendarGrid extends ConsumerWidget {
  final int year;
  final int month;

  const _CalendarGrid({required this.year, required this.month});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final journalEntriesAsync = ref.watch(
      journalEntriesForMonthProvider((year: year, month: month)),
    );

    return journalEntriesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Erreur: $error')),
      data: (entries) {
        final entriesByDate = {
          for (final entry in entries) entry.date: entry,
        };

        final firstDay = DateTime(year, month, 1);
        final lastDay = DateTime(year, month + 1, 0);
        final daysInMonth = lastDay.day;
        final firstWeekday = firstDay.weekday % 7;

        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: firstWeekday + daysInMonth,
          itemBuilder: (context, index) {
            if (index < firstWeekday) {
              return Container();
            }

            final dayOfMonth = index - firstWeekday + 1;
            final dateStr =
                '${year}-${month.toString().padLeft(2, '0')}-${dayOfMonth.toString().padLeft(2, '0')}';
            final cellDate = DateTime(year, month, dayOfMonth);
            final entry = entriesByDate[dateStr];
            final isFuture = cellDate.isAfter(today);

            Color getCellColor() {
              if (isFuture) {
                return Colors.grey.withOpacity(0.2);
              }
              if (entry != null) {
                return Theme.of(context).colorScheme.primary;
              }
              return Theme.of(context).colorScheme.surface;
            }

            return GestureDetector(
              onTap: isFuture
                  ? null
                  : () {
                      _showDayDetailsBottomSheet(context, dateStr, entry);
                    },
              child: Container(
                decoration: BoxDecoration(
                  color: getCellColor(),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                child: Center(
                  child: Text(
                    dayOfMonth.toString(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isFuture ? Colors.grey : Colors.black,
                        ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showDayDetailsBottomSheet(
    BuildContext context,
    String dateStr,
    dynamic entry,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Détails du $dateStr',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              if (entry != null) ...[
                Text('Notes: ${entry.notes}'),
                if (entry.photoPath != null)
                  Text('Photo: ${entry.photoPath}'),
                Text('Feeling: ${entry.skinFeeling}/5'),
              ] else ...[
                const Text('Aucune entrée journal pour ce jour.'),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _StreaksTab extends ConsumerWidget {
  const _StreaksTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routinesAsync = ref.watch(routineListProvider);

    return routinesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Erreur: $error')),
      data: (routines) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (routines.isNotEmpty) ...[
              _BestStreakCard(routines: routines),
              const SizedBox(height: 24),
              Text(
                'Streaks par routine',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
            ],
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: routines.length,
              itemBuilder: (context, index) {
                return _RoutineStreakCard(routine: routines[index]);
              },
            ),
          ],
        );
      },
    );
  }
}

class _BestStreakCard extends ConsumerWidget {
  final List<dynamic> routines;

  const _BestStreakCard({required this.routines});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<dynamic>>(
      future: Future.wait(
        routines.map((r) => ref.read(streakForRoutineProvider(r.id).future)),
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: const CircularProgressIndicator(),
            ),
          );
        }

        final streaks = snapshot.data!.whereType<dynamic>().toList();
        if (streaks.isEmpty) {
          return const SizedBox.shrink();
        }

        final bestStreak = streaks.fold<int>(
          0,
          (max, streak) => streak.currentStreak > max ? streak.currentStreak : max,
        );

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Text('🔥', style: TextStyle(fontSize: 32)),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Meilleur Streak'),
                    Text(
                      '$bestStreak jours',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _RoutineStreakCard extends ConsumerWidget {
  final dynamic routine;

  const _RoutineStreakCard({required this.routine});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streakAsync = ref.watch(streakForRoutineProvider(routine.id));

    return streakAsync.when(
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: CircularProgressIndicator(),
      ),
      error: (error, stack) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text('Erreur: $error'),
      ),
      data: (streak) {
        if (streak == null) {
          return const SizedBox.shrink();
        }
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    routine.name,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Actuel: ${streak.currentStreak} jours'),
                    Text('Meilleur: ${streak.bestStreak} jours'),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _JournalTab extends ConsumerWidget {
  const _JournalTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entriesAsync = ref.watch(journalEntriesProvider);

    return entriesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Erreur: $error')),
      data: (entries) {
        final sortedEntries = List.from(entries)
          ..sort((a, b) => b.date.compareTo(a.date));

        return Stack(
          children: [
            if (sortedEntries.isEmpty)
              const Center(child: Text('Aucune entrée journal'))
            else
              ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: sortedEntries.length,
                itemBuilder: (context, index) {
                  final entry = sortedEntries[index];
                  return _JournalEntryCard(
                    entry: entry,
                    onTap: () {
                      context.push('/progress/journal/${entry.id}');
                    },
                  );
                },
              ),
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                onPressed: () {
                  context.push('/progress/journal/new');
                },
                child: const Icon(Icons.add),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _JournalEntryCard extends StatelessWidget {
  final dynamic entry;
  final VoidCallback onTap;

  const _JournalEntryCard({
    required this.entry,
    required this.onTap,
  });

  String _getFeelingEmoji(int feeling) {
    switch (feeling) {
      case 1:
        return '😣';
      case 2:
        return '😕';
      case 3:
        return '😐';
      case 4:
        return '😊';
      case 5:
        return '🤩';
      default:
        return '😐';
    }
  }

  @override
  Widget build(BuildContext context) {
    final notePreview = entry.notes.length > 100
        ? '${entry.notes.substring(0, 100)}...'
        : entry.notes;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    entry.date,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    _getFeelingEmoji(entry.skinFeeling),
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
              if (entry.photoPath != null) ...[
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    entry.photoPath as dynamic,
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
              const SizedBox(height: 8),
              Text(
                notePreview,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

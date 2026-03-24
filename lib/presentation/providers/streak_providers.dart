import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:my_skin_routine/core/utils/streak_calculator.dart';
import 'package:my_skin_routine/domain/models/streak_info.dart';
import 'package:my_skin_routine/presentation/providers/routine_providers.dart';

part 'streak_providers.g.dart';

@riverpod
Future<StreakInfo?> streakForRoutine(Ref ref, int routineId) async {
  final routine = await ref.watch(routineByIdProvider(routineId).future);
  if (routine == null) return null;

  final routineActions = await ref.watch(routineActionsProvider(routineId).future);
  final repository = ref.watch(routineRepositoryProvider);

  final actionIds = routineActions.map((a) => a.id).toList();
  if (actionIds.isEmpty) {
    return null;
  }

  final completions = await repository.getCompletionsForActions(actionIds);

  final actions = routineActions
      .map((action) => (
            id: action.id,
            recurrenceType: action.recurrenceType,
            recurrenceInterval: action.recurrenceInterval,
            recurrenceStartDate: action.recurrenceStartDate,
          ))
      .toList();

  final currentStreak = calculateCurrentStreak(
    actions: actions,
    completions: completions,
    today: DateTime.now(),
  );

  final bestStreak = calculateBestStreak(
    actions: actions,
    completions: completions,
    today: DateTime.now(),
  );

  return StreakInfo(
    routineId: routineId,
    routineName: routine.name,
    currentStreak: currentStreak,
    bestStreak: bestStreak,
  );
}

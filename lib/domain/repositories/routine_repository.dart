import '../models/routine.dart';
import '../models/routine_action.dart';
import '../models/action_completion.dart';

abstract class RoutineRepository {
  Stream<List<Routine>> watchAllRoutines();
  Future<List<Routine>> getAllRoutines();
  Future<Routine?> getRoutineById(int id);
  Stream<List<Routine>> watchActiveRoutines();
  Future<int> createRoutine({
    required String name,
    String? description,
    required String bodyZone,
    required String skinGoal,
    String? reminderTime,
    bool isActive = true,
  });
  Future<void> updateRoutine(Routine routine);
  Future<void> deleteRoutine(int id);

  Future<List<RoutineAction>> getActionsForRoutine(int routineId);
  Stream<List<RoutineAction>> watchActionsForRoutine(int routineId);
  Future<int> createAction({
    required int routineId,
    required String name,
    String? description,
    int? productId,
    required String recurrenceType,
    required int recurrenceInterval,
    required String recurrenceStartDate,
  });
  Future<void> updateAction(RoutineAction action);
  Future<void> deleteAction(int id);
  Future<void> reorderActions(List<({int id, int sortOrder})> updates);
  Future<void> reorderRoutines(List<({int id, int sortOrder})> updates);

  Future<void> markActionCompleted(int actionId, String date);
  Future<void> unmarkActionCompleted(int actionId, String date);
  Stream<List<ActionCompletion>> watchCompletionsForDate(String date);
  Future<Map<int, Set<String>>> getCompletionsForActions(List<int> actionIds);
  Future<int> countActionsForProduct(int productId);
}

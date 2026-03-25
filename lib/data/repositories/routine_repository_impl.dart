import 'package:drift/drift.dart';
import 'package:my_skin_routine/core/constants/enums.dart';
import 'package:my_skin_routine/data/database/app_database.dart';
import 'package:my_skin_routine/data/database/tables/actions_table.dart';
import 'package:my_skin_routine/data/database/tables/action_completions_table.dart';
import 'package:my_skin_routine/data/database/tables/routines_table.dart';
import 'package:my_skin_routine/domain/models/action_completion.dart';
import 'package:my_skin_routine/domain/models/product.dart';
import 'package:my_skin_routine/domain/models/routine.dart';
import 'package:my_skin_routine/domain/models/routine_action.dart';
import 'package:my_skin_routine/domain/repositories/routine_repository.dart';

class RoutineRepositoryImpl implements RoutineRepository {
  final AppDatabase _database;

  RoutineRepositoryImpl(this._database);

  @override
  Stream<List<Routine>> watchAllRoutines() {
    return _database.routineDao.watchAllRoutines().asyncMap(
          (rows) async {
            final routines = <Routine>[];
            for (final row in rows) {
              final actions = await getActionsForRoutine(row.id);
              routines.add(_routineRowToRoutine(row).copyWith(actions: actions));
            }
            return routines;
          },
        );
  }

  @override
  Future<List<Routine>> getAllRoutines() async {
    final rows = await _database.routineDao.getAllRoutines();
    final routines = <Routine>[];
    for (final row in rows) {
      final actions = await getActionsForRoutine(row.id);
      routines.add(_routineRowToRoutine(row).copyWith(actions: actions));
    }
    return routines;
  }

  @override
  Future<Routine?> getRoutineById(int id) async {
    final row = await _database.routineDao.getRoutineById(id);
    if (row == null) return null;

    final actions = await getActionsForRoutine(id);
    return _routineRowToRoutine(row).copyWith(actions: actions);
  }

  @override
  Stream<List<Routine>> watchActiveRoutines() {
    return _database.routineDao.watchActiveRoutines().asyncMap(
          (rows) async {
            final routines = <Routine>[];
            for (final row in rows) {
              final actions = await getActionsForRoutine(row.id);
              routines.add(_routineRowToRoutine(row).copyWith(actions: actions));
            }
            return routines;
          },
        );
  }

  @override
  Future<int> createRoutine({
    required String name,
    String? description,
    required String bodyZone,
    required String skinGoal,
    String? reminderTime,
    bool isActive = true,
  }) {
    final now = DateTime.now().millisecondsSinceEpoch;
    return _database.routineDao.insertRoutine(
      RoutinesCompanion(
        name: Value(name),
        description:
            description != null ? Value(description) : const Value.absent(),
        bodyZone: Value(bodyZone),
        skinGoal: Value(skinGoal),
        reminderTime:
            reminderTime != null ? Value(reminderTime) : const Value.absent(),
        isActive: Value(isActive),
        createdAt: Value(now),
        updatedAt: Value(now),
      ),
    );
  }

  @override
  Future<void> updateRoutine(Routine routine) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await _database.routineDao.updateRoutine(
      RoutinesCompanion(
        id: Value(routine.id),
        name: Value(routine.name),
        description: routine.description != null
            ? Value(routine.description!)
            : const Value.absent(),
        bodyZone: Value(routine.bodyZone.name),
        skinGoal: Value(routine.skinGoal.name),
        reminderTime: routine.reminderTime != null
            ? Value(routine.reminderTime!)
            : const Value.absent(),
        isActive: Value(routine.isActive),
        createdAt: Value(routine.createdAt.millisecondsSinceEpoch),
        updatedAt: Value(now),
      ),
    );
  }

  @override
  Future<void> deleteRoutine(int id) {
    return _database.routineDao.deleteRoutineById(id);
  }

  @override
  Future<List<RoutineAction>> getActionsForRoutine(int routineId) async {
    final rows = await _database.actionDao.getActionsForRoutine(routineId);
    return rows.map(_actionRowToRoutineAction).toList();
  }

  @override
  Stream<List<RoutineAction>> watchActionsForRoutine(int routineId) {
    return _database.actionDao.watchActionsForRoutine(routineId).map(
          (rows) => rows.map(_actionRowToRoutineAction).toList(),
        );
  }

  @override
  Future<int> createAction({
    required int routineId,
    required String name,
    String? description,
    int? productId,
    required String recurrenceType,
    required int recurrenceInterval,
    required String recurrenceStartDate,
  }) async {
    final existingActions = await _database.actionDao.getActionsForRoutine(routineId);
    final maxSortOrder = existingActions.isNotEmpty
        ? existingActions.fold<int>(0, (max, action) => action.sortOrder > max ? action.sortOrder : max)
        : 0;
    final sortOrder = maxSortOrder + 1;

    return _database.actionDao.insertAction(
      ActionsCompanion(
        routineId: Value(routineId),
        name: Value(name),
        description:
            description != null ? Value(description) : const Value.absent(),
        productId: productId != null ? Value(productId) : const Value.absent(),
        sortOrder: Value(sortOrder),
        recurrenceType: Value(recurrenceType),
        recurrenceInterval: Value(recurrenceInterval),
        recurrenceStartDate: Value(recurrenceStartDate),
        createdAt: Value(DateTime.now().millisecondsSinceEpoch),
      ),
    );
  }

  @override
  Future<void> updateAction(RoutineAction action) async {
    await _database.actionDao.updateAction(
      ActionsCompanion(
        id: Value(action.id),
        routineId: Value(action.routineId),
        name: Value(action.name),
        description: action.description != null
            ? Value(action.description!)
            : const Value.absent(),
        productId:
            action.productId != null ? Value(action.productId!) : const Value.absent(),
        sortOrder: Value(action.sortOrder),
        recurrenceType: Value(action.recurrenceType.name),
        recurrenceInterval: Value(action.recurrenceInterval),
        recurrenceStartDate: Value(action.recurrenceStartDate),
        createdAt: Value(action.createdAt.millisecondsSinceEpoch),
      ),
    );
  }

  @override
  Future<void> deleteAction(int id) {
    return _database.actionDao.deleteActionById(id);
  }

  @override
  Future<void> reorderActions(List<({int id, int sortOrder})> updates) {
    return _database.actionDao.updateSortOrders(updates);
  }

  @override
  Future<void> reorderRoutines(List<({int id, int sortOrder})> updates) {
    return _database.routineDao.updateSortOrders(updates);
  }

  @override
  Future<void> markActionCompleted(int actionId, String date) {
    return _database.actionDao.markCompleted(actionId, date);
  }

  @override
  Future<void> unmarkActionCompleted(int actionId, String date) {
    return _database.actionDao.unmarkCompleted(actionId, date).then((_) {});
  }

  @override
  Stream<List<ActionCompletion>> watchCompletionsForDate(String date) {
    return _database.actionDao
        .watchCompletionsForDate(date)
        .map((rows) => rows.map((row) {
              return ActionCompletion(
                actionId: row.actionId,
                completedDate: row.completedDate,
                completedAt:
                    DateTime.fromMillisecondsSinceEpoch(row.completedAt),
              );
            }).toList());
  }

  @override
  Future<Map<int, Set<String>>> getCompletionsForActions(
      List<int> actionIds) {
    return _database.actionDao.getCompletionsForActions(actionIds);
  }

  @override
  Future<int> countActionsForProduct(int productId) {
    return _database.actionDao.countActionsForProduct(productId);
  }

  Routine _routineRowToRoutine(RoutineRow row) {
    return Routine(
      id: row.id,
      name: row.name,
      description: row.description,
      bodyZone: BodyZone.values.byName(row.bodyZone),
      skinGoal: SkinGoal.values.byName(row.skinGoal),
      reminderTime: row.reminderTime,
      isActive: row.isActive,
      createdAt: DateTime.fromMillisecondsSinceEpoch(row.createdAt),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(row.updatedAt),
    );
  }

  RoutineAction _actionRowToRoutineAction(ActionRow row) {
    return RoutineAction(
      id: row.id,
      routineId: row.routineId,
      productId: row.productId,
      name: row.name,
      description: row.description,
      sortOrder: row.sortOrder,
      recurrenceType:
          RecurrenceType.values.byName(row.recurrenceType),
      recurrenceInterval: row.recurrenceInterval,
      recurrenceStartDate: row.recurrenceStartDate,
      createdAt: DateTime.fromMillisecondsSinceEpoch(row.createdAt),
    );
  }

}

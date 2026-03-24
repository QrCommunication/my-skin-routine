import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/actions_table.dart';
import '../tables/action_completions_table.dart';
import '../tables/products_table.dart';

part 'action_dao.g.dart';

@DriftAccessor(tables: [Actions, ActionCompletions, Products])
class ActionDao extends DatabaseAccessor<AppDatabase> with _$ActionDaoMixin {
  ActionDao(super.db);

  Stream<List<ActionRow>> watchActionsForRoutine(int routineId) =>
      (select(actions)
            ..where((t) => t.routineId.equals(routineId))
            ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
          .watch();

  Future<List<ActionRow>> getActionsForRoutine(int routineId) =>
      (select(actions)
            ..where((t) => t.routineId.equals(routineId))
            ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
          .get();

  Future<int> insertAction(ActionsCompanion entry) =>
      into(actions).insert(entry);

  Future<bool> updateAction(ActionsCompanion entry) =>
      update(actions).replace(entry);

  Future<int> deleteActionById(int id) =>
      (delete(actions)..where((t) => t.id.equals(id))).go();

  Future<void> updateSortOrders(
      List<({int id, int sortOrder})> updates) async {
    await transaction(() async {
      for (final item in updates) {
        await (update(actions)..where((t) => t.id.equals(item.id)))
            .write(ActionsCompanion(sortOrder: Value(item.sortOrder)));
      }
    });
  }

  Future<void> markCompleted(int actionId, String date) =>
      into(actionCompletions).insertOnConflictUpdate(
        ActionCompletionsCompanion(
          actionId: Value(actionId),
          completedDate: Value(date),
          completedAt: Value(DateTime.now().millisecondsSinceEpoch),
        ),
      );

  Future<int> unmarkCompleted(int actionId, String date) =>
      (delete(actionCompletions)
            ..where((t) =>
                t.actionId.equals(actionId) & t.completedDate.equals(date)))
          .go();

  Stream<List<ActionCompletionEntry>> watchCompletionsForDate(String date) =>
      (select(actionCompletions)
            ..where((t) => t.completedDate.equals(date)))
          .watch();

  Future<List<String>> getCompletionDatesForRoutine(int routineId) async {
    final query = select(actionCompletions).join([
      innerJoin(
        actions,
        actions.id.equalsExp(actionCompletions.actionId),
      ),
    ])
      ..where(actions.routineId.equals(routineId));

    final results = await query.get();
    return results
        .map((row) => row.read(actionCompletions.completedDate)!)
        .toSet()
        .toList()
      ..sort((a, b) => b.compareTo(a));
  }

  Future<Map<int, Set<String>>> getCompletionsForActions(
      List<int> actionIds) async {
    if (actionIds.isEmpty) {
      return {};
    }

    final completions = await (select(actionCompletions)
          ..where((t) => t.actionId.isIn(actionIds)))
        .get();

    final result = <int, Set<String>>{};
    for (final completion in completions) {
      result
          .putIfAbsent(completion.actionId, () => {})
          .add(completion.completedDate);
    }
    return result;
  }

  Future<int> countActionsForProduct(int productId) async {
    final count = countAll();
    final query = selectOnly(actions)
      ..addColumns([count])
      ..where(actions.productId.equals(productId));

    final result = await query.getSingle();
    return result.read(count)!;
  }
}

import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/routines_table.dart';

part 'routine_dao.g.dart';

@DriftAccessor(tables: [Routines])
class RoutineDao extends DatabaseAccessor<AppDatabase> with _$RoutineDaoMixin {
  RoutineDao(super.db);

  Stream<List<RoutineRow>> watchAllRoutines() =>
      (select(routines)..orderBy([(t) => OrderingTerm.asc(t.sortOrder), (t) => OrderingTerm.asc(t.name)])).watch();

  Future<List<RoutineRow>> getAllRoutines() =>
      (select(routines)..orderBy([(t) => OrderingTerm.asc(t.sortOrder), (t) => OrderingTerm.asc(t.name)])).get();

  Future<RoutineRow?> getRoutineById(int id) =>
      (select(routines)..where((t) => t.id.equals(id))).getSingleOrNull();

  Stream<List<RoutineRow>> watchActiveRoutines() =>
      (select(routines)
            ..where((t) => t.isActive.equals(true))
            ..orderBy([(t) => OrderingTerm.asc(t.sortOrder), (t) => OrderingTerm.asc(t.name)]))
          .watch();

  Future<int> insertRoutine(RoutinesCompanion entry) =>
      into(routines).insert(entry);

  Future<bool> updateRoutine(RoutinesCompanion entry) =>
      update(routines).replace(entry);

  Future<int> deleteRoutineById(int id) =>
      (delete(routines)..where((t) => t.id.equals(id))).go();

  Future<void> updateSortOrders(List<({int id, int sortOrder})> updates) {
    return transaction(() async {
      for (final item in updates) {
        await (update(routines)..where((t) => t.id.equals(item.id)))
            .write(RoutinesCompanion(sortOrder: Value(item.sortOrder)));
      }
    });
  }
}

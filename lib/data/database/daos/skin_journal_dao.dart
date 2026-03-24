import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/skin_journal_table.dart';

part 'skin_journal_dao.g.dart';

@DriftAccessor(tables: [SkinJournal])
class SkinJournalDao extends DatabaseAccessor<AppDatabase>
    with _$SkinJournalDaoMixin {
  SkinJournalDao(super.db);

  Stream<List<SkinJournalRow>> watchAllEntries() =>
      (select(skinJournal)..orderBy([(t) => OrderingTerm.desc(t.date)]))
          .watch();

  Future<SkinJournalRow?> getEntryByDate(String date) =>
      (select(skinJournal)..where((t) => t.date.equals(date))).getSingleOrNull();

  Future<SkinJournalRow?> getEntryById(int id) =>
      (select(skinJournal)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<int> insertEntry(SkinJournalCompanion entry) =>
      into(skinJournal).insert(entry);

  Future<bool> updateEntry(SkinJournalCompanion entry) =>
      update(skinJournal).replace(entry);

  Future<int> deleteEntryById(int id) =>
      (delete(skinJournal)..where((t) => t.id.equals(id))).go();

  Future<List<SkinJournalRow>> getEntriesForMonth(
      int year, int month) async {
    final startDate = DateTime(year, month, 1);
    final endDate = DateTime(year, month + 1, 1)
        .subtract(const Duration(days: 1));

    final startDateStr = startDate.toIso8601String().split('T')[0];
    final endDateStr = endDate.toIso8601String().split('T')[0];

    return (select(skinJournal)
          ..where((t) =>
              t.date.isBiggerOrEqualValue(startDateStr) &
              t.date.isSmallerOrEqualValue(endDateStr))
          ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get();
  }
}

import 'package:drift/drift.dart';
import 'package:my_skin_routine/data/database/app_database.dart';
import 'package:my_skin_routine/domain/models/skin_journal_entry.dart';
import 'package:my_skin_routine/domain/repositories/skin_journal_repository.dart';

class SkinJournalRepositoryImpl implements SkinJournalRepository {
  final AppDatabase _database;

  SkinJournalRepositoryImpl(this._database);

  @override
  Stream<List<SkinJournalEntry>> watchAllEntries() {
    return _database.skinJournalDao.watchAllEntries().map(
          (rows) => rows.map(_rowToSkinJournalEntry).toList(),
        );
  }

  @override
  Future<SkinJournalEntry?> getEntryById(int id) async {
    final row = await _database.skinJournalDao.getEntryById(id);
    return row != null ? _rowToSkinJournalEntry(row) : null;
  }

  @override
  Future<SkinJournalEntry?> getEntryByDate(String date) async {
    final row = await _database.skinJournalDao.getEntryByDate(date);
    return row != null ? _rowToSkinJournalEntry(row) : null;
  }

  @override
  Future<List<SkinJournalEntry>> getEntriesForMonth(int year, int month) async {
    final rows = await _database.skinJournalDao.getEntriesForMonth(year, month);
    return rows.map(_rowToSkinJournalEntry).toList();
  }

  @override
  Future<int> createEntry({
    required String date,
    String? photoPath,
    required String notes,
    required int skinFeeling,
  }) {
    return _database.skinJournalDao.insertEntry(
      SkinJournalCompanion(
        date: Value(date),
        photoPath:
            photoPath != null ? Value(photoPath) : const Value.absent(),
        notes: Value(notes),
        skinFeeling: Value(skinFeeling),
        createdAt: Value(DateTime.now().millisecondsSinceEpoch),
      ),
    );
  }

  @override
  Future<void> updateEntry(SkinJournalEntry entry) {
    return _database.skinJournalDao.updateEntry(
      SkinJournalCompanion(
        id: Value(entry.id),
        date: Value(entry.date),
        photoPath: entry.photoPath != null
            ? Value(entry.photoPath!)
            : const Value.absent(),
        notes: Value(entry.notes),
        skinFeeling: Value(entry.skinFeeling),
        createdAt: Value(entry.createdAt.millisecondsSinceEpoch),
      ),
    );
  }

  @override
  Future<void> deleteEntry(int id) {
    return _database.skinJournalDao.deleteEntryById(id);
  }

  SkinJournalEntry _rowToSkinJournalEntry(SkinJournalRow row) {
    return SkinJournalEntry(
      id: row.id,
      date: row.date,
      photoPath: row.photoPath,
      notes: row.notes,
      skinFeeling: row.skinFeeling,
      createdAt: DateTime.fromMillisecondsSinceEpoch(row.createdAt),
    );
  }
}

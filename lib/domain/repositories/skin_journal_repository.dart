import '../models/skin_journal_entry.dart';

abstract class SkinJournalRepository {
  Stream<List<SkinJournalEntry>> watchAllEntries();
  Future<SkinJournalEntry?> getEntryById(int id);
  Future<SkinJournalEntry?> getEntryByDate(String date);
  Future<List<SkinJournalEntry>> getEntriesForMonth(int year, int month);
  Future<int> createEntry({
    required String date,
    String? photoPath,
    required String notes,
    required int skinFeeling,
  });
  Future<void> updateEntry(SkinJournalEntry entry);
  Future<void> deleteEntry(int id);
}

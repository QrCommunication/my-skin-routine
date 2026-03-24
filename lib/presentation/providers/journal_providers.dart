import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:my_skin_routine/data/repositories/skin_journal_repository_impl.dart';
import 'package:my_skin_routine/domain/models/skin_journal_entry.dart';
import 'package:my_skin_routine/domain/repositories/skin_journal_repository.dart';
import 'package:my_skin_routine/presentation/providers/database_provider.dart';

part 'journal_providers.g.dart';

@riverpod
SkinJournalRepository skinJournalRepository(Ref ref) {
  final database = ref.watch(appDatabaseProvider);
  return SkinJournalRepositoryImpl(database);
}

@riverpod
class JournalEntries extends _$JournalEntries {
  @override
  Future<List<SkinJournalEntry>> build() async {
    final repository = ref.watch(skinJournalRepositoryProvider);
    final entries = await repository.getEntriesForMonth(
      DateTime.now().year,
      DateTime.now().month,
    );
    return entries;
  }

  Future<void> deleteEntry(int id) async {
    final repository = ref.watch(skinJournalRepositoryProvider);
    await repository.deleteEntry(id);
    ref.invalidateSelf();
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}

@riverpod
Future<SkinJournalEntry?> journalEntryById(Ref ref, int id) async {
  final repository = ref.watch(skinJournalRepositoryProvider);
  return repository.getEntryById(id);
}

@riverpod
Future<List<SkinJournalEntry>> journalEntriesForMonth(
  Ref ref,
  ({int year, int month}) period,
) async {
  final repository = ref.watch(skinJournalRepositoryProvider);
  return repository.getEntriesForMonth(period.year, period.month);
}

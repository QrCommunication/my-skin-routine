import 'package:freezed_annotation/freezed_annotation.dart';

part 'skin_journal_entry.freezed.dart';
part 'skin_journal_entry.g.dart';

@freezed
abstract class SkinJournalEntry with _$SkinJournalEntry {
  const factory SkinJournalEntry({
    required int id,
    required String date,
    String? photoPath,
    required String notes,
    required int skinFeeling,
    required DateTime createdAt,
  }) = _SkinJournalEntry;

  factory SkinJournalEntry.fromJson(Map<String, dynamic> json) => _$SkinJournalEntryFromJson(json);
}

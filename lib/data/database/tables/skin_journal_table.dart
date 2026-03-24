import 'package:drift/drift.dart';

@DataClassName('SkinJournalRow')
class SkinJournal extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get date => text()();
  TextColumn get photoPath => text().nullable()();
  TextColumn get notes => text()();
  IntColumn get skinFeeling => integer()();
  IntColumn get createdAt => integer()();
}

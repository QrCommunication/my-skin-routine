import 'package:drift/drift.dart';

@DataClassName('ProductRow')
class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get brand => text().withLength(min: 1, max: 100)();
  TextColumn get type => text()();
  TextColumn get photoPath => text().nullable()();
  TextColumn get notes => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
}

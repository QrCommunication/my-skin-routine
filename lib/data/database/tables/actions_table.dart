import 'package:drift/drift.dart';
import 'routines_table.dart';
import 'products_table.dart';

@DataClassName('ActionRow')
class Actions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get routineId => integer().references(Routines, #id, onDelete: KeyAction.cascade)();
  IntColumn get productId => integer().nullable().references(Products, #id, onDelete: KeyAction.setNull)();
  TextColumn get name => text().withLength(min: 1, max: 200)();
  TextColumn get description => text().nullable()();
  IntColumn get sortOrder => integer()();
  TextColumn get recurrenceType => text().withDefault(const Constant('daily'))();
  IntColumn get recurrenceInterval => integer().withDefault(const Constant(1))();
  TextColumn get recurrenceStartDate => text()();
  IntColumn get createdAt => integer()();
}

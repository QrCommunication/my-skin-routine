import 'package:drift/drift.dart';
import 'actions_table.dart';

@DataClassName('ActionCompletionEntry')
class ActionCompletions extends Table {
  IntColumn get actionId => integer().references(Actions, #id, onDelete: KeyAction.cascade)();
  TextColumn get completedDate => text()();
  IntColumn get completedAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => {actionId, completedDate};
}

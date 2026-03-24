import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables/products_table.dart';
import 'tables/routines_table.dart';
import 'tables/actions_table.dart';
import 'tables/action_completions_table.dart';
import 'tables/skin_journal_table.dart';
import 'daos/product_dao.dart';
import 'daos/routine_dao.dart';
import 'daos/action_dao.dart';
import 'daos/skin_journal_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [Products, Routines, Actions, ActionCompletions, SkinJournal],
  daos: [ProductDao, RoutineDao, ActionDao, SkinJournalDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Future migrations here
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'my_skin_routine.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

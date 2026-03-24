// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_dao.dart';

// ignore_for_file: type=lint
mixin _$ActionDaoMixin on DatabaseAccessor<AppDatabase> {
  $RoutinesTable get routines => attachedDatabase.routines;
  $ProductsTable get products => attachedDatabase.products;
  $ActionsTable get actions => attachedDatabase.actions;
  $ActionCompletionsTable get actionCompletions =>
      attachedDatabase.actionCompletions;
  ActionDaoManager get managers => ActionDaoManager(this);
}

class ActionDaoManager {
  final _$ActionDaoMixin _db;
  ActionDaoManager(this._db);
  $$RoutinesTableTableManager get routines =>
      $$RoutinesTableTableManager(_db.attachedDatabase, _db.routines);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db.attachedDatabase, _db.products);
  $$ActionsTableTableManager get actions =>
      $$ActionsTableTableManager(_db.attachedDatabase, _db.actions);
  $$ActionCompletionsTableTableManager get actionCompletions =>
      $$ActionCompletionsTableTableManager(
        _db.attachedDatabase,
        _db.actionCompletions,
      );
}

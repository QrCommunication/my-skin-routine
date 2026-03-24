import 'dart:convert';
import 'dart:io';
import 'package:archive/archive.dart';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:my_skin_routine/data/database/app_database.dart';
import 'package:my_skin_routine/domain/repositories/export_import_repository.dart';

class ExportImportRepositoryImpl implements ExportImportRepository {
  final AppDatabase _database;

  ExportImportRepositoryImpl(this._database);

  @override
  Future<String> exportData() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final tempDir = await getTemporaryDirectory();

    final allProducts = await _database.productDao.getAllProducts();
    final allRoutines = await _database.routineDao.getAllRoutines();
    final allActions = await _database.actionDao.getActionsForRoutine(-1);
    final allCompletions =
        await _database.select(_database.actionCompletions).get();
    final allJournalEntries =
        await _database.select(_database.skinJournal).get();

    final exportDate = DateTime.now().toIso8601String();

    final dataJson = {
      'version': 1,
      'exportedAt': exportDate,
      'products': allProducts
          .map((p) => {
                'id': p.id,
                'name': p.name,
                'brand': p.brand,
                'type': p.type,
                'photoPath': p.photoPath,
                'notes': p.notes,
                'createdAt': p.createdAt,
                'updatedAt': p.updatedAt,
              })
          .toList(),
      'routines': allRoutines
          .map((r) => {
                'id': r.id,
                'name': r.name,
                'description': r.description,
                'bodyZone': r.bodyZone,
                'skinGoal': r.skinGoal,
                'reminderTime': r.reminderTime,
                'isActive': r.isActive,
                'createdAt': r.createdAt,
                'updatedAt': r.updatedAt,
              })
          .toList(),
      'actions': allActions
          .map((a) => {
                'id': a.id,
                'routineId': a.routineId,
                'productId': a.productId,
                'name': a.name,
                'description': a.description,
                'sortOrder': a.sortOrder,
                'recurrenceType': a.recurrenceType,
                'recurrenceInterval': a.recurrenceInterval,
                'recurrenceStartDate': a.recurrenceStartDate,
                'createdAt': a.createdAt,
              })
          .toList(),
      'completions': allCompletions
          .map((c) => {
                'actionId': c.actionId,
                'completedDate': c.completedDate,
                'completedAt': c.completedAt,
              })
          .toList(),
      'journal': allJournalEntries
          .map((j) => {
                'id': j.id,
                'date': j.date,
                'photoPath': j.photoPath,
                'notes': j.notes,
                'skinFeeling': j.skinFeeling,
                'createdAt': j.createdAt,
              })
          .toList(),
    };

    final metadataJson = {
      'appVersion': '1.0.0',
      'exportVersion': 1,
      'platform': Platform.operatingSystem,
    };

    final archive = Archive();

    archive.addFile(ArchiveFile(
      'data.json',
      utf8.encode(jsonEncode(dataJson)).length,
      utf8.encode(jsonEncode(dataJson)),
    ));

    archive.addFile(ArchiveFile(
      'metadata.json',
      utf8.encode(jsonEncode(metadataJson)).length,
      utf8.encode(jsonEncode(metadataJson)),
    ));

    final imagesDir = Directory(p.join(docsDir.path, 'images'));
    if (imagesDir.existsSync()) {
      final imageFiles = imagesDir.listSync();
      for (final file in imageFiles) {
        if (file is File) {
          final fileBytes = await file.readAsBytes();
          final fileName = p.basename(file.path);
          archive.addFile(ArchiveFile(
            'images/$fileName',
            fileBytes.length,
            fileBytes,
          ));
        }
      }
    }

    final zipEncoder = ZipEncoder();
    final zipBytes = zipEncoder.encode(archive);

    final zipFile = File(p.join(tempDir.path, 'skin_routine_export.zip'));
    await zipFile.writeAsBytes(zipBytes!);

    return zipFile.path;
  }

  @override
  Future<void> importData(String zipPath) async {
    final zipFile = File(zipPath);
    if (!zipFile.existsSync()) {
      throw Exception('Fichier ZIP non trouvé');
    }

    final zipBytes = await zipFile.readAsBytes();
    final archive = ZipDecoder().decodeBytes(zipBytes);

    ArchiveFile? dataFile;
    for (final file in archive) {
      if (file.name == 'data.json') {
        dataFile = file;
        break;
      }
    }

    if (dataFile == null) {
      throw Exception('data.json non trouvé dans le fichier');
    }

    final jsonString = utf8.decode(dataFile.content as List<int>);
    final data = jsonDecode(jsonString) as Map<String, dynamic>;

    if ((data['version'] as int?) != 1) {
      throw Exception('Format d\'export incompatible');
    }

    final docsDir = await getApplicationDocumentsDirectory();
    final imagesDir = Directory(p.join(docsDir.path, 'images'));
    if (!imagesDir.existsSync()) {
      await imagesDir.create(recursive: true);
    }

    await _database.transaction(() async {
      await _database.delete(_database.actionCompletions).go();
      await _database.delete(_database.actions).go();
      await _database.delete(_database.routines).go();
      await _database.delete(_database.products).go();
      await _database.delete(_database.skinJournal).go();

      for (final product in (data['products'] as List<dynamic>)) {
        final productMap = product as Map<String, dynamic>;
        await _database.into(_database.products).insert(
              ProductsCompanion(
                id: productMap['id'] != null
                    ? Value(productMap['id'] as int)
                    : const Value.absent(),
                name: Value(productMap['name'] as String),
                brand: Value(productMap['brand'] as String),
                type: Value(productMap['type'] as String),
                photoPath: productMap['photoPath'] != null
                    ? Value(productMap['photoPath'] as String)
                    : const Value(null),
                notes: productMap['notes'] != null
                    ? Value(productMap['notes'] as String)
                    : const Value(null),
                createdAt: Value(productMap['createdAt'] as int),
                updatedAt: Value(productMap['updatedAt'] as int),
              ),
            );
      }

      for (final routine in (data['routines'] as List<dynamic>)) {
        final routineMap = routine as Map<String, dynamic>;
        await _database.into(_database.routines).insert(
              RoutinesCompanion(
                id: routineMap['id'] != null
                    ? Value(routineMap['id'] as int)
                    : const Value.absent(),
                name: Value(routineMap['name'] as String),
                description: routineMap['description'] != null
                    ? Value(routineMap['description'] as String)
                    : const Value(null),
                bodyZone: Value(routineMap['bodyZone'] as String),
                skinGoal: Value(routineMap['skinGoal'] as String),
                reminderTime: routineMap['reminderTime'] != null
                    ? Value(routineMap['reminderTime'] as String)
                    : const Value(null),
                isActive: Value(routineMap['isActive'] as bool),
                createdAt: Value(routineMap['createdAt'] as int),
                updatedAt: Value(routineMap['updatedAt'] as int),
              ),
            );
      }

      for (final action in (data['actions'] as List<dynamic>)) {
        final actionMap = action as Map<String, dynamic>;
        await _database.into(_database.actions).insert(
              ActionsCompanion(
                id: actionMap['id'] != null
                    ? Value(actionMap['id'] as int)
                    : const Value.absent(),
                routineId: Value(actionMap['routineId'] as int),
                productId: actionMap['productId'] != null
                    ? Value(actionMap['productId'] as int)
                    : const Value(null),
                name: Value(actionMap['name'] as String),
                description: actionMap['description'] != null
                    ? Value(actionMap['description'] as String)
                    : const Value(null),
                sortOrder: Value(actionMap['sortOrder'] as int),
                recurrenceType:
                    Value(actionMap['recurrenceType'] as String),
                recurrenceInterval:
                    Value(actionMap['recurrenceInterval'] as int),
                recurrenceStartDate:
                    Value(actionMap['recurrenceStartDate'] as String),
                createdAt: Value(actionMap['createdAt'] as int),
              ),
            );
      }

      for (final completion in (data['completions'] as List<dynamic>)) {
        final completionMap = completion as Map<String, dynamic>;
        await _database.into(_database.actionCompletions).insert(
              ActionCompletionsCompanion(
                actionId: Value(completionMap['actionId'] as int),
                completedDate: Value(completionMap['completedDate'] as String),
                completedAt: Value(completionMap['completedAt'] as int),
              ),
            );
      }

      for (final entry in (data['journal'] as List<dynamic>)) {
        final entryMap = entry as Map<String, dynamic>;
        await _database.into(_database.skinJournal).insert(
              SkinJournalCompanion(
                id: entryMap['id'] != null
                    ? Value(entryMap['id'] as int)
                    : const Value.absent(),
                date: Value(entryMap['date'] as String),
                photoPath: entryMap['photoPath'] != null
                    ? Value(entryMap['photoPath'] as String)
                    : const Value(null),
                notes: Value(entryMap['notes'] as String),
                skinFeeling: Value(entryMap['skinFeeling'] as int),
                createdAt: Value(entryMap['createdAt'] as int),
              ),
            );
      }
    });

    for (final file in archive) {
      if (file.name.startsWith('images/') &&
          !file.isFile ||
          file.name == 'images/') {
        continue;
      }
      if (file.name.startsWith('images/')) {
        final fileName = file.name.substring('images/'.length);
        final imageFile = File(p.join(imagesDir.path, fileName));
        await imageFile.writeAsBytes(file.content as List<int>);
      }
    }
  }
}

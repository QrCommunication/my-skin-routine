import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:my_skin_routine/data/repositories/export_import_repository_impl.dart';
import 'package:my_skin_routine/domain/repositories/export_import_repository.dart';
import 'package:my_skin_routine/presentation/providers/database_provider.dart';

part 'export_import_providers.g.dart';

@riverpod
ExportImportRepository exportImportRepository(Ref ref) {
  final database = ref.watch(appDatabaseProvider);
  return ExportImportRepositoryImpl(database);
}

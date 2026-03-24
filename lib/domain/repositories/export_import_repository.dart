abstract class ExportImportRepository {
  Future<String> exportData();
  Future<void> importData(String zipPath);
}

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_skin_routine/data/database/app_database.dart';
import 'package:my_skin_routine/data/seed/product_seed_data.dart';
import 'package:drift/drift.dart';

/// Seeds the database with default products and copies bundled images on first launch.
Future<void> seedDatabaseIfNeeded(AppDatabase db) async {
  final prefs = await SharedPreferences.getInstance();
  final alreadySeeded = prefs.getBool('db_seeded') ?? false;
  if (alreadySeeded) return;

  // Copy bundled seed images to app documents directory
  final imageMap = await _copySeedImages();

  final now = DateTime.now().millisecondsSinceEpoch;

  await db.batch((batch) {
    for (final product in ProductSeedData.products) {
      // Try to find a matching bundled image
      final imageKey = _buildImageKey(product.type, product.brand, product.name);
      final photoPath = imageMap[imageKey];

      batch.insert(
        db.products,
        ProductsCompanion(
          name: Value(product.name),
          brand: Value(product.brand),
          type: Value(product.type),
          photoPath: photoPath != null ? Value(photoPath) : const Value.absent(),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
    }
  });

  await prefs.setBool('db_seeded', true);
}

/// Copies all bundled seed images from assets to the app documents directory.
/// Returns a map of imageKey → relative path.
Future<Map<String, String>> _copySeedImages() async {
  final appDir = await getApplicationDocumentsDirectory();
  final seedDir = Directory(p.join(appDir.path, 'images', 'products'));
  if (!await seedDir.exists()) {
    await seedDir.create(recursive: true);
  }

  final result = <String, String>{};

  // Load the asset manifest to find available seed images
  final manifestContent = await rootBundle.loadString('AssetManifest.json');
  final assetPaths = manifestContent
      .split('"')
      .where((s) => s.startsWith('assets/images/products/seed/') && s.endsWith('.jpg'))
      .toList();

  for (final assetPath in assetPaths) {
    try {
      final filename = p.basename(assetPath);
      final destPath = p.join(seedDir.path, filename);
      final relativePath = 'images/products/$filename';

      // Copy asset to documents directory
      final data = await rootBundle.load(assetPath);
      final file = File(destPath);
      await file.writeAsBytes(data.buffer.asUint8List());

      // Build key from filename: type_brand_name.jpg
      final keyFromFilename = p.basenameWithoutExtension(filename);
      result[keyFromFilename] = relativePath;
    } catch (_) {
      // Skip failed copies
    }
  }

  return result;
}

/// Builds a key from product data that matches the filename pattern.
String _buildImageKey(String type, String brand, String name) {
  final sanitizedBrand = brand
      .toLowerCase()
      .replaceAll(' ', '_')
      .replaceAll('-', '-')
      .replaceAll("'", '')
      .replaceAll('é', 'e')
      .replaceAll('è', 'e')
      .replaceAll('ê', 'e')
      .replaceAll('à', 'a')
      .replaceAll('ô', 'o')
      .replaceAll('î', 'i')
      .replaceAll('ï', 'i')
      .replaceAll('ç', 'c');
  final sanitizedName = name
      .toLowerCase()
      .replaceAll(' ', '_')
      .replaceAll('+', '')
      .replaceAll('%', '')
      .replaceAll("'", '')
      .replaceAll('é', 'e')
      .replaceAll('è', 'e')
      .replaceAll('ê', 'e')
      .replaceAll('à', 'a')
      .replaceAll('ô', 'o')
      .replaceAll('î', 'i')
      .replaceAll('ï', 'i')
      .replaceAll('ç', 'c')
      .replaceAll(RegExp(r'[^a-z0-9_]'), '');
  return '${type}_${sanitizedBrand}_$sanitizedName';
}

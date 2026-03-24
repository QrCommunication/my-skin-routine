import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:my_skin_routine/data/database/app_database.dart';
import 'package:my_skin_routine/data/seed/product_seed_data.dart';
import 'package:drift/drift.dart';

/// Seeds the database with default products on first launch.
/// Checks if DB is empty (not a SharedPreferences flag) to be robust.
Future<void> seedDatabaseIfNeeded(AppDatabase db) async {
  try {
    // Check if products already exist — if so, skip seeding
    final existingCount = await db.productDao.getProductCount();
    if (existingCount > 0) {
      debugPrint('Seed: DB already has $existingCount products, skipping.');
      return;
    }

    debugPrint('Seed: Inserting ${ProductSeedData.products.length} products...');
    final now = DateTime.now().millisecondsSinceEpoch;

    // Insert all products in a single batch
    await db.batch((batch) {
      for (final product in ProductSeedData.products) {
        batch.insert(
          db.products,
          ProductsCompanion(
            name: Value(product.name),
            brand: Value(product.brand),
            type: Value(product.type),
            createdAt: Value(now),
            updatedAt: Value(now),
          ),
        );
      }
    });

    debugPrint('Seed: Products inserted. Copying images...');

    // Copy images in background — non-blocking
    _copySeedImagesInBackground(db);
  } catch (e) {
    debugPrint('Seed error: $e');
  }
}

/// Copies bundled seed images to the documents directory and updates product photoPath.
/// Runs after products are already inserted — non-blocking.
Future<void> _copySeedImagesInBackground(AppDatabase db) async {
  try {
    final appDir = await getApplicationDocumentsDirectory();
    final seedDir = Directory(p.join(appDir.path, 'images', 'products'));
    if (!await seedDir.exists()) {
      await seedDir.create(recursive: true);
    }

    // Get all products from DB to match with images
    final products = await db.productDao.getAllProducts();

    int copied = 0;
    for (final product in products) {
      // Try to find a matching asset image
      final possibleKeys = _generatePossibleAssetKeys(
        product.type,
        product.brand,
        product.name,
      );

      for (final assetKey in possibleKeys) {
        final assetPath = 'assets/images/products/seed/$assetKey.jpg';
        try {
          final data = await rootBundle.load(assetPath);
          final filename = '$assetKey.jpg';
          final destPath = p.join(seedDir.path, filename);
          final relativePath = 'images/products/$filename';

          await File(destPath).writeAsBytes(data.buffer.asUint8List());

          // Update the product's photoPath in DB
          await (db.update(db.products)
                ..where((t) => t.id.equals(product.id)))
              .write(ProductsCompanion(photoPath: Value(relativePath)));

          copied++;
          break; // Found a match, move to next product
        } catch (_) {
          // Asset not found for this key, try next
          continue;
        }
      }
    }

    debugPrint('Seed: Copied $copied images for ${products.length} products.');
  } catch (e) {
    debugPrint('Seed image copy error: $e');
  }
}

/// Generate multiple possible asset filename keys for a product.
/// Tries different sanitization approaches to maximize matches.
List<String> _generatePossibleAssetKeys(String type, String brand, String name) {
  final keys = <String>[];

  // Approach 1: Standard sanitization
  final b1 = _sanitize(brand);
  final n1 = _sanitize(name);
  keys.add('${type}_${b1}_$n1');

  // Approach 2: More aggressive sanitization (remove dashes)
  final b2 = b1.replaceAll('-', '');
  final n2 = n1.replaceAll('-', '');
  if ('${type}_${b2}_$n2' != keys.first) {
    keys.add('${type}_${b2}_$n2');
  }

  // Approach 3: Keep dashes in brand (La Roche-Posay)
  final b3 = brand.toLowerCase().replaceAll(' ', '_').replaceAll("'", '');
  final n3 = _sanitize(name);
  if ('${type}_${b3}_$n3' != keys.first) {
    keys.add('${type}_${b3}_$n3');
  }

  return keys;
}

String _sanitize(String input) {
  return input
      .toLowerCase()
      .replaceAll(' ', '_')
      .replaceAll("'", '')
      .replaceAll('+', '')
      .replaceAll('%', '')
      .replaceAll('é', 'e')
      .replaceAll('è', 'e')
      .replaceAll('ê', 'e')
      .replaceAll('à', 'a')
      .replaceAll('â', 'a')
      .replaceAll('ô', 'o')
      .replaceAll('î', 'i')
      .replaceAll('ï', 'i')
      .replaceAll('ç', 'c')
      .replaceAll('ü', 'u')
      .replaceAll(RegExp(r'[^a-z0-9_-]'), '');
}

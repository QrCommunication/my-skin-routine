import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_skin_routine/data/database/app_database.dart';
import 'package:my_skin_routine/data/seed/product_seed_data.dart';
import 'package:my_skin_routine/core/utils/seed_image_generator.dart';
import 'package:drift/drift.dart';

Future<void> seedDatabaseIfNeeded(AppDatabase db) async {
  final prefs = await SharedPreferences.getInstance();
  final alreadySeeded = prefs.getBool('db_seeded') ?? false;
  if (alreadySeeded) return;

  // Generate unique placeholder images for each product
  final productImages = await SeedImageGenerator.generateAllProductImages(
    ProductSeedData.products,
  );

  final now = DateTime.now().millisecondsSinceEpoch;

  await db.batch((batch) {
    for (final product in ProductSeedData.products) {
      final imageKey = '${product.type}_${product.brand}_${product.name}';
      batch.insert(
        db.products,
        ProductsCompanion(
          name: Value(product.name),
          brand: Value(product.brand),
          type: Value(product.type),
          photoPath: Value(productImages[imageKey]),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
    }
  });

  await prefs.setBool('db_seeded', true);
}

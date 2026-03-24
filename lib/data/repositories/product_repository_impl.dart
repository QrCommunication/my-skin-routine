import 'package:drift/drift.dart';
import 'package:my_skin_routine/core/constants/enums.dart';
import 'package:my_skin_routine/data/database/app_database.dart';
import 'package:my_skin_routine/domain/models/product.dart';
import 'package:my_skin_routine/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final AppDatabase _database;

  ProductRepositoryImpl(this._database);

  @override
  Stream<List<Product>> watchAllProducts() {
    return _database.productDao.watchAllProducts().map(
          (rows) => rows.map(_rowToProduct).toList(),
        );
  }

  @override
  Future<List<Product>> getAllProducts() async {
    final rows = await _database.productDao.getAllProducts();
    return rows.map(_rowToProduct).toList();
  }

  @override
  Future<Product?> getProductById(int id) async {
    final row = await _database.productDao.getProductById(id);
    return row != null ? _rowToProduct(row) : null;
  }

  @override
  Stream<List<Product>> watchProductsByType(String type) {
    return _database.productDao.watchProductsByType(type).map(
          (rows) => rows.map(_rowToProduct).toList(),
        );
  }

  @override
  Future<List<Product>> searchProducts(String query) async {
    final rows = await _database.productDao.searchProducts(query);
    return rows.map(_rowToProduct).toList();
  }

  @override
  Future<int> createProduct({
    required String name,
    required String brand,
    required String type,
    String? photoPath,
    String? notes,
  }) {
    final now = DateTime.now().millisecondsSinceEpoch;
    return _database.productDao.insertProduct(
      ProductsCompanion(
        name: Value(name),
        brand: Value(brand),
        type: Value(type),
        photoPath: photoPath != null ? Value(photoPath) : const Value.absent(),
        notes: notes != null ? Value(notes) : const Value.absent(),
        createdAt: Value(now),
        updatedAt: Value(now),
      ),
    );
  }

  @override
  Future<void> updateProduct(Product product) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await _database.productDao.updateProduct(
      ProductsCompanion(
        id: Value(product.id),
        name: Value(product.name),
        brand: Value(product.brand),
        type: Value(product.type.name),
        photoPath: product.photoPath != null
            ? Value(product.photoPath!)
            : const Value.absent(),
        notes:
            product.notes != null ? Value(product.notes!) : const Value.absent(),
        createdAt: Value(product.createdAt.millisecondsSinceEpoch),
        updatedAt: Value(now),
      ),
    );
  }

  @override
  Future<void> deleteProduct(int id) {
    return _database.productDao.deleteProductById(id);
  }

  @override
  Future<int> getProductCount() {
    return _database.productDao.getProductCount();
  }

  Product _rowToProduct(ProductRow row) {
    return Product(
      id: row.id,
      name: row.name,
      brand: row.brand,
      type: ProductType.values.byName(row.type),
      photoPath: row.photoPath,
      notes: row.notes,
      createdAt: DateTime.fromMillisecondsSinceEpoch(row.createdAt),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(row.updatedAt),
    );
  }
}

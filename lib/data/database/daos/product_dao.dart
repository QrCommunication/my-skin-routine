import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/products_table.dart';

part 'product_dao.g.dart';

@DriftAccessor(tables: [Products])
class ProductDao extends DatabaseAccessor<AppDatabase> with _$ProductDaoMixin {
  ProductDao(super.db);

  Stream<List<ProductRow>> watchAllProducts() =>
      (select(products)..orderBy([(t) => OrderingTerm.asc(t.name)]))
          .watch();

  Future<List<ProductRow>> getAllProducts() =>
      (select(products)..orderBy([(t) => OrderingTerm.asc(t.name)])).get();

  Future<ProductRow?> getProductById(int id) =>
      (select(products)..where((t) => t.id.equals(id))).getSingleOrNull();

  Stream<List<ProductRow>> watchProductsByType(String type) =>
      (select(products)
            ..where((t) => t.type.equals(type))
            ..orderBy([(t) => OrderingTerm.asc(t.name)]))
          .watch();

  Future<int> insertProduct(ProductsCompanion entry) =>
      into(products).insert(entry);

  Future<bool> updateProduct(ProductsCompanion entry) =>
      update(products).replace(entry);

  Future<int> deleteProductById(int id) =>
      (delete(products)..where((t) => t.id.equals(id))).go();

  Future<int> getProductCount() async {
    final count = countAll();
    final query = selectOnly(products)..addColumns([count]);
    final result = await query.getSingle();
    return result.read(count)!;
  }

  Future<List<ProductRow>> searchProducts(String query) =>
      (select(products)
            ..where((t) =>
                t.name.like('%$query%') | t.brand.like('%$query%'))
            ..orderBy([(t) => OrderingTerm.asc(t.name)]))
          .get();
}

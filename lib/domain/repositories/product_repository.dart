import '../models/product.dart';

abstract class ProductRepository {
  Stream<List<Product>> watchAllProducts();
  Future<List<Product>> getAllProducts();
  Future<Product?> getProductById(int id);
  Stream<List<Product>> watchProductsByType(String type);
  Future<List<Product>> searchProducts(String query);
  Future<int> createProduct({
    required String name,
    required String brand,
    required String type,
    String? photoPath,
    String? notes,
  });
  Future<void> updateProduct(Product product);
  Future<void> deleteProduct(int id);
  Future<int> getProductCount();
}

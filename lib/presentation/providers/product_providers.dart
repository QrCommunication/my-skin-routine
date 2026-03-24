import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:my_skin_routine/data/repositories/product_repository_impl.dart';
import 'package:my_skin_routine/domain/models/product.dart';
import 'package:my_skin_routine/domain/repositories/product_repository.dart';
import 'package:my_skin_routine/presentation/providers/database_provider.dart';

part 'product_providers.g.dart';

@riverpod
ProductRepository productRepository(Ref ref) {
  final database = ref.watch(appDatabaseProvider);
  return ProductRepositoryImpl(database);
}

@riverpod
class ProductList extends _$ProductList {
  @override
  Future<List<Product>> build() async {
    final repository = ref.watch(productRepositoryProvider);
    return repository.getAllProducts();
  }

  Future<void> deleteProduct(int id) async {
    final repository = ref.watch(productRepositoryProvider);
    await repository.deleteProduct(id);
    ref.invalidateSelf();
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}

@riverpod
Future<List<Product>> productSearch(Ref ref, String query) async {
  final repository = ref.watch(productRepositoryProvider);
  if (query.isEmpty) {
    return repository.getAllProducts();
  }
  return repository.searchProducts(query);
}

@riverpod
Future<Product?> productById(Ref ref, int id) async {
  final repository = ref.watch(productRepositoryProvider);
  return repository.getProductById(id);
}

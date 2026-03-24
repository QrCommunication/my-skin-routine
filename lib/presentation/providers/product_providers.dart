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

/// Reactive stream — auto-updates when DB changes
@riverpod
Stream<List<Product>> productList(Ref ref) {
  final repository = ref.watch(productRepositoryProvider);
  return repository.watchAllProducts();
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

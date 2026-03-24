import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_skin_routine/core/constants/enums.dart';
import 'package:my_skin_routine/domain/models/product.dart';
import 'package:my_skin_routine/presentation/providers/product_providers.dart';
import 'package:my_skin_routine/presentation/widgets/product_card.dart';

class ProductListScreen extends ConsumerStatefulWidget {
  const ProductListScreen({super.key});

  @override
  ConsumerState<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends ConsumerState<ProductListScreen> {
  late TextEditingController _searchController;
  late FocusNode _searchFocusNode;
  String _searchQuery = '';
  ProductType? _selectedFilter;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
    _selectedFilter = null;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  List<Product> _filterProducts(List<Product> products) {
    var filtered = products;

    if (_selectedFilter != null) {
      filtered = filtered.where((p) => p.type == _selectedFilter).toList();
    }

    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      filtered = filtered
          .where((p) =>
              p.name.toLowerCase().contains(query) ||
              (p.brand?.toLowerCase().contains(query) ?? false))
          .toList();
    }

    return filtered;
  }

  void _showProductOptions(Product product) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Modifier'),
                onTap: () {
                  Navigator.pop(context);
                  context.push('/products/${product.id}/edit');
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Supprimer', style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context);
                  _showDeleteConfirmation(product);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteConfirmation(Product product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Supprimer le produit'),
          content: Text(
            'Êtes-vous sûr de vouloir supprimer "${product.name}" ?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            FilledButton.tonal(
              onPressed: () async {
                Navigator.pop(context);
                await ref
                    .read(productListProvider.notifier)
                    .deleteProduct(product.id);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${product.name} a été supprimé'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: const Text('Supprimer'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final productsAsyncValue = ref.watch(productListProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: productsAsyncValue.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 48, color: colorScheme.error),
              const SizedBox(height: 16),
              Text('Une erreur s\'est produite'),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: () {
                  ref.invalidate(productListProvider);
                },
                child: const Text('Réessayer'),
              ),
            ],
          ),
        ),
        data: (products) {
          final filteredProducts = _filterProducts(products);
          final allProductTypes = ProductType.values;

          return CustomScrollView(
            slivers: [
              SliverAppBar.large(
                title: const Text('Mes produits'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () => context.push('/settings'),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: SearchBar(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    hintText: 'Rechercher un produit',
                    leading: const Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Icon(Icons.search),
                    ),
                    trailing: _searchQuery.isNotEmpty
                        ? [
                            IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                setState(() => _searchQuery = '');
                              },
                            ),
                          ]
                        : null,
                    onChanged: (value) {
                      setState(() => _searchQuery = value);
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        FilterChip(
                          label: const Text('Tous'),
                          selected: _selectedFilter == null,
                          onSelected: (_) {
                            setState(() => _selectedFilter = null);
                          },
                        ),
                        const SizedBox(width: 8),
                        ...allProductTypes.map(
                          (type) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: FilterChip(
                              label: Text(type.labelFr),
                              selected: _selectedFilter == type,
                              onSelected: (_) {
                                setState(
                                  () => _selectedFilter =
                                      _selectedFilter == type ? null : type,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 12)),
              if (filteredProducts.isEmpty)
                SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.spa_outlined,
                          size: 64,
                          color: colorScheme.outline,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Aucun produit',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Ajoutez vos premiers produits de soin',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: colorScheme.outline,
                              ),
                        ),
                        const SizedBox(height: 32),
                        FilledButton.icon(
                          icon: const Icon(Icons.add),
                          label: const Text('Ajouter un produit'),
                          onPressed: () => context.push('/products/new'),
                        ),
                      ],
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.75,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final product = filteredProducts[index];
                        return ProductCard(
                          product: product,
                          onTap: () => context.push('/products/${product.id}'),
                          onLongPress: () => _showProductOptions(product),
                        );
                      },
                      childCount: filteredProducts.length,
                    ),
                  ),
                ),
              const SliverToBoxAdapter(child: SizedBox(height: 32)),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/products/new'),
        icon: const Icon(Icons.add),
        label: const Text('Nouveau produit'),
      ),
    );
  }
}

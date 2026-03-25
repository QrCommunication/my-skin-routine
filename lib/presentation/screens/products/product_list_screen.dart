import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_skin_routine/core/constants/enums.dart';
import 'package:my_skin_routine/core/extensions/context_extensions.dart';
import 'package:my_skin_routine/domain/models/product.dart';
import 'package:my_skin_routine/presentation/providers/product_providers.dart';
import 'package:my_skin_routine/presentation/theme/app_motion.dart';
import 'package:my_skin_routine/presentation/widgets/empty_state.dart';
import 'package:my_skin_routine/presentation/widgets/product_card.dart';
import 'package:my_skin_routine/presentation/widgets/spotlight_tutorial.dart';

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
  bool _tutorialShown = false;
  final GlobalKey _searchBarKey = GlobalKey();
  final GlobalKey _filterChipsKey = GlobalKey();
  final GlobalKey _fabKey = GlobalKey();

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
                title: Text(context.l10n.commonEdit),
                onTap: () {
                  Navigator.pop(context);
                  context.push('/products/${product.id}/edit');
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: Text(context.l10n.commonDelete, style: const TextStyle(color: Colors.red)),
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
          title: Text(context.l10n.productDelete),
          content: Text(
            context.l10n.productDeleteConfirm(product.name),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(context.l10n.commonCancel),
            ),
            FilledButton.tonal(
              onPressed: () async {
                Navigator.pop(context);
                await ref
                    .read(productRepositoryProvider)
                    .deleteProduct(product.id);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(context.l10n.productNameDeleted(product.name)),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: Text(context.l10n.commonDelete),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_tutorialShown) {
      _tutorialShown = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        SpotlightTutorial.showIfFirstTime(
          context: context,
          tutorialKey: 'products',
          steps: [
            SpotlightStep(
              targetKey: _searchBarKey,
              title: context.l10n.tutorialProductsSearchTitle,
              description: context.l10n.tutorialProductsSearchDescription,
              icon: Icons.search,
            ),
            SpotlightStep(
              targetKey: _filterChipsKey,
              title: context.l10n.tutorialProductsFilterTitle,
              description: context.l10n.tutorialProductsFilterDescription,
              icon: Icons.filter_list,
            ),
            SpotlightStep(
              targetKey: _fabKey,
              title: context.l10n.tutorialProductsAddTitle,
              description: context.l10n.tutorialProductsAddDescription,
              icon: Icons.add_circle_outline,
            ),
          ],
        );
      });
    }

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
              Text(context.l10n.commonError),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: () {
                  ref.invalidate(productListProvider); // force refresh on error retry
                },
                child: Text(context.l10n.commonRetry),
              ),
            ],
          ),
        ),
        data: (products) {
          final filteredProducts = _filterProducts(products);
          final allProductTypes = ProductType.values;
          final locale = Localizations.localeOf(context).languageCode;

          return CustomScrollView(
            slivers: [
              SliverAppBar.large(
                title: Text(context.l10n.productsTitle),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: SearchBar(
                    key: _searchBarKey,
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    hintText: context.l10n.productsSearch,
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
                      key: _filterChipsKey,
                      children: [
                        FilterChip(
                          label: Text(context.l10n.commonAll),
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
                              label: Text(type.localizedLabel(locale)),
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
                  child: EmptyState(
                    icon: Icons.spa_outlined,
                    title: context.l10n.productsEmpty,
                    subtitle: context.l10n.productsEmptySubtitle,
                    actionLabel: context.l10n.productNew,
                    onAction: () => context.push('/products/new'),
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
                        ).animate()
                          .fadeIn(delay: (index * 50).ms, duration: AppMotion.durationMedium)
                          .slideY(begin: 0.1, delay: (index * 50).ms, duration: AppMotion.durationMedium, curve: AppMotion.standardCurve);
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
        key: _fabKey,
        onPressed: () => context.push('/products/new'),
        icon: const Icon(Icons.add),
        label: Text(context.l10n.productNew),
      ).animate().scale(delay: 500.ms, duration: AppMotion.durationLong, curve: AppMotion.expressiveCurve),
    );
  }
}

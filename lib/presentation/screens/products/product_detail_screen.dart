import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';

import 'package:my_skin_routine/core/constants/enums.dart';
import 'package:my_skin_routine/domain/models/product.dart';
import 'package:my_skin_routine/presentation/providers/product_providers.dart';
import 'package:my_skin_routine/presentation/providers/routine_providers.dart';
import 'package:my_skin_routine/core/utils/photo_utils.dart';
import 'package:my_skin_routine/core/extensions/context_extensions.dart';

class ProductDetailScreen extends ConsumerWidget {
  final int id;

  const ProductDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsyncValue = ref.watch(productByIdProvider(id));

    return Scaffold(
      body: productAsyncValue.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('Erreur : $error'),
        ),
        data: (product) {
          if (product == null) {
            return const Center(child: Text('Produit non trouvé'));
          }
          return _buildProductDetail(context, ref, product);
        },
      ),
    );
  }

  Widget _buildProductDetail(
    BuildContext context,
    WidgetRef ref,
    Product product,
  ) {
    return CustomScrollView(
      slivers: [
        SliverAppBar.large(
          title: Text(product.name),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit_rounded),
              onPressed: () => context.push('/products/${product.id}/edit'),
              tooltip: 'Éditer',
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline_rounded),
              onPressed: () => _showDeleteConfirmation(context, ref, product),
              tooltip: 'Supprimer',
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildPhotoSection(product),
                _buildInfoSection(context, product),
                _buildUsageSection(context, ref, product),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhotoSection(Product product) {
    if (product.photoPath != null && product.photoPath!.isNotEmpty) {
      return FutureBuilder<String>(
        future: getAbsolutePath(product.photoPath!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Image.file(
                File(snapshot.data!),
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.blue,
              child: Text(
                product.name.isNotEmpty ? product.name[0].toUpperCase() : 'P',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: CircleAvatar(
          radius: 60,
          backgroundColor: Colors.blue,
          child: Text(
            product.name.isNotEmpty ? product.name[0].toUpperCase() : 'P',
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }

  Widget _buildInfoSection(BuildContext context, Product product) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          if (product.brand != null && product.brand!.isNotEmpty)
            Text(
              product.brand!,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: colorScheme.secondary,
                  ),
            ),
          const SizedBox(height: 16),
          Chip(
            label: Text(product.type.labelFr),
          ),
          if (product.notes != null && product.notes!.isNotEmpty) ...[
            const SizedBox(height: 24),
            Text(
              'Notes',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            Text(
              product.notes!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildUsageSection(
    BuildContext context,
    WidgetRef ref,
    Product product,
  ) {
    final routineRepository = ref.watch(routineRepositoryProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: FutureBuilder<int>(
        future: routineRepository.countActionsForProduct(product.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox.shrink();
          }

          if (snapshot.hasError) {
            return const SizedBox.shrink();
          }

          final count = snapshot.data ?? 0;
          final usageText = count == 0
              ? 'Non utilisé dans aucune routine'
              : 'Utilisé dans $count action${count > 1 ? 's' : ''}';
          return Text(
            usageText,
            style: Theme.of(context).textTheme.bodyMedium,
          );
        },
      ),
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    WidgetRef ref,
    Product product,
  ) {
    final routineRepository = ref.read(routineRepositoryProvider);

    routineRepository.countActionsForProduct(product.id).then((usageCount) {
      final isUsed = usageCount > 0;

      showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Supprimer le produit ?'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Êtes-vous sûr de vouloir supprimer "${product.name}" ?',
              ),
              if (isUsed) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange),
                  ),
                  child: Text(
                    'Attention : Ce produit est utilisé dans $usageCount action${usageCount > 1 ? 's' : ''}. Cela affectera les routines.',
                    style: const TextStyle(color: Colors.orangeAccent),
                  ),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => dialogContext.pop(),
              child: const Text('Annuler'),
            ),
            FilledButton.tonal(
              onPressed: () async {
                dialogContext.pop();
                await _deleteProduct(context, ref, product);
              },
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red.withOpacity(0.1),
                foregroundColor: Colors.red,
              ),
              child: const Text('Supprimer'),
            ),
          ],
        ),
      );
    });
  }

  Future<void> _deleteProduct(
    BuildContext context,
    WidgetRef ref,
    Product product,
  ) async {
    try {
      if (product.photoPath != null && product.photoPath!.isNotEmpty) {
        final absolutePath = await getAbsolutePath(product.photoPath!);
        final file = File(absolutePath);
        if (await file.exists()) {
          await file.delete();
        }
      }

      await ref.read(productRepositoryProvider).deleteProduct(product.id);

      if (!context.mounted) return;

      context.pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Produit "${product.name}" supprimé'),
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la suppression : $e')),
      );
    }
  }
}

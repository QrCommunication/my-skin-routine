import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_skin_routine/core/utils/photo_utils.dart';
import 'package:my_skin_routine/domain/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const ProductCard({
    required this.product,
    this.onTap,
    this.onLongPress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                color: colorScheme.surfaceContainerHighest,
                child: product.photoPath != null && product.photoPath!.isNotEmpty
                    ? FutureBuilder<String>(
                        future: getAbsolutePath(product.photoPath!),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final file = File(snapshot.data!);
                            if (file.existsSync()) {
                              return Image.file(
                                file,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    _buildPlaceholder(product, colorScheme),
                              );
                            }
                          }
                          return _buildPlaceholder(product, colorScheme);
                        },
                      )
                    : _buildPlaceholder(product, colorScheme),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    product.brand,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.outline,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      product.type.labelFr,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: colorScheme.onPrimaryContainer,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder(Product product, ColorScheme colorScheme) {
    final firstLetter = product.brand.isNotEmpty
        ? product.brand[0].toUpperCase()
        : product.name[0].toUpperCase();

    return Center(
      child: CircleAvatar(
        radius: 32,
        backgroundColor: colorScheme.primaryContainer,
        child: Text(
          firstLetter,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: colorScheme.onPrimaryContainer,
          ),
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
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
                    ? Image.file(
                        File(product.photoPath!),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildPlaceholder(
                            product.name,
                            colorScheme,
                          );
                        },
                      )
                    : _buildPlaceholder(product.name, colorScheme),
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
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  if (product.brand != null && product.brand!.isNotEmpty)
                    Text(
                      product.brand!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: colorScheme.outline,
                          ),
                    ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 28,
                    child: Chip(
                      label: Text(
                        product.type.labelFr,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
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

  Widget _buildPlaceholder(String name, ColorScheme colorScheme) {
    final firstLetter = name.isNotEmpty ? name[0].toUpperCase() : '?';
    final backgroundColor = _getColorForLetter(firstLetter, colorScheme);

    return Center(
      child: CircleAvatar(
        radius: 32,
        backgroundColor: backgroundColor,
        child: Text(
          firstLetter,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Color _getColorForLetter(String letter, ColorScheme colorScheme) {
    final colors = [
      colorScheme.primary,
      colorScheme.secondary,
      colorScheme.tertiary,
      colorScheme.error,
    ];
    final charCode = letter.codeUnitAt(0);
    return colors[charCode % colors.length];
  }
}

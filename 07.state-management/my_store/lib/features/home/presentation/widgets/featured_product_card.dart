import 'package:flutter/material.dart';
import 'package:my_store/core/consts/app_dimensions.dart';
import 'package:my_store/core/theme/app_theme.dart';
import 'package:my_store/shared/favorites/presentation/widgets/favorite_button.dart';
import 'package:my_store/shared/product/domain/entities/product.dart';

const _imageSize = 96.0;

class FeaturedProductCard extends StatelessWidget {
  const FeaturedProductCard({super.key, required this.product, this.onTap});

  final Product product;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: (_imageSize / 2)),
            decoration: BoxDecoration(
              gradient: Theme.of(
                context,
              ).extension<AppGradients>()?.cardGradient,
              border: Border.all(
                color: theme.colorScheme.primary.withAlpha(40),
              ),
              borderRadius: BorderRadius.circular(
                AppDimensions.defaultBorderRadius,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: (_imageSize / 2) + (AppDimensions.defaultPadding / 2),
                left: AppDimensions.defaultPadding,
                right: AppDimensions.defaultPadding,
                bottom: AppDimensions.defaultPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.defaultMargin / 4),
                  Row(
                    children: [
                      FavoriteButton(productId: product.id, iconSize: 18),
                      const SizedBox(width: AppDimensions.defaultMargin / 2),
                      Expanded(
                        child: Text(
                          product.price.formatted,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w300,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.defaultMargin / 2),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: onTap,
                      child: const Text('Add to Cart'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Image.network(
              product.imageUrl,
              height: _imageSize,
              width: _imageSize,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.cookie, size: _imageSize);
              },
            ),
          ),
        ],
      ),
    );
  }
}

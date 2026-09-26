import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_store/core/consts/app_dimensions.dart';
import 'package:my_store/core/theme/app_theme.dart';
import 'package:my_store/features/cart/presentation/widgets/add_to_cart_button.dart';
import 'package:my_store/features/favorites/presentation/widgets/favorite_button.dart';
import 'package:my_store/features/product/domain/entities/price.dart';
import 'package:my_store/features/product/domain/entities/product.dart';
import 'package:my_store/features/product/presentation/providers/product_notifier.dart';
import 'package:my_store/features/product_details/presentation/pages/product_details_page.dart';
import 'package:my_store/shared/widgets/error_image_placeholder.dart';
import 'package:my_store/shared/widgets/shimmer.dart';

const _imageSize = 96.0;

class FeaturedProductCard extends ConsumerWidget {
  const FeaturedProductCard({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(productProvider(productId));

    return productAsync.when(
      skipLoadingOnRefresh: false,
      loading: () {
        return const Shimmer(enabled: true, child: _Content(product: null));
      },
      error: (Object error, StackTrace _) {
        return const SizedBox();
      },
      data: (product) {
        if (product == null) return const SizedBox();

        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              ProductDetailsPage.routeName,
              arguments: product.id,
            );
          },
          child: _Content(product: product),
        );
      },
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.product});

  final Product? product;

  bool get _isPlaceholder => product == null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final discountedPrice = product?.price.calculateDiscountedPrice;

    return Stack(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: (_imageSize / 2)),
          decoration: BoxDecoration(
            gradient: Theme.of(context).extension<AppGradients>()?.cardGradient,
            border: Border.all(color: theme.colorScheme.primary.withAlpha(40)),
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
                  product?.name ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: AppDimensions.defaultMargin / 4),
                Row(
                  children: [
                    if (!_isPlaceholder) ...[
                      FavoriteButton(
                        productId: product?.id ?? '',
                        iconSize: 18,
                      ),
                      const SizedBox(width: AppDimensions.defaultMargin / 2),
                    ],
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: product?.price.formatted ?? '',
                              style: textTheme.bodyMedium?.copyWith(
                                fontWeight: discountedPrice != null
                                    ? FontWeight.w300
                                    : FontWeight.bold,
                                color: discountedPrice != null
                                    ? theme.colorScheme.onSurface
                                    : theme.colorScheme.primary,
                                decoration: discountedPrice != null
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            const WidgetSpan(
                              child: SizedBox(
                                width: AppDimensions.defaultMargin / 4,
                              ),
                            ),
                            if (discountedPrice != null) ...[
                              TextSpan(
                                text: discountedPrice.asPrice(
                                  product?.price.currency ?? '',
                                ),
                                style: textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ],
                          ],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.defaultMargin / 2),
                if (!_isPlaceholder) ...[
                  AddToCartButton(product: product!),
                ] else ...[
                  const SizedBox(height: 30),
                ],
              ],
            ),
          ),
        ),
        if (!_isPlaceholder) ...[
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                AppDimensions.defaultBorderRadius,
              ),
              child: Image.network(
                product?.imageUrl ?? '',
                height: _imageSize,
                width: _imageSize,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const ErrorImagePlaceholder(
                    width: _imageSize,
                    height: _imageSize,
                  );
                },
              ),
            ),
          ),
        ],
      ],
    );
  }
}

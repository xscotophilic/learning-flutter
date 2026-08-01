import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_store/core/consts/app_dimensions.dart';
import 'package:my_store/features/cart/presentation/widgets/add_to_cart_button.dart';
import 'package:my_store/features/favorites/presentation/widgets/favorite_button.dart';
import 'package:my_store/features/product/domain/entities/product.dart';
import 'package:my_store/features/product/presentation/providers/product_notifier.dart';
import 'package:my_store/shared/widgets/error_image_placeholder.dart';
import 'package:my_store/shared/widgets/generic_error_view.dart';
import 'package:my_store/shared/widgets/generic_progress_indicator.dart';
import 'package:my_store/shared/widgets/main_app_bar.dart';

class ProductDetailsPage extends ConsumerWidget {
  const ProductDetailsPage({super.key, required this.productId});

  static const routeName = '/product-details';

  final String? productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Widget? trailingAppBarWidget;
    final Widget child;

    if (productId == null) {
      trailingAppBarWidget = null;
      child = const Center(child: Text('Product not found'));
    } else {
      trailingAppBarWidget = FavoriteButton(productId: productId!);

      final productAsync = ref.watch(productProvider(productId!));

      child = productAsync.when(
        skipLoadingOnRefresh: false,
        loading: () {
          return const Center(child: GenericProgressIndicator());
        },
        error: (Object error, StackTrace _) {
          return Center(
            child: GenericErrorView(
              onRetry: () => ref.invalidate(productProvider(productId!)),
            ),
          );
        },
        data: (Product? product) {
          if (product == null) {
            return const Center(child: Text('Product not found'));
          }
          return _ProductDetailsContent(product: product);
        },
      );
    }

    return Scaffold(
      appBar: MainAppBar(
        title: 'Details',
        leadingIcon: Icons.arrow_back_ios_new,
        onLeadingTap: () {
          Navigator.pop(context);
        },
        trailing: trailingAppBarWidget,
      ),
      body: child,
    );
  }
}

class _ProductDetailsContent extends StatelessWidget {
  const _ProductDetailsContent({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final imageSize = math.min(size.width * 0.60, 256.0);

    return Padding(
      padding: const EdgeInsets.all(AppDimensions.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                AppDimensions.defaultBorderRadius,
              ),
              child: Image.network(
                product.imageUrl,
                width: imageSize,
                errorBuilder: (context, error, stackTrace) {
                  return const ErrorImagePlaceholder(
                    width: double.infinity,
                    padding: EdgeInsets.all(AppDimensions.defaultPadding * 3),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.defaultPadding * 3),
          Expanded(child: _ProductDetails(product: product)),
          const SizedBox(height: AppDimensions.defaultPadding),
          AddToCartButton(
            product: product,
            style: AddToCartButtonStyle.elevated,
          ),
          const SizedBox(height: AppDimensions.defaultPadding / 2),
        ],
      ),
    );
  }
}

class _PriceSection extends StatelessWidget {
  const _PriceSection({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final discountedPrice = product.price.calculateDiscountedPrice;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (discountedPrice != null) ...[
          Text(
            product.price.formatted,
            style: textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w300,
              color: colorScheme.onSurface,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
        const SizedBox(height: AppDimensions.defaultPadding / 4),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text:
                    product.price.formattedDiscountedPrice ??
                    product.price.formatted,
                style: textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (discountedPrice != null) ...[
                const WidgetSpan(
                  child: SizedBox(width: AppDimensions.defaultPadding / 2),
                ),
                WidgetSpan(
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorScheme.tertiary,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(AppDimensions.defaultBorderRadius / 2),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.defaultPadding / 2,
                        vertical: AppDimensions.defaultPadding / 8,
                      ),
                      child: Text(
                        '${(product.price.discountPercent)?.floor()}% OFF',
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _ProductDetails extends StatelessWidget {
  const _ProductDetails({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        _PriceSection(product: product),
        const SizedBox(height: AppDimensions.defaultPadding / 2),
        Text(
          product.name.toUpperCase(),
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(height: AppDimensions.defaultPadding / 2),
        Text(
          product.description,
          style: theme.textTheme.bodyLarge,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_store/core/consts/app_dimensions.dart';
import 'package:my_store/core/theme/app_theme.dart';
import 'package:my_store/features/home/presentation/providers/home_notifier.dart';
import 'package:my_store/features/my_products/presentation/providers/my_products_notifier.dart';
import 'package:my_store/features/product/domain/entities/product.dart';
import 'package:my_store/features/product/presentation/providers/product_notifier.dart';
import 'package:my_store/shared/widgets/app_drawer.dart';
import 'package:my_store/shared/widgets/error_image_placeholder.dart';
import 'package:my_store/shared/widgets/generic_error_view.dart';
import 'package:my_store/shared/widgets/generic_progress_indicator.dart';
import 'package:my_store/shared/widgets/loading_overlay.dart';
import 'package:my_store/shared/widgets/main_app_bar.dart';

class MyProductsPage extends ConsumerStatefulWidget {
  const MyProductsPage({super.key});

  static const routeName = '/my-products';

  @override
  ConsumerState<MyProductsPage> createState() => _MyProductsPageState();
}

class _MyProductsPageState extends ConsumerState<MyProductsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final productIdsAsync = ref.watch(myProductsProvider);

    return Scaffold(
      key: _scaffoldKey,
      appBar: MainAppBar(
        title: 'My Products',
        leadingIcon: Icons.menu_rounded,
        onLeadingTap: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        trailing: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              vertical: AppDimensions.defaultPadding / 3,
              horizontal: AppDimensions.defaultPadding,
            ),
          ),
          child: const Text('Add'),
        ),
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: productIdsAsync.when(
          skipLoadingOnRefresh: false,
          loading: () {
            return const Center(child: GenericProgressIndicator());
          },
          error: (Object error, StackTrace stackTrace) {
            return Center(
              child: GenericErrorView(
                onRetry: () => ref.invalidate(myProductsProvider),
              ),
            );
          },
          data: (snapshot) {
            if (snapshot.productIds.isEmpty) {
              return const Center(child: Text('No products found.'));
            }

            final isMutating = snapshot.isMutating;
            return LoadingOverlay(
              isLoading: isMutating,
              child: _MyProductsList(productIds: snapshot.productIds),
            );
          },
        ),
      ),
    );
  }
}

class _MyProductsList extends ConsumerWidget {
  const _MyProductsList({required this.productIds});

  final List<String> productIds;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productStates = productIds.map((id) {
      return ref.watch(productProvider(id));
    }).toList();

    final List<Product> products = [];
    for (int i = 0; i < productIds.length; i++) {
      final state = productStates[i];
      if (!state.hasError && state.hasValue && state.value != null) {
        products.add(state.value!);
      }
    }

    if (products.isEmpty) {
      if (productStates.any((state) => state.hasError)) {
        return Center(
          child: GenericErrorView(
            onRetry: () => ref.invalidate(myProductsProvider),
          ),
        );
      }
      return const Center(child: Text('No items available at the moment.'));
    }

    final hasError = productStates.any((state) => state.hasError);
    return ListView.builder(
      padding: const EdgeInsets.all(AppDimensions.defaultPadding),
      itemCount: products.length + (hasError ? 1 : 0),
      itemBuilder: (context, index) {
        if (hasError && index == 0) {
          return const _ErrorTile();
        }

        final product = hasError ? products[index - 1] : products[index];
        return _ProductTile(product: product);
      },
    );
  }
}

class _ErrorTile extends StatelessWidget {
  const _ErrorTile();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.defaultMargin),
      margin: const EdgeInsets.only(bottom: AppDimensions.defaultMargin),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.error,
        borderRadius: BorderRadius.circular(AppDimensions.defaultBorderRadius),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'We couldn\'t load some of your products',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              return ElevatedButton(
                onPressed: () => ref.invalidate(myProductsProvider),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.onSecondary,
                  foregroundColor: Theme.of(context).colorScheme.error,
                  padding: const EdgeInsets.symmetric(
                    vertical: AppDimensions.defaultPadding / 2,
                    horizontal: AppDimensions.defaultPadding,
                  ),
                ),
                child: const Text('Retry'),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ProductTile extends StatelessWidget {
  const _ProductTile({required this.product});

  final Product product;
  final double _imageSize = 64;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appGradients = theme.extension<AppGradients>();

    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.defaultMargin),
      padding: const EdgeInsets.all(AppDimensions.defaultPadding),
      decoration: BoxDecoration(
        gradient: appGradients?.cardGradient,
        border: Border.all(color: theme.colorScheme.primary.withAlpha(40)),
        borderRadius: BorderRadius.circular(AppDimensions.defaultBorderRadius),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
              AppDimensions.defaultBorderRadius,
            ),
            child: Image.network(
              product.imageUrl,
              width: _imageSize,
              height: _imageSize,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return ErrorImagePlaceholder(
                  width: _imageSize,
                  height: _imageSize,
                );
              },
            ),
          ),
          const SizedBox(width: AppDimensions.defaultPadding / 2),
          Expanded(child: _ProductInfo(product: product)),
          const SizedBox(width: AppDimensions.defaultPadding / 2),
          _CTAButtons(product: product),
        ],
      ),
    );
  }
}

class _ProductInfo extends StatelessWidget {
  const _ProductInfo({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        if ((product.price.discountPercent ?? 0) > 0) ...[
          const SizedBox(height: AppDimensions.defaultMargin / 4),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.defaultPadding / 4,
                  vertical: AppDimensions.defaultPadding / 6,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.onSurface.withAlpha(75),
                  borderRadius: BorderRadius.circular(
                    AppDimensions.defaultBorderRadius / 2,
                  ),
                ),
                child: Text(
                  '${product.price.discountPercent!.toInt()}% OFF',
                  style: textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ],
        const SizedBox(height: AppDimensions.defaultMargin / 4),
        Text(
          product.price.formattedDiscountedPrice ?? product.price.formatted,
          style: textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _CTAButtons extends StatelessWidget {
  const _CTAButtons({required this.product});

  final Product product;

  void _onEditBtnTapped(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Edit product feature coming soon!')),
    );
  }

  Future<void> _onDeleteBtnTapped(
    BuildContext context,
    WidgetRef ref,
    Product product,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Product'),
        content: Text('Are you sure you want to delete ${product.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              'Delete',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
    if (confirmed ?? false) {
      await ref.read(myProductsProvider.notifier).deleteProduct(id: product.id);
      ref.invalidate(homeProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => _onEditBtnTapped(context),
          child: Container(
            padding: const EdgeInsets.all(AppDimensions.defaultPadding / 2),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.primary.withAlpha(125),
              ),
              borderRadius: BorderRadius.circular(
                AppDimensions.defaultBorderRadius,
              ),
            ),
            child: Icon(
              Icons.edit_outlined,
              color: Theme.of(context).colorScheme.primary,
              size: AppDimensions.defaultIconSize / 1.5,
            ),
          ),
        ),
        const SizedBox(width: AppDimensions.defaultPadding / 2),
        Consumer(
          builder: (context, ref, child) {
            return GestureDetector(
              onTap: () => _onDeleteBtnTapped(context, ref, product),
              child: Container(
                padding: const EdgeInsets.all(AppDimensions.defaultPadding / 2),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.error.withAlpha(125),
                  ),
                  borderRadius: BorderRadius.circular(
                    AppDimensions.defaultBorderRadius,
                  ),
                ),
                child: Icon(
                  Icons.delete_outline_rounded,
                  color: Theme.of(context).colorScheme.error,
                  size: AppDimensions.defaultIconSize / 1.5,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

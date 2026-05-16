import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_store/core/consts/app_dimensions.dart';
import 'package:my_store/core/theme/app_theme.dart';
import 'package:my_store/shared/cart/domain/entities/cart.dart';
import 'package:my_store/shared/cart/domain/entities/total.dart';
import 'package:my_store/shared/cart/presentation/providers/cart_notifier.dart';
import 'package:my_store/shared/product/domain/entities/price.dart';
import 'package:my_store/shared/product/domain/entities/product.dart';
import 'package:my_store/shared/widgets/generic_error_view.dart';
import 'package:my_store/shared/widgets/generic_progress_indicator.dart';
import 'package:my_store/shared/widgets/main_app_bar.dart';
import 'package:my_store/shared/widgets/primary_button.dart';

const double _imageSize = 72;

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  static const routeName = '/cart';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartAsync = ref.watch(cartProvider);

    return Scaffold(
      appBar: MainAppBar(
        title: 'Cart',
        leadingIcon: Icons.arrow_back_ios_new,
        onLeadingTap: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        child: cartAsync.when(
          skipLoadingOnRefresh: false,
          loading: () {
            return const Center(child: GenericProgressIndicator());
          },
          error: (Object error, StackTrace _) {
            return Center(
              child: GenericErrorView(
                onRetry: () => ref.invalidate(cartProvider),
              ),
            );
          },
          data: (cartData) {
            final hydratedItems = cartData.items;

            return Padding(
              padding: const EdgeInsets.all(AppDimensions.defaultPadding),
              child: Column(
                children: [
                  _CartContent(hydratedItems: hydratedItems),
                  const SizedBox(height: AppDimensions.defaultPadding),
                  Container(
                    padding: const EdgeInsets.all(
                      AppDimensions.defaultPadding / 1.5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.defaultBorderRadius / 2,
                      ),
                      color: Theme.of(
                        context,
                      ).colorScheme.onPrimary.withAlpha(150),
                    ),
                    child: Column(
                      children: [
                        _CartSummary(total: cartData.total),
                        const SizedBox(
                          height: AppDimensions.defaultPadding / 2,
                        ),
                        PrimaryButton(
                          text: 'Place Order',
                          fullWidth: true,
                          onTap: hydratedItems.isEmpty ? null : () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CartContent extends ConsumerWidget {
  const _CartContent({required this.hydratedItems});

  final List<HydratedCartItem> hydratedItems;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (hydratedItems.isEmpty) {
      return Expanded(
        child: Center(
          child: Text(
            'Your cart is empty!',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      );
    }
    return Expanded(
      child: ListView.builder(
        itemCount: hydratedItems.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final hydratedItem = hydratedItems[index];
          final product = hydratedItem.product;

          return Dismissible(
            key: ValueKey(product.id),
            onDismissed: (direction) {
              ref.read(cartProvider.notifier).removeItem(product.id);
            },
            child: _CartItem(hydratedItem: hydratedItem),
          );
        },
      ),
    );
  }
}

class _CartItem extends ConsumerWidget {
  const _CartItem({required this.hydratedItem});

  final HydratedCartItem hydratedItem;

  Product get product => hydratedItem.product;
  CartItem get cartItem => hydratedItem.cartItem;
  double get itemSubtotal => cartItem.calculateSubtotal;
  double get itemTotal => cartItem.calculateTotal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.defaultPadding / 2),
      margin: const EdgeInsets.only(bottom: AppDimensions.defaultPadding),
      decoration: BoxDecoration(
        gradient: theme.extension<AppGradients>()?.cardGradient,
        border: Border.all(color: theme.colorScheme.primary.withAlpha(40)),
        borderRadius: BorderRadius.circular(AppDimensions.defaultBorderRadius),
      ),
      child: Row(
        children: [
          Image.network(
            product.imageUrl,
            width: _imageSize,
            height: _imageSize,
          ),
          const SizedBox(width: AppDimensions.defaultPadding),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(product.name, style: theme.textTheme.bodyLarge),
                const SizedBox(height: AppDimensions.defaultPadding / 2),
                Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onSurface.withAlpha(50),
                    borderRadius: BorderRadius.circular(
                      AppDimensions.defaultBorderRadius,
                    ),
                  ),
                  padding: const EdgeInsets.all(
                    AppDimensions.defaultPadding / 3,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          ref
                              .read(cartProvider.notifier)
                              .updateQuantity(
                                product.id,
                                cartItem.quantity - 1,
                              );
                        },
                        child: Icon(
                          Icons.remove,
                          color: theme.colorScheme.primary,
                          size: 14,
                        ),
                      ),
                      const SizedBox(width: AppDimensions.defaultPadding / 2),
                      Text(
                        '${cartItem.quantity}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: AppDimensions.defaultPadding / 2),
                      GestureDetector(
                        onTap: () {
                          ref
                              .read(cartProvider.notifier)
                              .updateQuantity(
                                product.id,
                                cartItem.quantity + 1,
                              );
                        },
                        child: Icon(
                          Icons.add,
                          color: theme.colorScheme.primary,
                          size: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppDimensions.defaultPadding),
          Column(
            children: [
              if (itemSubtotal != itemTotal) ...[
                Text(
                  itemTotal.asPrice(cartItem.unitPrice.currency),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: AppDimensions.defaultPadding / 4),
                Text(
                  itemSubtotal.asPrice(cartItem.unitPrice.currency),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    decoration: TextDecoration.lineThrough,
                    decorationThickness: 2,
                  ),
                ),
              ] else ...[
                Text(
                  itemTotal.asPrice(cartItem.unitPrice.currency),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _CartSummary extends StatelessWidget {
  const _CartSummary({required this.total});

  final Total total;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _SummaryRow(
          label: 'Subtotal',
          value: total.subtotal.asPrice(total.currency),
        ),
        _SummaryRow(
          label: 'Discount',
          value: total.discount.asPrice(total.currency),
          valueStyle: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Divider(thickness: 0.5),
        _SummaryRow(
          label: 'Total',
          value: total.total.asPrice(total.currency),
          labelStyle: theme.textTheme.titleSmall,
          valueStyle: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.labelStyle,
    this.valueStyle,
  });

  final String label;
  final String value;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.defaultPadding / 4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(label, style: labelStyle ?? theme.textTheme.bodyLarge),
          const SizedBox(width: AppDimensions.defaultPadding),
          Text(value, style: valueStyle ?? theme.textTheme.bodyLarge),
        ],
      ),
    );
  }
}

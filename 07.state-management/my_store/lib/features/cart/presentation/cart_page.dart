import 'package:flutter/material.dart';
import 'package:my_store/core/consts/app_consts.dart';
import 'package:my_store/core/theme/app_theme.dart';
import 'package:my_store/data/models/cart.dart';
import 'package:my_store/data/models/price.dart';
import 'package:my_store/data/models/product.dart';
import 'package:my_store/data/models/total.dart';
import 'package:my_store/data/store/mock_data.dart';
import 'package:my_store/shared/widgets/cta_panel.dart';
import 'package:my_store/shared/widgets/decorated_icon_cta.dart';

const double _imageSize = 72;

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  static const routeName = '/cart';

  AppBar _buildAppBar(TextTheme textTheme) {
    return AppBar(
      title: Text(
        'Cart',
        style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
      ),
      centerTitle: true,
      leading: Builder(
        builder: (context) {
          return DecoratedIconCta(
            icon: Icons.arrow_back_ios_new,
            onTap: () {
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = MockData.cart;
    final cartItems = cart.items;

    // We use separate lists to ensure:
    // - Interface Segregation: Decouples the tight coupling between models.
    // - Explicit Intent: Clarifies the "data contract" for the needed data only.
    // - Future Proofing: Supports future items with different data structures.
    List<(CartItem, Price)> cartItemsWithPrices = [];
    List<(CartItem, Product)> cartItemsWithProductDetails = [];

    for (final cartItem in cartItems) {
      final productIndex = MockData.products.indexWhere((p) {
        return p.id == cartItem.productId;
      });

      if (productIndex >= 0) {
        cartItemsWithProductDetails.add((
          cartItem,
          MockData.products[productIndex],
        ));
        cartItemsWithPrices.add((
          cartItem,
          MockData.products[productIndex].price,
        ));
      }
    }

    final total = Total.calculate(cartItemsWithPrices);

    return Scaffold(
      appBar: _buildAppBar(Theme.of(context).textTheme),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppConsts.defaultPadding),
          child: Column(
            children: [
              _CartContent(
                cartItemsWithProductDetails: cartItemsWithProductDetails,
              ),
              const SizedBox(height: AppConsts.defaultPadding),
              Container(
                padding: const EdgeInsets.all(AppConsts.defaultPadding / 1.5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    AppConsts.defaultBorderRadius / 2,
                  ),
                  color: Theme.of(context).colorScheme.onPrimary.withAlpha(150),
                ),
                child: Column(
                  children: [
                    _CartSummary(total: total),
                    const SizedBox(height: AppConsts.defaultPadding / 2),
                    CTAPanel(
                      title: 'Place Order',
                      onTap: cartItems.isEmpty ? null : () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CartContent extends StatelessWidget {
  const _CartContent({required this.cartItemsWithProductDetails});

  final List<(CartItem, Product)> cartItemsWithProductDetails;

  @override
  Widget build(BuildContext context) {
    if (cartItemsWithProductDetails.isEmpty) {
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
        itemCount: cartItemsWithProductDetails.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final (cartItem, product) = cartItemsWithProductDetails[index];

          return Dismissible(
            key: ValueKey(cartItem.productId),
            onDismissed: (direction) {},
            child: _CartItem(item: cartItemsWithProductDetails[index]),
          );
        },
      ),
    );
  }
}

class _CartItem extends StatelessWidget {
  const _CartItem({required this.item});

  final (CartItem, Product) item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final (cartItem, product) = item;

    final itemSubtotal = cartItem.calculateSubtotal(product.price);
    final itemTotal = cartItem.calculateTotal(product.price);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConsts.defaultPadding / 2),
      margin: const EdgeInsets.only(bottom: AppConsts.defaultPadding),
      decoration: BoxDecoration(
        gradient: theme.extension<AppGradients>()?.cardGradient,
        border: Border.all(color: theme.colorScheme.primary.withAlpha(40)),
        borderRadius: BorderRadius.circular(AppConsts.defaultBorderRadius),
      ),
      child: Row(
        children: [
          Image.network(
            product.imageUrl,
            width: _imageSize,
            height: _imageSize,
          ),
          const SizedBox(width: AppConsts.defaultPadding),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(product.name, style: theme.textTheme.bodyLarge),
                const SizedBox(height: AppConsts.defaultPadding / 2),
                Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onSurface.withAlpha(50),
                    borderRadius: BorderRadius.circular(
                      AppConsts.defaultBorderRadius,
                    ),
                  ),
                  padding: const EdgeInsets.all(AppConsts.defaultPadding / 3),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DecoratedIconCta(
                        icon: Icons.remove,
                        iconColor: theme.colorScheme.primary,
                        iconSize: 14,
                        onTap: () {},
                      ),
                      const SizedBox(width: AppConsts.defaultPadding / 2),
                      Text(
                        '${cartItem.quantity}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: AppConsts.defaultPadding / 2),
                      DecoratedIconCta(
                        icon: Icons.add,
                        iconColor: theme.colorScheme.primary,
                        iconSize: 14,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppConsts.defaultPadding),
          Column(
            children: [
              if (itemSubtotal != itemTotal) ...[
                Text(
                  itemTotal.asPrice(product.price.currency),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: AppConsts.defaultPadding / 4),
                Text(
                  itemSubtotal.asPrice(product.price.currency),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    decoration: TextDecoration.lineThrough,
                    decorationThickness: 2,
                  ),
                ),
              ] else ...[
                Text(
                  itemTotal.asPrice(product.price.currency),
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
        horizontal: AppConsts.defaultPadding / 4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(label, style: labelStyle ?? theme.textTheme.bodyLarge),
          const SizedBox(width: AppConsts.defaultPadding),
          Text(value, style: valueStyle ?? theme.textTheme.bodyLarge),
        ],
      ),
    );
  }
}

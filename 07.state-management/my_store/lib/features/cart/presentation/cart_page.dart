import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_store/core/consts/app_consts.dart';
import 'package:my_store/core/theme/app_theme.dart';
import 'package:my_store/data/models/cart_item.dart';
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
    final cartItems = MockData.products.map((p) {
      return CartItem(
        productId: p.id,
        quantity: Random().nextInt(5) + 1,
      );
    }).toList();

    final Total total;
    if (cartItems.isEmpty) {
      total = const Total(subtotal: 0, discount: 0, total: 0, currency: '');
    } else {
      double subtotal = 0;
      double discount = 0;
      double totalAmount = 0;
      for (final item in cartItems) {
        final product = MockData.products.firstWhere((p) => p.id == item.productId);
        final itemSubtotal = product.price.amount * item.quantity;
        subtotal += itemSubtotal;
        
        double itemDiscount = 0;
        if (product.price.discountPercent != null && product.price.discountPercent! > 0) {
          itemDiscount = (product.price.amount * product.price.discountPercent! / 100) * item.quantity;
        }
        discount += itemDiscount;
        totalAmount += itemSubtotal - itemDiscount;
      }
      
      final firstProduct = MockData.products.firstWhere((p) => p.id == cartItems.first.productId);

      total = Total(
        subtotal: subtotal,
        discount: discount,
        total: totalAmount,
        currency: firstProduct.price.currency,
      );
    }

    return Scaffold(
      appBar: _buildAppBar(Theme.of(context).textTheme),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppConsts.defaultPadding),
          child: Column(
            children: [
              _CartContent(cartItems: cartItems),
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
  const _CartContent({required this.cartItems});

  final List<CartItem> cartItems;

  @override
  Widget build(BuildContext context) {
    if (cartItems.isEmpty) {
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
        itemCount: cartItems.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey(cartItems[index].productId),
            onDismissed: (direction) {},
            child: _CartItem(item: cartItems[index]),
          );
        },
      ),
    );
  }
}

class _CartItem extends StatelessWidget {
  const _CartItem({required this.item});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final product = MockData.products.firstWhere((p) => p.id == item.productId);
    
    final itemSubtotal = product.price.amount * item.quantity;
    double itemDiscount = 0;
    if (product.price.discountPercent != null && product.price.discountPercent! > 0) {
      itemDiscount = (product.price.amount * product.price.discountPercent! / 100) * item.quantity;
    }
    final itemTotal = itemSubtotal - itemDiscount;

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
          Image.network(product.imageUrl, width: _imageSize, height: _imageSize),
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
                        '${item.quantity}',
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
                  '${product.price.currency.asCurrencySymbol}${itemTotal.toStringAsFixed(2)}',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: AppConsts.defaultPadding / 4),
                Text(
                  '${product.price.currency.asCurrencySymbol}${itemSubtotal.toStringAsFixed(2)}',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    decoration: TextDecoration.lineThrough,
                    decorationThickness: 2,
                  ),
                ),
              ] else ...[
                Text(
                  '${product.price.currency.asCurrencySymbol}$itemTotal',
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConsts.defaultPadding / 4,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Subtotal', style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(width: AppConsts.defaultPadding),
              Text(
                '${total.currency.asCurrencySymbol}${total.subtotal}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConsts.defaultPadding / 4,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Discount', style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(width: AppConsts.defaultPadding),
              Text(
                '${total.currency.asCurrencySymbol}${total.discount}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const Divider(thickness: 0.5),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConsts.defaultPadding / 4,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Total', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(width: AppConsts.defaultPadding),
              Text(
                '${total.currency.asCurrencySymbol}${total.total}',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

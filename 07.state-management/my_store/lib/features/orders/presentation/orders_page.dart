import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_store/core/consts/app_consts.dart';
import 'package:my_store/core/theme/app_theme.dart';
import 'package:my_store/data/models/order.dart';
import 'package:my_store/data/models/price.dart';
import 'package:my_store/data/models/product.dart';
import 'package:my_store/data/store/mock_data.dart';
import 'package:my_store/shared/widgets/decorated_icon_cta.dart';
import 'package:my_store/shared/widgets/drawer.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  static const routeName = '/orders';

  AppBar _buildAppBar(TextTheme textTheme) {
    return AppBar(
      title: Text(
        'Orders',
        style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
      ),
      centerTitle: true,
      leading: Builder(
        builder: (context) {
          return DecoratedIconCta(
            icon: Icons.menu_rounded,
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final orders = MockData.orders;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: _buildAppBar(textTheme),
      drawer: const AppDrawer(),
      body: _OrdersContent(orders: orders),
    );
  }
}

class _OrdersContent extends StatelessWidget {
  const _OrdersContent({required this.orders});

  final List<Order> orders;

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return Center(
        child: Text(
          'No orders yet!',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(AppConsts.defaultPadding),
      physics: const BouncingScrollPhysics(),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return _OrderCard(order: orders[index]);
      },
    );
  }
}

class _OrderCard extends StatefulWidget {
  const _OrderCard({required this.order});

  final Order order;

  @override
  State<_OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<_OrderCard> {
  bool _isExpanded = false;

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  Widget _expandedSection() {
    if (!_isExpanded) return const SizedBox.shrink();

    final items = widget.order.lineItems;

    return Column(
      children: [
        const Divider(thickness: 0.5, height: 1),
        for (final i in items) _OrderLineItemRow(item: i),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: AppConsts.defaultPadding),
      decoration: BoxDecoration(
        gradient: theme.extension<AppGradients>()?.cardGradient,
        border: Border.all(color: theme.colorScheme.primary.withAlpha(40)),
        borderRadius: BorderRadius.circular(AppConsts.defaultBorderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _OrderHeader(
            orderId: widget.order.id,
            placedAt: widget.order.placedAt,
            isExpanded: _isExpanded,
            onToggle: _toggleExpansion,
          ),
          ClipRect(
            child: AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: _expandedSection(),
            ),
          ),
          const Divider(thickness: 0.5, height: 1),
          _OrderFooter(
            itemCount: widget.order.lineItems.length,
            currency: widget.order.currency.asCurrencySymbol,
            total: widget.order.total.toStringAsFixed(2),
          ),
        ],
      ),
    );
  }
}

class _OrderHeader extends StatelessWidget {
  const _OrderHeader({
    required this.orderId,
    required this.placedAt,
    required this.isExpanded,
    required this.onToggle,
  });

  final String orderId;
  final DateTime placedAt;
  final bool isExpanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onToggle,
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(AppConsts.defaultBorderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConsts.defaultPadding,
          vertical: AppConsts.defaultPadding * 0.75,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    orderId,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: AppConsts.defaultPadding / 8),
                  Text(
                    DateFormat.yMMMd().format(placedAt),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withAlpha(150),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedRotation(
              turns: isExpanded ? 0.5 : 0,
              duration: const Duration(milliseconds: 300),
              child: Icon(
                Icons.expand_more_rounded,
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderLineItemRow extends StatelessWidget {
  const _OrderLineItemRow({required this.item});

  final OrderLineItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currency = item.purchasePrice.currency.asCurrencySymbol;
    final purchaseTotal = item.purchaseTotal.toStringAsFixed(2);
    final unitPrice = item.purchasePrice.amount.toStringAsFixed(2);

    final Product? product = MockData.products.cast<Product?>().firstWhere(
      (p) => p?.id == item.productId,
      orElse: () => null,
    );

    final Widget image;
    final String productName;

    if (product == null) {
      productName = 'Product Not Found';
      image = Container(
        width: 48,
        height: 48,
        color: theme.colorScheme.onSurface.withAlpha(20),
        child: Icon(
          Icons.image_not_supported_outlined,
          size: 20,
          color: theme.colorScheme.onSurface.withAlpha(80),
        ),
      );
    } else {
      productName = product.name;
      image = Image.network(
        product.imageUrl,
        width: 48,
        height: 48,
        fit: BoxFit.cover,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConsts.defaultPadding,
        vertical: AppConsts.defaultPadding / 2,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
              AppConsts.defaultBorderRadius / 2,
            ),
            child: image,
          ),
          const SizedBox(width: AppConsts.defaultPadding / 1.5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: theme.textTheme.bodyLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '$currency$unitPrice x ${item.quantity}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withAlpha(150),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppConsts.defaultPadding / 2),
          Text(
            '$currency$purchaseTotal',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderFooter extends StatelessWidget {
  const _OrderFooter({
    required this.itemCount,
    required this.currency,
    required this.total,
  });

  final int itemCount;
  final String currency;
  final String total;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConsts.defaultPadding,
        vertical: AppConsts.defaultPadding * 0.75,
      ),
      child: Row(
        children: [
          Text(
            '$itemCount item${itemCount > 1 ? 's' : ''}',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withAlpha(150),
            ),
          ),
          const SizedBox(width: AppConsts.defaultPadding / 2),
          Expanded(
            child: Text.rich(
              textAlign: TextAlign.right,
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Order Total  ',
                    style: theme.textTheme.bodyLarge,
                  ),
                  TextSpan(
                    text: '$currency$total',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

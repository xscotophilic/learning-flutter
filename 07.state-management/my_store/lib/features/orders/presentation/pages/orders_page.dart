import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:my_store/core/consts/app_dimensions.dart';
import 'package:my_store/core/theme/app_theme.dart';
import 'package:my_store/features/orders/domain/entities/order.dart';
import 'package:my_store/features/orders/presentation/providers/order_history_notifier.dart';
import 'package:my_store/shared/product/domain/entities/price.dart';
import 'package:my_store/shared/product/domain/entities/product.dart';
import 'package:my_store/shared/product/presentation/providers/product_notifier.dart';
import 'package:my_store/shared/widgets/app_drawer.dart';
import 'package:my_store/shared/widgets/generic_error_view.dart';
import 'package:my_store/shared/widgets/generic_progress_indicator.dart';
import 'package:my_store/shared/widgets/main_app_bar.dart';

class OrdersPage extends ConsumerWidget {
  OrdersPage({super.key});

  static const routeName = '/orders';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderHistoryAsync = ref.watch(orderHistoryProvider);

    return Scaffold(
      key: _scaffoldKey,
      appBar: MainAppBar(
        title: 'Orders',
        leadingIcon: Icons.menu_rounded,
        onLeadingTap: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      drawer: const AppDrawer(),
      body: orderHistoryAsync.when(
        skipLoadingOnRefresh: false,
        loading: () {
          return const Center(child: GenericProgressIndicator());
        },
        error: (Object error, StackTrace stackTrace) {
          return Center(
            child: GenericErrorView(
              onRetry: () => ref.invalidate(orderHistoryProvider),
            ),
          );
        },
        data: (snapshot) {
          return _OrdersContent(orders: snapshot);
        },
      ),
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
      padding: const EdgeInsets.all(AppDimensions.defaultPadding),
      physics: const BouncingScrollPhysics(),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return _OrderCard(order: orders[index]);
      },
    );
  }
}

class _OrderCard extends ConsumerStatefulWidget {
  const _OrderCard({required this.order});

  final Order order;

  @override
  ConsumerState<_OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends ConsumerState<_OrderCard> {
  bool _isExpanded = false;

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  Widget _expandedSection() {
    if (!_isExpanded) return const SizedBox.shrink();

    final items = widget.order.lineItems;

    final productStates = items.map((item) {
      return ref.watch(productProvider(item.productId));
    }).toList();

    if (productStates.any((state) => state.isLoading)) {
      return const Center(child: GenericProgressIndicator());
    }

    return Column(
      children: [
        const Divider(thickness: 0.5, height: 1),
        for (int i = 0; i < items.length; i++) ...[
          _OrderLineItemRow(
            item: items[i],
            product: productStates[i].hasError ? null : productStates[i].value,
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.defaultPadding),
      decoration: BoxDecoration(
        gradient: theme.extension<AppGradients>()?.cardGradient,
        border: Border.all(color: theme.colorScheme.primary.withAlpha(40)),
        borderRadius: BorderRadius.circular(AppDimensions.defaultBorderRadius),
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
            formattedTotal: widget.order.total.asPrice(
              widget.order.currency ?? '',
            ),
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
        top: Radius.circular(AppDimensions.defaultBorderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.defaultPadding,
          vertical: AppDimensions.defaultPadding * 0.75,
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
                  const SizedBox(height: AppDimensions.defaultPadding / 8),
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
  const _OrderLineItemRow({required this.item, required this.product});

  final OrderLineItem item;
  final Product? product;

  @override
  Widget build(BuildContext context) {
    final Widget image;
    final String productName;
    final theme = Theme.of(context);

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
      productName = product?.name ?? '';
      image = Image.network(
        product?.imageUrl ?? '',
        width: 48,
        height: 48,
        fit: BoxFit.cover,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.defaultPadding,
        vertical: AppDimensions.defaultPadding / 2,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
              AppDimensions.defaultBorderRadius / 2,
            ),
            child: image,
          ),
          const SizedBox(width: AppDimensions.defaultPadding / 1.5),
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
                  '${item.purchasePrice.formattedDiscountedPrice ?? item.purchasePrice.formatted} x ${item.quantity}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withAlpha(150),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppDimensions.defaultPadding / 2),
          Text(
            item.purchaseTotal.asPrice(item.purchasePrice.currency),
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
  const _OrderFooter({required this.itemCount, required this.formattedTotal});

  final int itemCount;
  final String formattedTotal;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.defaultPadding,
        vertical: AppDimensions.defaultPadding * 0.75,
      ),
      child: Row(
        children: [
          Text(
            '$itemCount item${itemCount > 1 ? 's' : ''}',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withAlpha(150),
            ),
          ),
          const SizedBox(width: AppDimensions.defaultPadding / 2),
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
                    text: formattedTotal,
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

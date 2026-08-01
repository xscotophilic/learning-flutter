import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_store/core/consts/app_dimensions.dart';
import 'package:my_store/features/cart/presentation/providers/cart_notifier.dart';

class CartBadge extends ConsumerWidget {
  const CartBadge({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartAsync = ref.watch(cartProvider);

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Icon(Icons.shopping_bag_outlined),
          cartAsync.maybeWhen(
            data: (snapshot) {
              final items = snapshot.cart.items;

              if (items.isEmpty) return const SizedBox.shrink();

              final totalItems = items.fold<int>(0, (sum, hydratedCartItem) {
                return sum + hydratedCartItem.cartItem.quantity;
              });

              return Positioned(
                right: -AppDimensions.defaultMargin / 2,
                top: -AppDimensions.defaultMargin / 2,
                child: Container(
                  padding: const EdgeInsets.all(
                    AppDimensions.defaultBorderRadius / 2,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: AppDimensions.defaultMargin,
                    minHeight: AppDimensions.defaultMargin,
                  ),
                  child: Text(
                    '$totalItems',
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_store/shared/cart/presentation/providers/cart_notifier.dart';
import 'package:my_store/shared/product/domain/entities/product.dart';
import 'package:my_store/shared/widgets/primary_button.dart';
import 'package:my_store/shared/widgets/secondary_button.dart';

enum AddToCartButtonStyle { outlined, elevated }

class AddToCartButton extends ConsumerWidget {
  const AddToCartButton({
    super.key,
    required this.product,
    this.style = AddToCartButtonStyle.outlined,
  });

  final Product product;
  final AddToCartButtonStyle style;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onPressed() {
      ref.read(cartProvider.notifier).addItem(product.id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${product.name} added to cart'),
          duration: const Duration(seconds: 2),
        ),
      );
    }

    return switch (style) {
      AddToCartButtonStyle.elevated => PrimaryButton(
        text: 'Add to Cart',
        fullWidth: true,
        onTap: onPressed,
      ),
      AddToCartButtonStyle.outlined => SecondaryButton(
        text: 'Add to Cart',
        fullWidth: true,
        onTap: onPressed,
      ),
    };
  }
}

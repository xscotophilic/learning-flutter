import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_store/features/cart/presentation/providers/cart_notifier.dart';
import 'package:my_store/features/product/domain/entities/product.dart';
import 'package:my_store/shared/widgets/primary_button.dart';
import 'package:my_store/shared/widgets/secondary_button.dart';
import 'package:my_store/shared/widgets/snackbar.dart';

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
      final snapshot = ref.read(cartProvider);
      final isMutationPending = snapshot.value?.isMutating ?? false;

      if (isMutationPending) {
        AppSnackBar.showErrorSnackBar(
          context,
          clearSnackBars: true,
          message: 'Slow down a bit, we are processing your request...',
        );
        return;
      }

      ref.read(cartProvider.notifier).addItem(product.id);
      AppSnackBar.showSuccessSnackBar(
        context,
        clearSnackBars: true,
        message: '${product.name} added to cart',
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

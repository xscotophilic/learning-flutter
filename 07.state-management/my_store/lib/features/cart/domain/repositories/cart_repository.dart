import 'package:my_store/features/cart/domain/entities/cart.dart';

abstract interface class CartRepository {
  const CartRepository();

  Future<Cart<CartItem>> getOrCreateCart();

  Future<Cart<CartItem>> updateItem({
    required String cartId,
    required String productId,
    required int quantity,
  });
}

import 'package:my_store/shared/cart/domain/entities/cart.dart';

abstract interface class CartRepository {
  const CartRepository();

  Future<Cart<CartItem>> getOrCreateCart();

  Future<Cart<CartItem>> updateItem(String productId, int quantity);
}

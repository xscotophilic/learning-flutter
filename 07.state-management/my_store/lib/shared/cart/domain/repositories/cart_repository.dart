import 'package:my_store/shared/cart/domain/entities/cart.dart';

abstract interface class CartRepository {
  const CartRepository();

  Future<Cart> getOrCreateCart();

  Future<Cart> updateItem(String productId, int quantity);
}

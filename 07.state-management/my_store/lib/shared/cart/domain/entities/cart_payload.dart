import 'package:my_store/shared/cart/domain/entities/cart.dart';

class CartPayload<T> {
  const CartPayload({required this.cart});

  factory CartPayload.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> json) fromJsonT,
  ) {
    return CartPayload<T>(
      cart: Cart<T>.fromJson(json['cart'] as Map<String, dynamic>, fromJsonT),
    );
  }

  final Cart<T> cart;
}

import 'package:my_store/shared/cart/domain/entities/total.dart';
import 'package:my_store/shared/product/domain/entities/price.dart';
import 'package:my_store/shared/product/domain/entities/product.dart';

enum CartStatus { active, completed, abandoned }

class CartItem {
  const CartItem({
    required this.productId,
    required this.unitPrice,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['product_id'] as String,
      unitPrice: Price.fromJson(json['unit_price'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
    );
  }

  CartItem copyWith({String? productId, Price? unitPrice, int? quantity}) {
    return CartItem(
      productId: productId ?? this.productId,
      unitPrice: unitPrice ?? this.unitPrice,
      quantity: quantity ?? this.quantity,
    );
  }

  final String productId;
  final Price unitPrice;
  final int quantity;

  double get calculateSubtotal => unitPrice.amount * quantity;

  double get calculateTotalDiscount {
    final discountPercent = unitPrice.discountPercent ?? 0;
    if (discountPercent > 0) {
      return (unitPrice.amount * discountPercent / 100) * quantity;
    }
    return 0;
  }

  double get calculateTotal {
    return calculateSubtotal - calculateTotalDiscount;
  }
}

class HydratedCartItem {
  const HydratedCartItem({required this.cartItem, required this.product});

  factory HydratedCartItem.fromJson(Map<String, dynamic> json) {
    return HydratedCartItem(
      cartItem: CartItem.fromJson(json['cart_item'] as Map<String, dynamic>),
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
    );
  }

  final CartItem cartItem;
  final Product product;
}

class Cart<T> {
  const Cart({
    required this.id,
    required this.ownerId,
    required this.createdAt,
    required this.status,
    required this.items,
    required this.total,
  });

  factory Cart.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> json) fromJsonT,
  ) {
    return Cart<T>(
      id: json['id'] as String,
      ownerId: json['owner_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      status: CartStatus.values.firstWhere(
        (e) => e.name == json['status'] as String,
      ),
      items: (json['items'] as List<dynamic>).map((e) {
        return fromJsonT(e as Map<String, dynamic>);
      }).toList(),
      total: Total.fromJson(json['total'] as Map<String, dynamic>),
    );
  }

  Cart<T> copyWith({
    String? id,
    String? ownerId,
    DateTime? createdAt,
    CartStatus? status,
    List<T>? items,
    Total? total,
  }) {
    return Cart<T>(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      items: items ?? this.items,
      total: total ?? this.total,
    );
  }

  final String id;
  final String ownerId;
  final DateTime createdAt;
  final CartStatus status;
  final List<T> items;
  final Total total;
}

class CartSnapshot<T> {
  const CartSnapshot({required this.isMutating, required this.cart});

  CartSnapshot<T> copyWith({bool? isMutating, Cart<T>? cart}) {
    return CartSnapshot<T>(
      isMutating: isMutating ?? this.isMutating,
      cart: cart ?? this.cart,
    );
  }

  final bool isMutating;
  final Cart<T> cart;
}

import 'package:my_store/features/cart/domain/entities/cart.dart';
import 'package:my_store/features/cart/domain/entities/total.dart';
import 'package:my_store/features/product/data/models/product_model.dart';

class TotalModel {
  const TotalModel({
    required this.subtotal,
    required this.discount,
    required this.total,
    required this.currency,
  });

  factory TotalModel.fromJson(Map<String, dynamic> json) {
    return TotalModel(
      subtotal: (json['subtotal'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      currency: json['currency'] as String,
    );
  }

  final double subtotal;
  final double discount;
  final double total;
  final String currency;

  Total toDomain() {
    return Total(
      subtotal: subtotal,
      discount: discount,
      total: total,
      currency: currency,
    );
  }
}

class CartItemModel {
  const CartItemModel({
    required this.productId,
    required this.unitPrice,
    required this.quantity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['product_id'] as String,
      unitPrice: PriceModel.fromJson(
        json['unit_price'] as Map<String, dynamic>,
      ),
      quantity: json['quantity'] as int,
    );
  }

  final String productId;
  final PriceModel unitPrice;
  final int quantity;

  CartItem toDomain() {
    return CartItem(
      productId: productId,
      unitPrice: unitPrice.toDomain(),
      quantity: quantity,
    );
  }
}

class CartModel {
  const CartModel({
    required this.id,
    required this.ownerId,
    required this.createdAt,
    required this.status,
    required this.items,
    required this.total,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'] as String,
      ownerId: json['owner_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      status: CartStatus.values.firstWhere(
        (e) => e.name == json['status'] as String,
      ),
      items: (json['items'] as List<dynamic>).map((e) {
        return CartItemModel.fromJson(e as Map<String, dynamic>);
      }).toList(),
      total: TotalModel.fromJson(json['total'] as Map<String, dynamic>),
    );
  }

  final String id;
  final String ownerId;
  final DateTime createdAt;
  final CartStatus status;
  final List<CartItemModel> items;
  final TotalModel total;

  Cart<CartItem> toDomain() {
    return Cart<CartItem>(
      id: id,
      ownerId: ownerId,
      createdAt: createdAt,
      status: status,
      items: items.map((i) => i.toDomain()).toList(),
      total: total.toDomain(),
    );
  }
}

class CartPayloadModel {
  const CartPayloadModel({required this.cart});

  factory CartPayloadModel.fromJson(Map<String, dynamic> json) {
    return CartPayloadModel(
      cart: CartModel.fromJson(json['cart'] as Map<String, dynamic>),
    );
  }

  final CartModel cart;

  Cart<CartItem> toDomain() {
    return cart.toDomain();
  }
}

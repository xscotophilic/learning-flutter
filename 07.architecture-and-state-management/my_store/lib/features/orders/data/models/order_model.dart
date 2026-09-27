import 'package:my_store/features/orders/domain/entities/order.dart';
import 'package:my_store/features/product/data/models/product_model.dart';

class OrderLineItemModel {
  const OrderLineItemModel({
    required this.productId,
    required this.quantity,
    required this.purchasePrice,
  });

  factory OrderLineItemModel.fromJson(Map<String, dynamic> json) {
    return OrderLineItemModel(
      productId: json['product_id'] as String,
      quantity: json['quantity'] as int,
      purchasePrice: PriceModel.fromJson(
        json['purchase_price'] as Map<String, dynamic>,
      ),
    );
  }

  final String productId;
  final int quantity;
  final PriceModel purchasePrice;

  OrderLineItem toDomain() {
    return OrderLineItem(
      productId: productId,
      quantity: quantity,
      purchasePrice: purchasePrice.toDomain(),
    );
  }
}

class OrderModel {
  const OrderModel({
    required this.id,
    required this.placedAt,
    required this.lineItems,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final lineItems = (json['line_items'] as List<dynamic>?)?.map((e) {
      return OrderLineItemModel.fromJson(e as Map<String, dynamic>);
    }).toList();
    return OrderModel(
      id: json['id'] as String,
      placedAt: DateTime.parse(json['placed_at'] as String),
      lineItems: lineItems ?? [],
    );
  }

  final String id;
  final DateTime placedAt;
  final List<OrderLineItemModel> lineItems;

  Order toDomain() {
    return Order(
      id: id,
      placedAt: placedAt,
      lineItems: lineItems.map((item) => item.toDomain()).toList(),
    );
  }
}

class OrdersPayloadModel {
  const OrdersPayloadModel({required this.orders});

  factory OrdersPayloadModel.fromJson(Map<String, dynamic> json) {
    final orders = (json['orders'] as List<dynamic>?)?.map((e) {
      return OrderModel.fromJson(e as Map<String, dynamic>);
    }).toList();
    return OrdersPayloadModel(orders: orders ?? []);
  }

  final List<OrderModel> orders;

  List<Order> toDomain() {
    return orders.map((o) => o.toDomain()).toList();
  }
}

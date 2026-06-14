import 'package:my_store/features/orders/domain/entities/order.dart';

class OrdersPayload {
  const OrdersPayload({required this.orders});

  factory OrdersPayload.fromJson(Map<String, dynamic> json) {
    final orders = (json['orders'] as List<dynamic>?)?.map((e) {
      return Order.fromJson(e as Map<String, dynamic>);
    }).toList();
    return OrdersPayload(orders: orders ?? []);
  }

  final List<Order> orders;
}

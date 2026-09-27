import 'package:my_store/features/orders/domain/entities/order.dart';

abstract interface class OrdersRepository {
  const OrdersRepository();

  Future<void> placeOrder({
    required String cartId,
    required String paymentId,
    required String paymentMethodId,
  });

  Future<List<Order>> getOrders();
}

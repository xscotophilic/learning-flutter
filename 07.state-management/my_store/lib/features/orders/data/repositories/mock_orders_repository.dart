import 'package:my_store/features/orders/domain/entities/order.dart';
import 'package:my_store/features/orders/domain/entities/orders_payload.dart';
import 'package:my_store/features/orders/domain/repositories/orders_repository.dart';
import 'package:my_store/shared/mock_server/mock_server.dart';

final class MockOrdersRepository implements OrdersRepository {
  const MockOrdersRepository();

  @override
  Future<void> placeOrder({
    required String cartId,
    required String paymentId,
    required String paymentMethodId,
  }) async {
    await MockServer.placeOrder(
      cartId: cartId,
      paymentId: paymentId,
      paymentMethodId: paymentMethodId,
    );
  }

  @override
  Future<List<Order>> getOrders() async {
    final response = await MockServer.getOrders();

    final orders = OrdersPayload.fromJson(
      response as Map<String, dynamic>,
    ).orders;

    return orders;
  }
}

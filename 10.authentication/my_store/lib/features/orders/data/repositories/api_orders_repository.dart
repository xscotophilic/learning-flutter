import 'package:my_store/core/network/api_client.dart';
import 'package:my_store/features/orders/data/models/order_model.dart';
import 'package:my_store/features/orders/domain/entities/order.dart';
import 'package:my_store/features/orders/domain/repositories/orders_repository.dart';

final class ApiOrdersRepository implements OrdersRepository {
  const ApiOrdersRepository(this.apiClient);

  final ApiClient apiClient;

  @override
  Future<void> placeOrder({
    required String cartId,
    required String paymentId,
    required String paymentMethodId,
  }) async {
    await apiClient.post(
      '/orders',
      body: {
        'cart_id': cartId,
        'payment_id': paymentId,
        'payment_method_id': paymentMethodId,
      },
    );
  }

  @override
  Future<List<Order>> getOrders() async {
    final json = await apiClient.get('/orders');

    final orders = OrdersPayloadModel.fromJson(
      json as Map<String, dynamic>,
    ).toDomain();

    return orders;
  }
}

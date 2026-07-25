import 'package:my_store/core/network/api_client.dart';
import 'package:my_store/features/cart/data/models/cart_model.dart';
import 'package:my_store/features/cart/domain/entities/cart.dart';
import 'package:my_store/features/cart/domain/repositories/cart_repository.dart';

final class ApiCartRepository implements CartRepository {
  const ApiCartRepository(this.apiClient);

  final ApiClient apiClient;

  @override
  Future<Cart<CartItem>> getOrCreateCart() async {
    final json = await apiClient.get('/cart');

    return CartPayloadModel.fromJson(json as Map<String, dynamic>).toDomain();
  }

  @override
  Future<Cart<CartItem>> updateItem({
    required String cartId,
    required String productId,
    required int quantity,
  }) async {
    final json = await apiClient.patch(
      '/cart/items',
      body: {'cart_id': cartId, 'product_id': productId, 'quantity': quantity},
    );

    return CartPayloadModel.fromJson(json as Map<String, dynamic>).toDomain();
  }
}

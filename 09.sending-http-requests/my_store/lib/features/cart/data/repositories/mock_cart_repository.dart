import 'package:my_store/features/cart/data/models/cart_model.dart';
import 'package:my_store/features/cart/domain/entities/cart.dart';
import 'package:my_store/features/cart/domain/repositories/cart_repository.dart';
import 'package:my_store/mock_server/mock_server.dart';

final class MockCartRepository implements CartRepository {
  MockCartRepository();

  final MockServer _mockServer = MockServer();
  static const Duration _kNetworkDelay = Duration(milliseconds: 250);

  @override
  Future<Cart<CartItem>> getOrCreateCart() async {
    await Future<void>.delayed(_kNetworkDelay);

    final response = await _mockServer.getOrCreateCart();

    return CartPayloadModel.fromJson(response).toDomain();
  }

  @override
  Future<Cart<CartItem>> updateItem({
    required String cartId,
    required String productId,
    required int quantity,
  }) async {
    await Future<void>.delayed(_kNetworkDelay);

    final response = await _mockServer.updateItem(
      cartId: cartId,
      productId: productId,
      quantity: quantity,
    );

    return CartPayloadModel.fromJson(response).toDomain();
  }
}

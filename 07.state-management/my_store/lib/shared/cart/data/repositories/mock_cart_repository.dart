import 'package:my_store/shared/app/stores/mock_server.dart';
import 'package:my_store/shared/cart/domain/entities/cart.dart';
import 'package:my_store/shared/cart/domain/repositories/cart_repository.dart';

final class MockCartRepository implements CartRepository {
  MockCartRepository();

  final MockServer _mockServer = MockServer();
  static const Duration _kNetworkDelay = Duration(milliseconds: 250);

  @override
  Future<Cart<CartItem>> getOrCreateCart() async {
    await Future<void>.delayed(_kNetworkDelay);

    final cart = await _mockServer.getOrCreateCart();

    return cart;
  }

  @override
  Future<Cart<CartItem>> updateItem({
    required String cartId,
    required String productId,
    required int quantity,
  }) async {
    await Future<void>.delayed(_kNetworkDelay);

    final cart = await _mockServer.updateItem(
      cartId: cartId,
      productId: productId,
      quantity: quantity,
    );

    return cart;
  }
}

import 'package:my_store/shared/cart/domain/entities/cart.dart';
import 'package:my_store/shared/cart/domain/entities/total.dart';
import 'package:my_store/shared/cart/domain/exceptions/cart_exceptions.dart';
import 'package:my_store/shared/cart/domain/repositories/cart_repository.dart';
import 'package:my_store/shared/product/data/data_sources/mock_data.dart';
import 'package:my_store/shared/product/domain/entities/price.dart';

final class MockCartRepository implements CartRepository {
  MockCartRepository();

  static const Duration _kNetworkDelay = Duration(milliseconds: 250);

  Cart? _cart;

  @override
  Future<Cart> getOrCreateCart() async {
    await Future<void>.delayed(_kNetworkDelay);
    return _cart ??= Cart(
      id: 'mock-cart-id',
      ownerId: 'mock-user-id',
      createdAt: DateTime.now(),
      items: [],
      total: Total.calculate([]),
    );
  }

  @override
  Future<Cart> updateItem(String productId, int quantity) async {
    await Future<void>.delayed(_kNetworkDelay);
    if (_cart == null) {
      throw const CartNotFoundException();
    }

    if (quantity <= 0) {
      _cart?.items.removeWhere((i) => i.productId == productId);
    } else {
      final existingIndex = _cart?.items.indexWhere(
        (i) => i.productId == productId,
      );

      if (existingIndex != null && existingIndex >= 0) {
        _cart?.items[existingIndex] = CartItem(
          productId: productId,
          quantity: quantity,
        );
      } else {
        _cart?.items.add(CartItem(productId: productId, quantity: quantity));
      }
    }

    final cartItemsWithPrices = await _buildCartItemsWithPrices(
      _cart?.items ?? [],
    );
    return _cart = _cart!.copyWith(total: Total.calculate(cartItemsWithPrices));
  }

  Future<List<(CartItem, Price)>> _buildCartItemsWithPrices(
    List<CartItem> items,
  ) async {
    return items.map((i) {
      final product = MockData.findProductById(i.productId);
      if (product == null) {
        throw Exception('Product with id ${i.productId} not found');
      }
      return (i, product.price);
    }).toList();
  }
}

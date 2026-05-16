import 'package:my_store/shared/cart/domain/entities/cart.dart';
import 'package:my_store/shared/cart/domain/entities/total.dart';
import 'package:my_store/shared/cart/domain/exceptions/cart_exceptions.dart';
import 'package:my_store/shared/cart/domain/repositories/cart_repository.dart';
import 'package:my_store/shared/product/data/data_sources/mock_data.dart';
import 'package:my_store/shared/product/domain/entities/product.dart';

final class MockCartRepository implements CartRepository {
  MockCartRepository();

  static const Duration _kNetworkDelay = Duration(milliseconds: 250);

  Cart<CartItem>? _cart;

  @override
  Future<Cart<CartItem>> getOrCreateCart() async {
    await Future<void>.delayed(_kNetworkDelay);

    final items = <CartItem>[];
    final total = Total.fromCartItems(items);

    return _cart ??= Cart(
      id: 'mock-cart-id',
      ownerId: 'mock-user-id',
      createdAt: DateTime.now(),
      items: items,
      total: total,
    );
  }

  @override
  Future<Cart<CartItem>> updateItem(String productId, int quantity) async {
    await Future<void>.delayed(_kNetworkDelay);
    if (_cart == null) {
      throw const CartNotFoundException();
    }

    final newItems = List<CartItem>.from(_cart?.items ?? []);

    if (quantity <= 0) {
      newItems.removeWhere((i) => i.productId == productId);
    } else {
      final existingIndex = newItems.indexWhere(
        (i) => i.productId == productId,
      );

      final product = MockData.products.cast<Product?>().firstWhere(
        (p) => p?.id == productId,
        orElse: () => null,
      );
      if (product == null) {
        throw Exception('Product not found');
      }

      if (existingIndex < 0) {
        newItems.add(
          CartItem(
            productId: productId,
            unitPrice: product.price,
            quantity: quantity,
          ),
        );
      } else {
        newItems[existingIndex] = CartItem(
          productId: productId,
          unitPrice: product.price,
          quantity: quantity,
        );
      }
    }

    _cart = _cart?.copyWith(
      items: newItems,
      total: Total.fromCartItems(newItems),
    );

    return _cart ?? (throw const CartNotFoundException());
  }
}

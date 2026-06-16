import 'package:my_store/features/cart/domain/entities/cart.dart';
import 'package:my_store/features/cart/domain/entities/total.dart' show Total;
import 'package:my_store/features/cart/domain/repositories/cart_repository.dart';
import 'package:my_store/features/product/domain/repositories/product_repository.dart';

class UpdateCartItemUseCase {
  const UpdateCartItemUseCase({
    required this.cartRepository,
    required this.productRepository,
  });

  final CartRepository cartRepository;
  final ProductRepository productRepository;

  Future<Cart<HydratedCartItem>> execute({
    required String cartId,
    required String productId,
    required int quantity,
    required Total optimisticCartTotal,
  }) async {
    final updatedRawCart = await cartRepository.updateItem(
      cartId: cartId,
      productId: productId,
      quantity: quantity,
    );

    final fetchProducts = updatedRawCart.total != optimisticCartTotal
        ? productRepository.refreshProductsByIds
        : productRepository.getProductsByIds;

    final products = await fetchProducts(
      productIds: updatedRawCart.items.map((i) => i.productId).toList(),
    );

    final productMap = {for (final p in products) p.id: p};

    final hydratedItems = updatedRawCart.items.map((cartItem) {
      final product = productMap[cartItem.productId];
      if (product == null) {
        throw Exception('Product ${cartItem.productId} not found');
      }
      return HydratedCartItem(cartItem: cartItem, product: product);
    }).toList();

    return Cart<HydratedCartItem>(
      id: updatedRawCart.id,
      ownerId: updatedRawCart.ownerId,
      createdAt: updatedRawCart.createdAt,
      status: updatedRawCart.status,
      items: hydratedItems,
      total: updatedRawCart.total,
    );
  }
}

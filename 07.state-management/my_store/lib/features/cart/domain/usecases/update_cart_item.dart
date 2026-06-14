import 'package:my_store/core/dependency_injection/repository_providers.dart';
import 'package:my_store/features/cart/domain/entities/cart.dart';
import 'package:my_store/features/cart/domain/entities/total.dart' show Total;
import 'package:my_store/features/cart/domain/repositories/cart_repository.dart';
import 'package:my_store/features/product/domain/repositories/product_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_cart_item.g.dart';

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

    final shouldSkipCache = updatedRawCart.total != optimisticCartTotal;

    final products = await productRepository.getProductsByIds(
      productIds: updatedRawCart.items.map((i) => i.productId).toList(),
      skipCache: shouldSkipCache,
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

@riverpod
UpdateCartItemUseCase updateCartItemUseCase(Ref ref) {
  return UpdateCartItemUseCase(
    cartRepository: ref.watch(cartRepositoryProvider),
    productRepository: ref.watch(productRepositoryProvider),
  );
}

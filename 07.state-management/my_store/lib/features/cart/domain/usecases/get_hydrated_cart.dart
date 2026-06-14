import 'package:my_store/core/dependency_injection/repository_providers.dart';
import 'package:my_store/features/cart/domain/entities/cart.dart';
import 'package:my_store/features/cart/domain/repositories/cart_repository.dart';
import 'package:my_store/features/product/domain/repositories/product_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_hydrated_cart.g.dart';

class GetHydratedCartUseCase {
  const GetHydratedCartUseCase({
    required this.cartRepository,
    required this.productRepository,
  });

  final CartRepository cartRepository;
  final ProductRepository productRepository;

  Future<Cart<HydratedCartItem>> execute() async {
    final cart = await cartRepository.getOrCreateCart();

    final products = await productRepository.getProductsByIds(
      productIds: cart.items.map((i) => i.productId).toList(),
    );

    final productMap = {for (final p in products) p.id: p};

    final hydratedItems = cart.items.map((cartItem) {
      final product = productMap[cartItem.productId];
      if (product == null) {
        throw Exception('Product ${cartItem.productId} not found');
      }
      return HydratedCartItem(cartItem: cartItem, product: product);
    }).toList();

    return Cart<HydratedCartItem>(
      id: cart.id,
      ownerId: cart.ownerId,
      createdAt: cart.createdAt,
      status: cart.status,
      items: hydratedItems,
      total: cart.total,
    );
  }
}

@riverpod
GetHydratedCartUseCase getHydratedCartUseCase(Ref ref) {
  return GetHydratedCartUseCase(
    cartRepository: ref.watch(cartRepositoryProvider),
    productRepository: ref.watch(productRepositoryProvider),
  );
}

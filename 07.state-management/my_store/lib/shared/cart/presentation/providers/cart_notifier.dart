import 'package:my_store/shared/cart/data/repositories/cart_repository_provider.dart';
import 'package:my_store/shared/cart/domain/entities/cart.dart';
import 'package:my_store/shared/cart/domain/entities/total.dart';
import 'package:my_store/shared/product/data/repositories/product_repository_provider.dart';
import 'package:my_store/shared/product/presentation/providers/product_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_notifier.g.dart';

@riverpod
class _CartState extends _$CartState {
  @override
  Future<Cart<CartItem>> build() async {
    final repository = ref.watch(cartRepositoryProvider);
    return repository.getOrCreateCart();
  }

  Future<void> addItem(String productId) async {
    final existing = state.value?.items.where((item) {
      return item.productId == productId;
    }).firstOrNull;

    return updateQuantity(productId, (existing?.quantity ?? 0) + 1);
  }

  Future<void> removeItem(String productId) async {
    final existing = state.value?.items.where((item) {
      return item.productId == productId;
    }).firstOrNull;

    if (existing == null) return;

    return updateQuantity(productId, 0);
  }

  Future<void> updateQuantity(String productId, int quantity) async {
    final localCart = state.value;
    if (localCart == null) return;

    final updatedItems = await _updateItems(
      currentItems: localCart.items,
      productId: productId,
      quantity: quantity,
    );

    state = AsyncData(
      localCart.copyWith(
        items: updatedItems,
        total: Total.fromCartItems(updatedItems),
      ),
    );

    final cartRepository = ref.read(cartRepositoryProvider);
    final updatedCart = await cartRepository.updateItem(productId, quantity);

    state = AsyncData(updatedCart);

    if (localCart.total != updatedCart.total) {
      final productsRepository = ref.read(productRepositoryProvider);

      await productsRepository.getProductsByIds(
        productIds: updatedCart.items.map((i) => i.productId).toList(),
        skipCache: true,
      );

      for (final item in updatedCart.items) {
        ref.invalidate(productProvider(item.productId));
      }
    }
  }

  Future<List<CartItem>> _updateItems({
    required List<CartItem> currentItems,
    required String productId,
    required int quantity,
  }) async {
    final updatedItems = List<CartItem>.from(currentItems);
    final existingItemIndex = updatedItems.indexWhere(
      (item) => item.productId == productId,
    );

    if (existingItemIndex != -1) {
      if (quantity <= 0) {
        updatedItems.removeAt(existingItemIndex);
      } else {
        final updatedItem = updatedItems[existingItemIndex].copyWith(
          quantity: quantity,
        );
        updatedItems[existingItemIndex] = updatedItem;
      }
    } else if (quantity > 0) {
      final productsRepository = ref.read(productRepositoryProvider);
      final products = await productsRepository.getProductsByIds(
        productIds: [productId],
      );

      if (products.isEmpty) throw Exception('Product not found');

      updatedItems.add(
        CartItem(
          productId: productId,
          unitPrice: products.first.price,
          quantity: quantity,
        ),
      );
    }

    return updatedItems;
  }
}

@riverpod
class CartNotifier extends _$CartNotifier {
  @override
  Future<Cart<HydratedCartItem>> build() async {
    final productRepository = ref.watch(productRepositoryProvider);
    final cartFuture = ref.watch(_cartStateProvider.future);

    final cart = await cartFuture;

    final products = await productRepository.getProductsByIds(
      productIds: cart.items.map((i) => i.productId).toList(),
    );

    final productMap = {for (var p in products) p.id: p};

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
      items: hydratedItems,
      total: cart.total,
    );
  }

  Future<void> addItem(String productId) {
    return ref.read(_cartStateProvider.notifier).addItem(productId);
  }

  Future<void> removeItem(String productId) {
    return ref.read(_cartStateProvider.notifier).removeItem(productId);
  }

  Future<void> updateQuantity(String productId, int quantity) {
    return ref
        .read(_cartStateProvider.notifier)
        .updateQuantity(productId, quantity);
  }
}

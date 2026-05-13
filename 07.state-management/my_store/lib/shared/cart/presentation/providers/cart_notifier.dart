import 'package:my_store/shared/cart/data/repositories/cart_repository_provider.dart';
import 'package:my_store/shared/cart/domain/entities/cart.dart';
import 'package:my_store/shared/cart/domain/entities/total.dart';
import 'package:my_store/shared/product/data/repositories/product_repository_provider.dart';
import 'package:my_store/shared/product/domain/entities/price.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_notifier.g.dart';

@riverpod
class CartNotifier extends _$CartNotifier {
  @override
  Future<Cart> build() async {
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
    final currentCart = state.value;
    if (currentCart == null) return;

    final updatedItems = _updateItems(
      currentItems: currentCart.items,
      productId: productId,
      quantity: quantity,
    );

    final productRepository = ref.read(productRepositoryProvider);
    final products = await productRepository.getProductsByIds(
      productIds: updatedItems.map((item) => item.productId).toList(),
      skipCache: true,
    );

    final priceById = {for (final p in products) p.id: p.price};

    List<(CartItem, Price)> items = updatedItems.map((item) {
      final price = priceById[item.productId];
      if (price == null) {
        throw Exception('Product not found');
      }
      return (item, price);
    }).toList();

    state = AsyncData(
      currentCart.copyWith(items: updatedItems, total: Total.calculate(items)),
    );

    state = await AsyncValue.guard(
      () => ref.read(cartRepositoryProvider).updateItem(productId, quantity),
    );
  }

  List<CartItem> _updateItems({
    required List<CartItem> currentItems,
    required String productId,
    required int quantity,
  }) {
    final updatedItems = List<CartItem>.from(currentItems);
    final existingItemIndex = updatedItems.indexWhere(
      (item) => item.productId == productId,
    );

    if (existingItemIndex != -1) {
      if (quantity <= 0) {
        updatedItems.removeAt(existingItemIndex);
      } else {
        updatedItems[existingItemIndex] = CartItem(
          productId: productId,
          quantity: quantity,
        );
      }
    } else if (quantity > 0) {
      updatedItems.add(CartItem(productId: productId, quantity: quantity));
    }

    return updatedItems;
  }
}

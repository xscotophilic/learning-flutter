import 'package:my_store/shared/data/mock_products.dart';
import 'package:my_store/shared/product/domain/entities/product.dart';
import 'package:my_store/shared/product/domain/repositories/product_repository.dart';

final class MockProductRepository implements ProductRepository {
  static const Duration _kNetworkDelay = Duration(milliseconds: 1000);

  final Map<String, Product> _allProductsCache = {};

  @override
  Future<String> getHeroProductId() async {
    await Future<void>.delayed(_kNetworkDelay);
    return MockProductsData.heroProductId;
  }

  @override
  Future<List<String>> getFeaturedProductIds() async {
    await Future<void>.delayed(_kNetworkDelay);
    return MockProductsData.products.map((p) => p.id).toList();
  }

  @override
  Future<List<Product>> getProductsByIds({
    required List<String> productIds,
    bool skipCache = false,
  }) async {
    final List<String> missingIds;

    if (skipCache) {
      missingIds = productIds;
    } else {
      missingIds = productIds.where((id) {
        return !_allProductsCache.containsKey(id);
      }).toList();
    }

    if (missingIds.isNotEmpty) {
      await Future<void>.delayed(_kNetworkDelay);
      final fetchedProducts = MockProductsData.products.where((product) {
        return missingIds.contains(product.id);
      }).toList();

      _updateCache(fetchedProducts);
    }

    return productIds
        .map((id) => _allProductsCache[id])
        .whereType<Product>()
        .toList();
  }

  void _updateCache(List<Product> products) {
    for (final product in products) {
      _allProductsCache[product.id] = product;
    }
  }
}

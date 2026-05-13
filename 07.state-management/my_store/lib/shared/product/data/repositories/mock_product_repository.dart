import 'package:my_store/shared/product/data/data_sources/mock_data.dart';
import 'package:my_store/shared/product/domain/entities/product.dart';
import 'package:my_store/shared/product/domain/repositories/product_repository.dart';

final class MockProductRepository implements ProductRepository {
  static const Duration _kNetworkDelay = Duration(milliseconds: 1000);

  final Map<String, Product> _allProductsCache = {};

  @override
  Future<Product> getHeroProduct() async {
    await Future<void>.delayed(_kNetworkDelay);
    final product = MockData.heroProduct;
    _updateCache([product]);
    return product;
  }

  @override
  Future<List<Product>> getFeaturedProducts() async {
    await Future<void>.delayed(_kNetworkDelay);
    final products = MockData.products;
    _updateCache(products);
    return products;
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
      final fetchedProducts = MockData.products.where((product) {
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

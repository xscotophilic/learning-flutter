import 'package:my_store/data/models/product.dart';
import 'package:my_store/data/store/mock_data.dart';
import 'package:my_store/features/home/domain/repositories/product_repository.dart';

final class MockProductRepository implements ProductRepository {
  static const Duration _kNetworkDelay = Duration(milliseconds: 1000);

  final Map<String, Product> _allProductsCache = {};

  @override
  Future<Product> getHeroProduct() async {
    await Future<void>.delayed(_kNetworkDelay);
    return MockData.heroProduct;
  }

  @override
  Future<List<Product>> getFeaturedProducts() async {
    await Future<void>.delayed(_kNetworkDelay);
    return MockData.products;
  }

  @override
  Future<List<Product>> getProductsByIds({
    required List<String> productIds,
  }) async {
    final missingIds = productIds.where((id) {
      return !_allProductsCache.containsKey(id);
    }).toList();

    if (missingIds.isNotEmpty) {
      await Future<void>.delayed(_kNetworkDelay);
      final fetchedProducts = MockData.products.where((product) {
        return missingIds.contains(product.id);
      }).toList();

      for (final product in fetchedProducts) {
        _allProductsCache[product.id] = product;
      }
    }

    return productIds
        .map((id) => _allProductsCache[id])
        .whereType<Product>()
        .toList();
  }
}

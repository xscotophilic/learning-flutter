import 'package:my_store/features/product/data/models/product_model.dart';
import 'package:my_store/features/product/domain/entities/product.dart';
import 'package:my_store/features/product/domain/repositories/product_repository.dart';
import 'package:my_store/mock_server/mock_server.dart';

final class MockProductRepository implements ProductRepository {
  final Map<String, Product> _allProductsCache = {};

  @override
  Future<String> getHeroProductId() async {
    return MockServer.getHeroProductId();
  }

  @override
  Future<List<String>> getFeaturedProductIds() async {
    return MockServer.getFeaturedProductIds();
  }

  Future<void> _fetchAndCacheProducts(List<String> productIds) async {
    final rawProducts = await MockServer.getProductsByIds(productIds);
    final response = ProductsPayloadModel.fromJson(rawProducts);
    for (final product in response.toDomain()) {
      _allProductsCache[product.id] = product;
    }
  }

  @override
  Future<List<Product>> getProductsByIds({
    required List<String> productIds,
  }) async {
    final missingIds = productIds.where((id) {
      return !_allProductsCache.containsKey(id);
    }).toList();

    if (missingIds.isNotEmpty) {
      await _fetchAndCacheProducts(missingIds);
    }

    return productIds
        .map((id) => _allProductsCache[id])
        .whereType<Product>()
        .toList();
  }

  @override
  Future<List<Product>> refreshProductsByIds({
    required List<String> productIds,
  }) async {
    await _fetchAndCacheProducts(productIds);

    return productIds
        .map((id) => _allProductsCache[id])
        .whereType<Product>()
        .toList();
  }
}

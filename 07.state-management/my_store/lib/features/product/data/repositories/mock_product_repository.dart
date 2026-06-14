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
      final rawProducts = await MockServer.getProductsByIds(missingIds);
      final response = ProductsPayloadModel.fromJson(rawProducts);

      _updateCache(response.toDomain());
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

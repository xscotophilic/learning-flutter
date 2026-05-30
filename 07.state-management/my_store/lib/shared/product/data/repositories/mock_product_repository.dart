import 'package:my_store/shared/app/data_sources/mock_products.dart';
import 'package:my_store/shared/product/domain/entities/product.dart';
import 'package:my_store/shared/product/domain/entities/product_payload.dart';
import 'package:my_store/shared/product/domain/repositories/product_repository.dart';

final class MockProductRepository implements ProductRepository {
  final Map<String, Product> _allProductsCache = {};

  @override
  Future<String> getHeroProductId() async {
    return MockProductsData.getHeroProductId();
  }

  @override
  Future<List<String>> getFeaturedProductIds() async {
    return MockProductsData.getFeaturedProductIds();
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
      final rawProducts = await MockProductsData.getProductsByIds(missingIds);
      final response = ProductsPayload.fromJson(rawProducts);

      _updateCache(response.products);
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

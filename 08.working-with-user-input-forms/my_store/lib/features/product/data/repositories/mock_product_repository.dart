import 'package:my_store/features/product/data/models/product_model.dart';
import 'package:my_store/features/product/domain/entities/product.dart';
import 'package:my_store/features/product/domain/repositories/product_repository.dart';
import 'package:my_store/mock_server/mock_server.dart';

final class MockProductRepository implements ProductRepository {
  final Map<String, Product> _allProductsCache = {};

  List<String> _cacheResponseAndExtractIds(Map<String, dynamic> rawProducts) {
    final response = ProductsPayloadModel.fromJson(rawProducts);
    for (final product in response.toDomain()) {
      _allProductsCache[product.id] = product;
    }
    return response.products.map((e) => e.id).toList();
  }

  Future<void> _fetchAndCacheProducts(List<String> productIds) async {
    final rawProducts = await MockServer.getProductsByIds(productIds);
    final response = ProductsPayloadModel.fromJson(rawProducts);
    for (final product in response.toDomain()) {
      _allProductsCache[product.id] = product;
    }
  }

  @override
  Future<String> getHeroProductId() async {
    return MockServer.getHeroProductId();
  }

  @override
  Future<List<String>> getFeaturedProductIds() async {
    final products = await MockServer.getFeaturedProducts();
    return _cacheResponseAndExtractIds(products);
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

  @override
  Future<List<String>> getMyProducts({required String userId}) async {
    final products = await MockServer.getMyProducts(userId: userId);
    return _cacheResponseAndExtractIds(products);
  }

  @override
  Future<void> deleteProduct({required String id}) async {
    await MockServer.deleteProduct(id: id);
    _allProductsCache.remove(id);
  }
}

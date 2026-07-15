import 'package:my_store/features/product/data/models/product_model.dart';
import 'package:my_store/features/product/domain/entities/product.dart';
import 'package:my_store/features/product/domain/repositories/product_repository.dart';
import 'package:my_store/mock_server/mock_server.dart';

final class MockProductRepository implements ProductRepository {
  final Map<String, Product> _allProductsCache = {};

  List<Product> _cacheProductsFromResponse(Map<String, dynamic> rawProducts) {
    final response = ProductsPayloadModel.fromJson(rawProducts);
    final products = response.toDomain();

    for (final product in products) {
      _allProductsCache[product.id] = product;
    }

    return products;
  }

  Future<List<Product>> _fetchAndCacheProducts(List<String> productIds) async {
    final rawProducts = await MockServer.getProductsByIds(productIds);
    return _cacheProductsFromResponse(rawProducts);
  }

  @override
  Future<Product> getHeroProduct() async {
    final rawProduct = await MockServer.getHeroProduct();
    final product = ProductModel.fromJson(rawProduct).toDomain();
    _allProductsCache[product.id] = product;
    return product;
  }

  @override
  Future<List<Product>> getFeaturedProducts() async {
    final products = await MockServer.getFeaturedProducts();
    return _cacheProductsFromResponse(products);
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
    return await _fetchAndCacheProducts(productIds);
  }
}

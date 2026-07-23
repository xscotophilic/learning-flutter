import 'package:my_store/core/network/api_client.dart';
import 'package:my_store/features/product/data/models/product_model.dart';
import 'package:my_store/features/product/domain/entities/product.dart';
import 'package:my_store/features/product/domain/repositories/product_repository.dart';

final class ApiProductRepository implements ProductRepository {
  ApiProductRepository(this.apiClient);

  final ApiClient apiClient;
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
    final json = await apiClient.post(
      '/products/bulk',
      body: {'ids': productIds},
    );
    return _cacheProductsFromResponse(json['data'] as Map<String, dynamic>);
  }

  @override
  Future<Product> getHeroProduct() async {
    final json = await apiClient.get('/products/hero');
    final product = ProductModel.fromJson(
      json['data'] as Map<String, dynamic>,
    ).toDomain();
    _allProductsCache[product.id] = product;
    return product;
  }

  @override
  Future<List<Product>> getFeaturedProducts() async {
    final json = await apiClient.get('/products/featured');
    return _cacheProductsFromResponse(json['data'] as Map<String, dynamic>);
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

  @override
  Future<List<Product>> getMyProducts() async {
    final json = await apiClient.get('/products/mine');
    return _cacheProductsFromResponse(json['data'] as Map<String, dynamic>);
  }

  @override
  Future<Product> createProduct(Product productRequest) async {
    final productModel = ProductModel.fromDomain(productRequest);
    final productJson = productModel.toJson();

    final json = await apiClient.post('/products', body: productJson);

    final product = ProductModel.fromJson(
      json['data'] as Map<String, dynamic>,
    ).toDomain();
    _allProductsCache[product.id] = product;
    return product;
  }

  @override
  Future<Product> updateProduct(Product productRequest) async {
    final productModel = ProductModel.fromDomain(productRequest);
    final productJson = productModel.toJson();

    final json = await apiClient.put(
      '/products/${productRequest.id}',
      body: productJson,
    );

    final product = ProductModel.fromJson(
      json['data'] as Map<String, dynamic>,
    ).toDomain();
    _allProductsCache[product.id] = product;
    return product;
  }

  @override
  Future<void> deleteProduct({required String id}) async {
    await apiClient.delete('/products/$id');
    _allProductsCache.remove(id);
  }
}

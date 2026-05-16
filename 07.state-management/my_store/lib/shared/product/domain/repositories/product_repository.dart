import 'package:my_store/shared/product/domain/entities/product.dart';

abstract interface class ProductRepository {
  Future<String> getHeroProductId();

  Future<List<String>> getFeaturedProductIds();

  Future<List<Product>> getProductsByIds({
    required List<String> productIds,
    bool skipCache = false,
  });
}

import 'package:my_store/features/product/domain/entities/product.dart';

abstract interface class ProductRepository {
  Future<String> getHeroProductId();

  Future<List<String>> getFeaturedProductIds();

  Future<List<Product>> getProductsByIds({required List<String> productIds});

  Future<List<Product>> refreshProductsByIds({
    required List<String> productIds,
  });
}

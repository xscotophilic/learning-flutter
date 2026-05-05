import 'package:my_store/shared/product/domain/entities/product.dart';

abstract interface class ProductRepository {
  Future<Product> getHeroProduct();

  Future<List<Product>> getFeaturedProducts();

  Future<List<Product>> getProductsByIds({required List<String> productIds});
}

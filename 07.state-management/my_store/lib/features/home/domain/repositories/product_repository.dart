import 'package:my_store/data/models/product.dart';

abstract interface class ProductRepository {
  Future<Product> getHeroProduct();

  Future<List<Product>> getFeaturedProducts();

  Future<List<Product>> getProductsByIds({required List<String> productIds});
}

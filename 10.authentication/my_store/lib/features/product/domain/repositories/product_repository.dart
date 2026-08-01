import 'package:my_store/features/product/domain/entities/product.dart';

abstract interface class ProductRepository {
  Future<Product> getHeroProduct();

  Future<List<Product>> getFeaturedProducts();

  Future<List<Product>> getProductsByIds({required List<String> productIds});

  Future<List<Product>> refreshProductsByIds({
    required List<String> productIds,
  });

  Future<List<Product>> getMyProducts();

  Future<Product> createProduct(Product product);

  Future<Product> updateProduct(Product product);

  Future<void> deleteProduct({required String id});
}

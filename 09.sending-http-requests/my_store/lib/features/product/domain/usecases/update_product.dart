import 'package:my_store/features/product/domain/entities/product.dart';
import 'package:my_store/features/product/domain/repositories/product_repository.dart';

class UpdateProductUseCase {
  const UpdateProductUseCase({required this.productRepository});

  final ProductRepository productRepository;

  Future<Product> execute(Product product) {
    return productRepository.updateProduct(product);
  }
}

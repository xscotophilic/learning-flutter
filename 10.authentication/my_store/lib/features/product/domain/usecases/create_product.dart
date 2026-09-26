import 'package:my_store/features/product/domain/entities/product.dart';
import 'package:my_store/features/product/domain/repositories/product_repository.dart';

class CreateProductUseCase {
  const CreateProductUseCase({required this.productRepository});

  final ProductRepository productRepository;

  Future<Product> execute(Product product) {
    return productRepository.createProduct(product);
  }
}

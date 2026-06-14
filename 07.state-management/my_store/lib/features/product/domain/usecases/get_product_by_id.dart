import 'package:my_store/features/product/domain/entities/product.dart';
import 'package:my_store/features/product/domain/repositories/product_repository.dart';

class GetProductByIdUseCase {
  const GetProductByIdUseCase({required this.productRepository});

  final ProductRepository productRepository;

  Future<Product?> execute(String id) async {
    final products = await productRepository.getProductsByIds(productIds: [id]);
    return products.firstOrNull;
  }
}

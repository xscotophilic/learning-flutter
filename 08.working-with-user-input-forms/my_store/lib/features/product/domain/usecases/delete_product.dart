import 'package:my_store/features/product/domain/repositories/product_repository.dart';

class DeleteProductUseCase {
  const DeleteProductUseCase({required this.productRepository});

  final ProductRepository productRepository;

  Future<void> execute({required String id}) {
    return productRepository.deleteProduct(id: id);
  }
}

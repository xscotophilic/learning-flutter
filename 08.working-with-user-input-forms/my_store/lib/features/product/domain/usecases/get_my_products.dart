import 'package:my_store/features/product/domain/repositories/product_repository.dart';

class GetMyProductsUseCase {
  const GetMyProductsUseCase({required this.productRepository});

  final ProductRepository productRepository;

  Future<List<String>> execute({required String userId}) {
    return productRepository.getMyProducts(userId: userId);
  }
}

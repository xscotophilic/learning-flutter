import 'package:my_store/core/dependency_injection/repository_providers.dart';
import 'package:my_store/features/product/domain/entities/product.dart';
import 'package:my_store/features/product/domain/repositories/product_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_product_by_id.g.dart';

class GetProductByIdUseCase {
  const GetProductByIdUseCase({
    required this.productRepository,
  });

  final ProductRepository productRepository;

  Future<Product?> execute(String id) async {
    final products = await productRepository.getProductsByIds(productIds: [id]);
    return products.firstOrNull;
  }
}

@riverpod
GetProductByIdUseCase getProductByIdUseCase(Ref ref) {
  return GetProductByIdUseCase(
    productRepository: ref.watch(productRepositoryProvider),
  );
}

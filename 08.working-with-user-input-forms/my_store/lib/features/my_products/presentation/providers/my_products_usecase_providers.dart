import 'package:my_store/core/dependency_injection/repository_providers.dart';
import 'package:my_store/features/product/domain/usecases/delete_product.dart';
import 'package:my_store/features/product/domain/usecases/get_my_products.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_products_usecase_providers.g.dart';

@riverpod
GetMyProductsUseCase getMyProductsUseCase(Ref ref) {
  return GetMyProductsUseCase(
    productRepository: ref.watch(productRepositoryProvider),
  );
}

@riverpod
DeleteProductUseCase deleteProductUseCase(Ref ref) {
  return DeleteProductUseCase(
    productRepository: ref.watch(productRepositoryProvider),
  );
}

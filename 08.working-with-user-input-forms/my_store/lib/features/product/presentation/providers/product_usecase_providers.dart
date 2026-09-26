import 'package:my_store/core/dependency_injection/repository_providers.dart';
import 'package:my_store/features/product/domain/usecases/get_product_by_id.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_usecase_providers.g.dart';

@riverpod
GetProductByIdUseCase getProductByIdUseCase(Ref ref) {
  return GetProductByIdUseCase(
    productRepository: ref.watch(productRepositoryProvider),
  );
}

import 'package:my_store/core/dependency_injection/repository_providers.dart';
import 'package:my_store/features/home/domain/usecases/get_home_page_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_usecase_providers.g.dart';

@riverpod
GetHomePageDataUseCase getHomePageDataUseCase(Ref ref) {
  return GetHomePageDataUseCase(
    productRepository: ref.watch(productRepositoryProvider),
  );
}

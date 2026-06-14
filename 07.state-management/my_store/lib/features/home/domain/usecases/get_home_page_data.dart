import 'package:my_store/core/dependency_injection/repository_providers.dart';
import 'package:my_store/features/home/domain/entities/home_page_data.dart';
import 'package:my_store/features/product/domain/repositories/product_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_home_page_data.g.dart';

class GetHomePageDataUseCase {
  const GetHomePageDataUseCase({required this.productRepository});

  final ProductRepository productRepository;

  Future<HomePageData> execute() async {
    final (heroProductId, featuredProductIds) = await (
      productRepository.getHeroProductId(),
      productRepository.getFeaturedProductIds(),
    ).wait;

    return HomePageData(
      heroProductId: heroProductId,
      featuredProductIds: featuredProductIds,
    );
  }
}

@riverpod
GetHomePageDataUseCase getHomePageDataUseCase(Ref ref) {
  return GetHomePageDataUseCase(
    productRepository: ref.watch(productRepositoryProvider),
  );
}

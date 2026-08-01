import 'package:my_store/features/home/domain/entities/home_page_data.dart';
import 'package:my_store/features/product/domain/repositories/product_repository.dart';

class GetHomePageDataUseCase {
  const GetHomePageDataUseCase({required this.productRepository});

  final ProductRepository productRepository;

  Future<HomePageData> execute() async {
    final (heroProduct, featuredProducts) = await (
      productRepository.getHeroProduct(),
      productRepository.getFeaturedProducts(),
    ).wait;

    return HomePageData(
      heroProductId: heroProduct.id,
      featuredProductIds: featuredProducts.map((e) => e.id).toList(),
    );
  }
}

import 'package:my_store/features/home/domain/entities/home_page_data.dart';
import 'package:my_store/shared/product/data/repositories/product_repository_provider.dart';
import 'package:my_store/shared/product/domain/entities/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_page_data_notifier.g.dart';

@riverpod
class HomePageDataNotifier extends _$HomePageDataNotifier {
  @override
  Future<HomePageData> build() async {
    final repository = ref.read(productRepositoryProvider);

    final results = await Future.wait([
      repository.getHeroProduct(),
      repository.getFeaturedProducts(),
    ]);

    return HomePageData(
      heroProduct: results[0] as Product,
      featuredProducts: results[1] as List<Product>,
    );
  }
}

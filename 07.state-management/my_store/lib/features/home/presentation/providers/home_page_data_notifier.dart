import 'package:my_store/data/models/product.dart';
import 'package:my_store/features/home/data/providers/product_repository_provider.dart';
import 'package:my_store/features/home/domain/models/home_data.dart';
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

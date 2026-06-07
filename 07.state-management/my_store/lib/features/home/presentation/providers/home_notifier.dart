import 'package:my_store/core/dependency_injection/repository_providers.dart';
import 'package:my_store/features/home/domain/entities/home_page_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_notifier.g.dart';

@riverpod
class HomeNotifier extends _$HomeNotifier {
  @override
  Future<HomePageData> build() async {
    final repository = ref.watch(productRepositoryProvider);

    final (heroProductId, featuredProductIds) = await (
      repository.getHeroProductId(),
      repository.getFeaturedProductIds(),
    ).wait;

    return HomePageData(
      heroProductId: heroProductId,
      featuredProductIds: featuredProductIds,
    );
  }
}

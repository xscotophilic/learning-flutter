import 'package:my_store/features/home/domain/entities/home_page_data.dart';
import 'package:my_store/features/home/presentation/providers/home_usecase_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_notifier.g.dart';

@riverpod
class HomeNotifier extends _$HomeNotifier {
  @override
  Future<HomePageData> build() async {
    final getHomePageData = ref.watch(getHomePageDataUseCaseProvider);
    return getHomePageData.execute();
  }
}

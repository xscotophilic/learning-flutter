import 'package:my_store/shared/app_info/data/repositories/app_info_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'splash_page_data_notifier.g.dart';

@riverpod
class SplashPageDataNotifier extends _$SplashPageDataNotifier {
  @override
  FutureOr<void> build() async {
    final appInfoRepository = ref.read(appInfoRepositoryProvider);
    await appInfoRepository.readAppVersion();
    await appInfoRepository.readAppBuildNumber();
  }
}

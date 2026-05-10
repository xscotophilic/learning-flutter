import 'package:my_store/features/splash/presentation/providers/splash_state.dart';
import 'package:my_store/shared/app_info/data/repositories/app_info_repository_provider.dart';
import 'package:my_store/shared/remote_config/data/repositories/remote_config_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'splash_page_data_notifier.g.dart';

@riverpod
class SplashPageDataNotifier extends _$SplashPageDataNotifier {
  @override
  Future<SplashState> build() async {
    final appInfoRepository = ref.watch(appInfoRepositoryProvider);
    final remoteConfigRepository = ref.watch(remoteConfigRepositoryProvider);

    final (currentBuildNumber, _) = await (
      appInfoRepository.readAppBuildNumber(),
      remoteConfigRepository.fetchRemoteConfig(),
    ).wait;

    final config = remoteConfigRepository.getRemoteConfig();

    if (config.maintenanceConfig.isInMaintenanceMode) {
      return UnderMaintenance(
        message: config.maintenanceConfig.message,
        details: config.maintenanceConfig.details,
      );
    }

    if (currentBuildNumber < config.minSupportedBuildNumber) {
      return const ForceUpdate(
        message: 'New Version Available',
        details:
            'A newer version of the app is required to continue. Please update to access the latest features, improvements, and fixes.',
      );
    }

    return const Success();
  }
}

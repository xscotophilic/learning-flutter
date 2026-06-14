import 'package:my_store/core/dependency_injection/repository_providers.dart';
import 'package:my_store/features/splash/domain/entities/splash_state.dart';
import 'package:my_store/shared/app_info/domain/repositories/app_info_repository.dart';
import 'package:my_store/shared/remote_config/domain/repositories/remote_config_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'check_app_status.g.dart';

class CheckAppStatusUseCase {
  const CheckAppStatusUseCase({
    required this.appInfoRepository,
    required this.remoteConfigRepository,
  });

  final AppInfoRepository appInfoRepository;
  final RemoteConfigRepository remoteConfigRepository;

  Future<SplashState> execute() async {
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

@riverpod
CheckAppStatusUseCase checkAppStatusUseCase(Ref ref) {
  return CheckAppStatusUseCase(
    appInfoRepository: ref.watch(appInfoRepositoryProvider),
    remoteConfigRepository: ref.watch(remoteConfigRepositoryProvider),
  );
}

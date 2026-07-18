import 'package:my_store/shared/remote_config/domain/entities/maintenance_config.dart';

final class RemoteConfig {
  const RemoteConfig({
    required this.maintenanceConfig,
    required this.minSupportedBuildNumber,
  });

  factory RemoteConfig.empty() => RemoteConfig(
    maintenanceConfig: MaintenanceConfig.empty(),
    minSupportedBuildNumber: 0,
  );

  final MaintenanceConfig maintenanceConfig;
  final int minSupportedBuildNumber;
}

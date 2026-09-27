import 'package:my_store/shared/remote_config/domain/entities/maintenance_config.dart';
import 'package:my_store/shared/remote_config/domain/entities/remote_config.dart';
import 'package:my_store/shared/remote_config/domain/repositories/remote_config_repository.dart';

final class MockRemoteConfigRepository implements RemoteConfigRepository {
  RemoteConfig? _config;

  @override
  Future<void> fetchRemoteConfig() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    _config = const RemoteConfig(
      maintenanceConfig: MaintenanceConfig(
        isInMaintenanceMode: false,
        message: 'Service Temporarily Unavailable',
        details:
            'We\'re currently undergoing some scheduled maintenance to improve your experience. The service will be back online shortly. Thank you for your patience.',
      ),
      minSupportedBuildNumber: 1,
    );
  }

  @override
  RemoteConfig getRemoteConfig() {
    if (_config == null) {
      throw Exception('Config not fetched yet.');
    }
    return _config!;
  }
}

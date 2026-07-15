import 'package:my_store/shared/remote_config/domain/entities/remote_config.dart';

abstract interface class RemoteConfigRepository {
  Future<void> fetchRemoteConfig();

  RemoteConfig getRemoteConfig();
}

import 'package:my_store/shared/remote_config/data/repositories/mock_remote_config_repository.dart';
import 'package:my_store/shared/remote_config/domain/repositories/remote_config_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remote_config_repository_provider.g.dart';

@Riverpod(keepAlive: true)
RemoteConfigRepository remoteConfigRepository(Ref ref) {
  return MockRemoteConfigRepository();
}

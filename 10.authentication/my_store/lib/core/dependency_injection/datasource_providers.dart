import 'package:my_store/core/dependency_injection/network_providers.dart';
import 'package:my_store/core/dependency_injection/service_providers.dart';
import 'package:my_store/core/dependency_injection/storage_providers.dart';
import 'package:my_store/features/auth/data/local/auth_local_data_source.dart';
import 'package:my_store/features/auth/data/local/auth_remote_data_source.dart';
import 'package:my_store/features/auth/data/local/google_auth_data_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'datasource_providers.g.dart';

@Riverpod(keepAlive: true)
GoogleAuthDataSource googleAuthDataSource(Ref ref) {
  return GoogleAuthDataSource(ref.watch(googleSignInProvider));
}

@Riverpod(keepAlive: true)
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  return AuthRemoteDataSource(ref.watch(apiClientProvider));
}

@Riverpod(keepAlive: true)
AuthLocalDataSource authLocalDataSource(Ref ref) {
  return AuthLocalDataSource(ref.watch(secureLocalStorageProvider));
}

import 'package:my_store/core/dependency_injection/service_providers.dart';
import 'package:my_store/core/network/api_client.dart';
import 'package:my_store/core/network/chained_client.dart';
import 'package:my_store/core/network/interceptors/auth_interceptor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'network_providers.g.dart';

@Riverpod(keepAlive: true)
class AuthToken extends _$AuthToken {
  @override
  String? build() => null;

  void setToken(String? token) {
    state = token;
  }
}

@Riverpod(keepAlive: true)
AuthInterceptor authInterceptor(Ref ref) {
  return AuthInterceptor(
    tokenProvider: () => ref.read(authTokenProvider),
    onUnauthorized: () {
      ref.read(authTokenProvider.notifier).setToken(null);
    },
  );
}

@Riverpod(keepAlive: true)
ApiClient apiClient(Ref ref) {
  final httpClient = ChainedClient(
    ref.watch(httpClientProvider),
    interceptors: [ref.watch(authInterceptorProvider)],
  );

  return ApiClient(
    httpClient: httpClient,
    baseUrl:
        'https://victorious-determination-production-344e.up.railway.app/api/v2',
  );
}

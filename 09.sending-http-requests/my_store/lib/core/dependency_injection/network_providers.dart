import 'package:http/http.dart' as http;
import 'package:my_store/core/network/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'network_providers.g.dart';

@Riverpod(keepAlive: true)
http.Client httpClient(Ref ref) {
  return http.Client();
}

@Riverpod(keepAlive: true)
ApiClient apiClient(Ref ref) {
  return ApiClient(
    client: ref.watch(httpClientProvider),
    baseUrl: 'http://192.168.1.4:3000/api/v1',
  );
}

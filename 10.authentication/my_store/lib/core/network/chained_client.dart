import 'package:http/http.dart' as http;
import 'package:my_store/core/network/interceptors/http_interceptor.dart';

class ChainedClient extends http.BaseClient {
  ChainedClient(this._inner, {this.interceptors = const []});

  final http.Client _inner;
  final List<HttpInterceptor> interceptors;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    for (final i in interceptors) {
      await i.onRequest(request);
    }

    final response = await _inner.send(request);

    for (final i in interceptors) {
      await i.onResponse(request, response);
    }

    return response;
  }
}

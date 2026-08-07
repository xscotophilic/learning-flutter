import 'package:http/http.dart' as http;

abstract interface class HttpInterceptor {
  Future<void> onRequest(http.BaseRequest request);

  Future<void> onResponse(
    http.BaseRequest request,
    http.StreamedResponse response,
  );
}

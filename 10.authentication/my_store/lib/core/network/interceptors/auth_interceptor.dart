import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:my_store/core/network/interceptors/http_interceptor.dart';

class AuthInterceptor implements HttpInterceptor {
  AuthInterceptor({required this.tokenProvider, this.onUnauthorized});

  final String? Function() tokenProvider;
  final void Function()? onUnauthorized;

  @override
  Future<void> onRequest(http.BaseRequest request) async {
    final token = tokenProvider();
    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }
  }

  @override
  Future<void> onResponse(
    http.BaseRequest request,
    http.StreamedResponse response,
  ) async {
    if (response.statusCode == HttpStatus.unauthorized) {
      onUnauthorized?.call();
    }
  }
}

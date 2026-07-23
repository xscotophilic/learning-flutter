import 'dart:async' show TimeoutException;
import 'dart:convert' show jsonDecode, jsonEncode;
import 'dart:io' show SocketException;

import 'package:http/http.dart' as http;
import 'package:my_store/core/network/api_exception.dart';

const Duration _timeout = Duration(seconds: 30);

class ApiClient {
  const ApiClient({required this.client, required this.baseUrl});

  final http.Client client;
  final String baseUrl;

  Future<dynamic> get(String path) {
    return _handleRequest(() {
      final call = client.get(
        Uri.parse('$baseUrl$path'),
        headers: {'Accept': 'application/json'},
      );
      return call.timeout(_timeout);
    });
  }

  Future<dynamic> post(String path, {required Map<String, dynamic> body}) {
    return _handleRequest(() {
      final call = client.post(
        Uri.parse('$baseUrl$path'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(body),
      );

      return call.timeout(_timeout);
    });
  }

  Future<dynamic> put(String path, {required Map<String, dynamic> body}) {
    return _handleRequest(() {
      final call = client.put(
        Uri.parse('$baseUrl$path'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(body),
      );

      return call.timeout(_timeout);
    });
  }

  Future<dynamic> delete(String path) async {
    return _handleRequest(() {
      final call = client.delete(
        Uri.parse('$baseUrl$path'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      return call.timeout(_timeout);
    });
  }

  dynamic _decodeBody(String body) {
    if (body.isEmpty) return null;

    try {
      return jsonDecode(body);
    } on FormatException {
      throw const ParsingException();
    }
  }

  String? _extractMessage(dynamic decodedBody) {
    if (decodedBody is! Map<String, dynamic>) return null;

    final message = decodedBody['message'];
    return message is String ? message : null;
  }

  ApiException _mapErrorResponse(int statusCode, dynamic decodedBody) {
    final message = _extractMessage(decodedBody);
    switch (statusCode) {
      case 400:
        return BadRequestException(message: message ?? 'Bad Request');
      case 401:
        return UnauthorizedException(message: message ?? 'Unauthorized');
      case 403:
        return ForbiddenAccessException(message: message ?? 'Forbidden');
      case 404:
        return NotFoundException(message: message ?? 'Not Found');
      default:
        return ServerException(
          statusCode: statusCode,
          message: message ?? 'Server error',
        );
    }
  }

  Future<dynamic> _handleRequest(
    Future<http.Response> Function() sendRequest,
  ) async {
    try {
      final response = await sendRequest();
      final decodedBody = _decodeBody(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return decodedBody;
      }

      throw _mapErrorResponse(response.statusCode, decodedBody);
    } on SocketException {
      throw const NoInternetException();
    } on TimeoutException {
      throw const RequestTimeoutException();
    } catch (e, st) {
      if (e is ApiException) rethrow;
      throw Error.throwWithStackTrace(
        const ServerException(statusCode: -1, message: 'Unknown error'),
        st,
      );
    }
  }
}

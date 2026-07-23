sealed class ApiException implements Exception {
  const ApiException({this.statusCode, required this.message});

  final int? statusCode;
  final String message;
}

class NoInternetException extends ApiException {
  const NoInternetException({super.message = 'No internet connection'});
}

class RequestTimeoutException extends ApiException {
  const RequestTimeoutException({super.message = 'Request timed out'});
}

class ParsingException extends ApiException {
  const ParsingException({super.message = 'Failed to parse data'});
}

class BadRequestException extends ApiException {
  const BadRequestException({super.message = 'Bad Request'});
}

class UnauthorizedException extends ApiException {
  const UnauthorizedException({super.message = 'Unauthorized'});
}

class ForbiddenAccessException extends ApiException {
  const ForbiddenAccessException({
    super.statusCode = 403,
    super.message = 'Forbidden access',
  });
}

class NotFoundException extends ApiException {
  const NotFoundException({
    super.statusCode = 404,
    super.message = 'Resource not found',
  });
}

class ServerException extends ApiException {
  const ServerException({super.statusCode, super.message = 'Server error'});
}

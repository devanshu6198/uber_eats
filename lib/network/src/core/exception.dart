class ApiException implements Exception {
  final String? message;

  const ApiException({this.message});

  @override
  String toString() => "$runtimeType(message: $message)";
}

class TimeoutException extends ApiException {
  const TimeoutException({super.message});
}

class InternetConnectionException extends ApiException {
  const InternetConnectionException({super.message});
}

class TokenExpiredException extends ApiException {
  const TokenExpiredException({super.message});
}

class UnauthorizedException extends ApiException {
  const UnauthorizedException({super.message});
}

class ApiResponseException extends ApiException {
  final int statusCode;
  final Map<String, dynamic>? errors;

  const ApiResponseException({
    required this.statusCode,
    super.message,
    this.errors,
  });

  factory ApiResponseException.fromJson(Map<String, dynamic> json) {
    return ApiResponseException(
      statusCode: json['status_code'] as int,
      message: json['message'] as String?,
      errors: json['errors'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status_code': statusCode,
      'message': message,
      'errors': errors,
    };
  }

  @override
  String toString() => "$runtimeType(statusCode: $statusCode, message: $message, errors: $errors)";

  ApiResponseException copyWith({
    int? statusCode,
    String? message,
    Map<String, dynamic>? errors,
  }) {
    return ApiResponseException(
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
      errors: errors ?? this.errors,
    );
  }
}

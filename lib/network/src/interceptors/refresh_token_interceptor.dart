import 'dart:io' as io;

import 'package:dio/dio.dart';
import 'package:uber_eats/network/network.dart';

import 'interceptors.dart';
import 'logging_interceptor.dart';

class RefreshTokenInterceptor extends QueuedInterceptor {
  final Dio _refreshDio = Dio(BaseOptions(contentType: io.ContentType.json.mimeType))
    ..interceptors.add(LoggingInterceptor());
  final String refreshTokenUrl;
  final TokenDataCallback onNewTokenData;
  final GetTokenCallback getRefreshToken;
  final GetHeadersCallback? getHeadersCallback;

  RefreshTokenInterceptor({
    required this.refreshTokenUrl,
    required this.onNewTokenData,
    required this.getRefreshToken,
    this.getHeadersCallback,
  });

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.type == DioErrorType.badResponse && err.response?.statusCode == 401) {
      try {
        await _refreshToken();
        return handler.reject(DioError(
          type: DioErrorType.badResponse,
          requestOptions: err.requestOptions,
          error: const TokenExpiredException(),
        ));
      } on DioError catch (dioError) {
        printError("$runtimeType -> DioError -> ${dioError.requestOptions.method} -> ${dioError.requestOptions.uri}");
        printError("$runtimeType -> DioError -> ${dioError.type} -> ${dioError.message} -> ${dioError.response}");
        return handler.next(dioError);
      } catch (error) {
        return handler.reject(DioError(type: DioErrorType.badResponse, requestOptions: err.requestOptions, error: error));
      }
    }
    handler.next(err);
  }

  Future<void> _refreshToken() async {
    var options = Options(headers: {
      io.HttpHeaders.authorizationHeader: "Bearer ${getRefreshToken()}",
      io.HttpHeaders.acceptHeader: Headers.jsonContentType,
      io.HttpHeaders.contentTypeHeader: Headers.jsonContentType,
      if (getHeadersCallback != null) ...getHeadersCallback!()
    });
    try {
      Response response = await _refreshDio.get(refreshTokenUrl, options: options);
      final tokenData = parseTokenData(response);
      if (tokenData == null) {
        throw const ApiException(message: '`accessToken` and `refreshToken` should be provided in cookie');
      } else {
        onNewTokenData(tokenData);
      }
    } on DioError catch (error) {
      if (error.type == DioErrorType.badResponse && error.response?.statusCode == 422) return;
      rethrow;
    }
  }
}

import 'package:dio/dio.dart';

import 'interceptors.dart';

class LoggingInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    printRequest("═══════════════════════════════════ Request Options ═══════════════════════════════════");
    printRequest("Request -> ${options.method} -> ${options.uri}");
    printRequest("QueryParameters -> ${jsonEncoder.convert(options.queryParameters)}");
    printRequest("Headers ->");
    jsonEncoder.convert(options.headers).split('\n').forEach(printRequest);
    if (options.data is Map || options.data is Iterable) {
      printRequest("Data ->");
      jsonEncoder.convert(options.data).split('\n').forEach(printRequest);
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    printResponse("═══════════════════════════════════ Response ═══════════════════════════════════");
    printResponse("Response -> ${response.requestOptions.method} -> ${response.requestOptions.uri}");
    if (response.data is Map || response.data is List) {
      printResponse("Data ->");
      jsonEncoder.convert(response.data).split('\n').forEach(printResponse);
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    printError("═══════════════════════════════════ DioError ═══════════════════════════════════");
    printError("DioError -> ${err.requestOptions.method} -> ${err.requestOptions.uri}");
    printError("DioError -> ${err.type} -> ${err.message}");
    if (err.response?.data is Map) {
      printError("DioError -> Data ->");
      jsonEncoder.convert(err.response?.data).split('\n').forEach(printError);
    }
    super.onError(err, handler);
  }
}

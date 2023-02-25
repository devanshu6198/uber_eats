import 'dart:async';

import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

typedef ResponseParser<T> = T Function(dynamic value);

class ApiRequest<T extends Object?> {
  final RequestType requestType;
  final String path;
  Map<String, dynamic>? _headers;
  Map<String, dynamic>? _queryParams;
  Object? _data;
  ResponseParser<T> responseParser = (value) => value as T;

  static const _uuid = Uuid();

  ApiRequest(
    this.requestType,
    this.path, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
    Object? data,
  })  : _headers = headers,
        _queryParams = queryParams,
        _data = data;

  set headers(Map<String, dynamic> value) => _headers = value;

  set queryParams(Map<String, dynamic> value) => _queryParams = value;

  set data(Object value) => _data = value;

  FutureOr<dynamic> enqueue(Dio dio, {String? baseUrl}) async {
    final result = await dio.fetch(_setStreamType(Options(method: requestType.name, headers: _headers)
        .compose(dio.options, path, queryParameters: _queryParams, data: _data)
        .copyWith(baseUrl: baseUrl ?? dio.options.baseUrl)));
    return result.data;
  }

  RequestOptions _setStreamType(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes || requestOptions.responseType == ResponseType.stream)) {
      requestOptions.responseType = ResponseType.json;
    }
    return requestOptions;
  }

  String get cacheKey {
    String storageKey = path;
    var queryParams = _queryParams;
    if (queryParams != null && queryParams.isNotEmpty) {
      storageKey += '?';
      queryParams.forEach((key, value) => storageKey += '$key=$value&');
    }
    return _uuid.v5(Uuid.NAMESPACE_URL, storageKey);
  }
}

enum RequestType {
  post("POST"),
  get("GET"),
  put("PUT"),
  delete("DELETE"),
  patch("PATCH"),
  copy("COPY"),
  head("HEAD"),
  options("OPTIONS"),
  link("LINK"),
  unlink("UNLINK"),
  purge("PURGE"),
  lock("LOCK"),
  unlock("UNLOCK"),
  view("VIEW");

  final String value;

  const RequestType(this.value);
}

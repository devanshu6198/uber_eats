import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:uber_eats/network/network.dart';

import 'interceptors.dart';

class EncryptionInterceptor extends InterceptorsWrapper {
  final Encryption encryption;
  final Encryption decryption;

  EncryptionInterceptor({
    required String encryptionKey,
    required String encryptionIv,
    required String decryptionKey,
    required String decryptionIv,
  })  : encryption = Encryption.fromUtf8(key: encryptionKey, iv: encryptionIv),
        decryption = Encryption.fromUtf8(key: decryptionKey, iv: decryptionIv);

  EncryptionInterceptor.fromBase64({
    required String encryptionKey,
    required String encryptionIv,
    required String decryptionKey,
    required String decryptionIv,
  })  : encryption = Encryption.fromBase64(key: encryptionKey, iv: encryptionIv),
        decryption = Encryption.fromBase64(key: decryptionKey, iv: decryptionIv);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if ((options.data is Map<String, dynamic> && options.data.isNotEmpty) ||
        (options.data is Iterable && options.data.isNotEmpty)) {
      var encrypted = encryption.encrypt(jsonEncode(options.data)).toJson();
      options.data = encrypted;
      printRequest("Encrypted Data ->");
      jsonEncoder.convert(options.data).split('\n').forEach(printRequest);
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.data is Map<String, dynamic>) {
      var encryptResp = CipherValue.fromJson(response.data);
      var decrypted = decryption.decrypt(encryptResp);
      var decryptedData = jsonDecode(decrypted);
      response.data = decryptedData;
      if (response.data is Map || response.data is List) {
        printResponse("Decrypted Data ->");
        jsonEncoder.convert(response.data).split('\n').forEach(printResponse);
      }
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    var previousData = err.requestOptions.data;
    if (previousData is Map && previousData.isNotEmpty) {
      var encryptedData = CipherValue.fromJson(previousData);
      var decrypted = encryption.decrypt(encryptedData);
      err.requestOptions.data = jsonDecode(decrypted);
    }
    super.onError(err, handler);
  }
}

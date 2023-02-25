import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:equatable/equatable.dart';

class Encryption {
  final IV _iv;
  late final Encrypter _encrypter;
  late final Hmac _hMac;

  Encryption.fromUtf8({
    required String key,
    required String iv,
  }) : _iv = IV.fromUtf8(iv) {
    var encryptionKey = Key.fromUtf8(key);
    _encrypter = Encrypter(AES(encryptionKey, mode: AESMode.cbc));
    _hMac = Hmac(sha256, encryptionKey.bytes);
  }

  Encryption.fromBase64({
    required String key,
    required String iv,
  }) : _iv = IV.fromBase64(iv) {
    var encryptionKey = Key.fromBase64(key);
    _encrypter = Encrypter(AES(encryptionKey, mode: AESMode.cbc));
    _hMac = Hmac(sha256, encryptionKey.bytes);
  }

  CipherValue encrypt(String plainText) {
    try {
      var encryptedValue = _encrypter.encrypt(plainText, iv: _iv).base64.replaceAll("\n", "");
      var mac = _hMac.convert(utf8.encode(_iv.base64 + encryptedValue));
      var encData = CipherValue(mac: mac.toString(), value: encryptedValue);
      return encData;
    } catch (e) {
      rethrow;
    }
  }

  String decrypt(CipherValue cipher) {
    var mac = _hMac.convert(utf8.encode(_iv.base64 + cipher.value));
    if (mac.toString() == cipher.mac) {
      return _encrypter.decrypt64(cipher.value, iv: _iv);
    } else {
      throw UnsecureNetworkException();
    }
  }
}

class UnsecureNetworkException implements Exception {}

class CipherValue extends Equatable {
  final String mac;
  final String value;

  const CipherValue({required this.mac, required this.value});

  factory CipherValue.fromJson(json) {
    Map<String, dynamic> data = json is String ? jsonDecode(json) : json;
    return CipherValue(
      mac: data['mac'].toString(),
      value: data['value'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mac': mac,
      'value': value,
    };
  }

  @override
  List<Object?> get props => [mac, value];

  @override
  String toString() => 'CipherValue(mac: $mac, value: $value)';
}

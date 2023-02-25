import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:uber_eats/network/network.dart';

typedef TokenDataCallback = void Function(TokenData data);
typedef GetTokenCallback = String Function();
typedef GetHeadersCallback = Map<String, dynamic> Function();

const jsonEncoder = JsonEncoder.withIndent('  ');

const _ansiEsc = '\x1B[';
const _ansiDefault = '${_ansiEsc}0m';

void printRequest(Object? value) => print("${_ansiEsc}38;5;208m$value$_ansiDefault");

void printError(Object? value) => print("${_ansiEsc}38;5;196m$value$_ansiDefault");

void printResponse(Object? value) => print("${_ansiEsc}38;5;77m$value$_ansiDefault");

TokenData? parseTokenData(Response response) {
  String refreshToken = "";
  String accessToken = "";
  response.headers["set-cookie"]?.forEach((cookie) {
    cookie.split(";").forEach((part) {
      var value = part.split("=");
      switch (value[0].trim()) {
        case "accessToken":
          accessToken = value[1].trim();
          break;
        case "refreshToken":
          refreshToken = value[1].trim();
          break;
      }
    });
  });
  if (refreshToken.isNotEmpty && accessToken.isNotEmpty) {
    return TokenData(accessToken: accessToken, refreshToken: refreshToken);
  }
  return null;
}

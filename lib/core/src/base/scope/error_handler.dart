import 'package:flutter/material.dart';
import 'package:uber_eats/network/network.dart';

abstract class ErrorHandler {
  void showError(BuildContext context, String error);

  void onUserUnauthorized(BuildContext context);

  void onApiException(BuildContext context, ApiException apiException);
}

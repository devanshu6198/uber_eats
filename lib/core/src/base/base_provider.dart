import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uber_eats/helpers/helpers.dart';
import 'package:uber_eats/network/network.dart';

import 'app_scope.dart';
import 'mixin/api_helper_mixin.dart';
import 'mixin/subscription_mixin.dart';
import 'scope/error_handler.dart';

class BaseProvider extends ChangeNotifier with StreamSubscriptionMixin, ApiHelperMixin {
  final BuildContext context;

  bool isClosed = false;

  ErrorHandler get errorHandler => ApplicationScope.current.errorHandler;

  Loader get loader => ApplicationScope.current.loader;

  ConnectivityHelper get connectivityHelper => ApplicationScope.current.connectivityHelper;

  BaseProvider(this.context) {
    Timer.run(onCreate);
  }

  @protected
  @mustCallSuper
  void onCreate() {}

  @override
  void dispose() {
    isClosed = true;
    cancelSubscriptions();
    super.dispose();
  }

  @protected
  @override
  void handleLoader(bool isLoading) {
    if (isLoading) {
      loader.show(context);
    } else {
      loader.dismiss(context);
    }
  }

  @mustCallSuper
  @protected
  Future<void> processData<T>(
    Stream<DataEvent<T>> stream, {
    bool showLoading = true,
    required void Function(T data) onSuccess,
    void Function(bool isLoading)? onLoading,
    void Function(ApiException exception)? onFailure,
  }) async {
    if (!connectivityHelper.hasInternet) onApiExceptions(const InternetConnectionException());
    await for (var event in stream) {
      if (!isClosed) {
        processDataEvents<T>(
          event,
          onSuccess: onSuccess,
          onLoading: onLoading,
          onFailure: onFailure,
          showLoading: showLoading,
        );
      }
    }
  }

  @protected
  @override
  void onUnauthorized() {
    errorHandler.onUserUnauthorized(context);
  }

  @override
  void showErrorMessage(String message) {
    ScaffoldMessenger?.of(context).showSnackBar(
      SnackBar(content: Text(message),padding: const EdgeInsetsDirectional.all(8),),
    );
  }

  @override
  void showErrorDialog(String error) {
    errorHandler.showError(context, error);
  }

  @protected
  @override
  void onApiExceptions(ApiException exception) {
    errorHandler.onApiException(context, exception);
  }
}

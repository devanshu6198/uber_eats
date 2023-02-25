import 'dart:io';

import 'package:uber_eats/network/network.dart';



mixin ApiHelperMixin {
  int _loaderCount = 0;

  void processDataEvents<T>(
    DataEvent<T> event, {
    bool showLoading = true,
    required void Function(T data) onSuccess,
    void Function(bool isLoading)? onLoading,
    void Function(ApiException exception)? onFailure,
  }) {
    onLoading ??= _handleLoader;
    onFailure ??= _handleApiExceptions;
    if (event is LoadingEvent<T>) {
      if (showLoading) {
        onLoading(event.isLoading);
      }
    } else if (event is SuccessEvent<T>) {
      onSuccess(event.data);
    } else if (event is FailureEvent<T>) {
      onFailure(event.exception);
    }
  }

  /// handles show/dismiss of loading dialog
  void _handleLoader(bool isLoading) {
    if (isLoading) {
      if (_loaderCount == 0) {
        handleLoader(isLoading);
      }
      _loaderCount++;
    } else {
      _loaderCount--;
      if (_loaderCount == 0) {
        handleLoader(isLoading);
      }
    }
  }

  void _handleApiExceptions(ApiException exception) {
    if (exception is ApiResponseException) {
      var isHandled = _handleResponseError(exception);
      if (isHandled) return;
    }
    onApiExceptions(exception);
  }

  bool _handleResponseError(ApiResponseException exception) {
    switch (exception.statusCode) {
      case HttpStatus.internalServerError:
      case HttpStatus.badRequest:
      case HttpStatus.forbidden:
      case HttpStatus.notFound:
      case HttpStatus.conflict:
      case HttpStatus.locked:
      case HttpStatus.paymentRequired:
        if (exception.message != null && exception.message!.isNotEmpty) {
          showErrorMessage(exception.message!);
          return true;
        }
        break;
      case HttpStatus.unprocessableEntity:
        print("GetErrorData: ${exception.errors}");
        if (exception.errors == null || exception.errors!.isEmpty) {
          if (exception.message != null && exception.message!.isNotEmpty) {
            showErrorMessage(exception.message!);
            return true;
          }
        } else {
          String error = "";
          print("GetErrorDataLength: ${exception.errors?.length}");
          exception.errors!.forEach((key, value) {
            error += "• $value\n";
          });
          showErrorDialog(error);
          return true;
        }
        break;
      case HttpStatus.unauthorized:
        onUnauthorized();
        return true;
    }
    return false;
  }

  void handleLoader(bool isLoading);

  void onUnauthorized();

  void showErrorMessage(String message);

  void showErrorDialog(String error);

  void onApiExceptions(ApiException exception);
}

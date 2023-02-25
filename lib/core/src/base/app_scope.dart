import 'dart:async' as async;

import 'package:flutter/material.dart';
import 'package:uber_eats/core/src/widgets/loader.dart';
import 'package:uber_eats/helpers/helpers.dart';

import 'scope/error_handler.dart';

part 'scope/loader.dart';

abstract class ApplicationScope {
  static const Object _token = Object();

  static R? runZoned<R>(
    R Function() body, {
    required ErrorHandler errorHandler,
    Loader? loader,
    ConnectivityHelper? connectivityHelper,
  }) {
    current = _ApplicationScopeOverrides(errorHandler, loader, connectivityHelper ?? ConnectivityHelper());
    return async.runZoned(body, zoneValues: {_token: current});
  }

  static late ApplicationScope current;

  ErrorHandler get errorHandler;

  Loader get loader => _defaultLoader;

  ConnectivityHelper get connectivityHelper;
}

final _defaultLoader = LoadingDialog();

class _ApplicationScopeOverrides extends ApplicationScope {
  final ErrorHandler _errorHandler;
  final Loader? _loader;
  @override
  final ConnectivityHelper connectivityHelper;

  _ApplicationScopeOverrides(this._errorHandler, this._loader, this.connectivityHelper);

  @override
  ErrorHandler get errorHandler => _errorHandler;

  @override
  Loader get loader => _loader ?? super.loader;
}

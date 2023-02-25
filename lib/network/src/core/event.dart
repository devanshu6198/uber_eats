import 'package:equatable/equatable.dart';

import 'exception.dart';

abstract class DataEvent<T> extends Equatable {
  const DataEvent();

  factory DataEvent.loading(bool isLoading) => LoadingEvent._(isLoading);

  factory DataEvent.success(T data, [bool isCached = false]) => SuccessEvent._(data, isCached);

  factory DataEvent.failure(ApiException exception) => FailureEvent._(exception);
}

class SuccessEvent<T> extends DataEvent<T> {
  final T data;
  final bool isCache;

  const SuccessEvent._(this.data, [this.isCache = false]);

  @override
  String toString() => 'SuccessEvent{data: $data, isCache: $isCache}';

  Map<String, dynamic> toJson() => {'data': data, 'isCache': isCache};

  @override
  List<Object?> get props => [data, isCache];
}

class FailureEvent<T> extends DataEvent<T> {
  final ApiException exception;

  const FailureEvent._(this.exception);

  @override
  String toString() => 'FailureEvent{exception: $exception}';

  Map<String, dynamic> toJson() => {'exception': exception};

  @override
  List<Object?> get props => [exception];
}

class LoadingEvent<T> extends DataEvent<T> {
  final bool isLoading;

  const LoadingEvent._([this.isLoading = false]);

  @override
  String toString() => 'LoadingEvent{isLoading: $isLoading}';

  Map<String, dynamic> toJson() => {'isLoading': isLoading};

  @override
  List<Object?> get props => [isLoading];
}

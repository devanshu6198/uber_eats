import 'dart:async';

import 'package:uber_eats/core/core.dart';



mixin StreamSubscriptionMixin {
  final Lazy<List<StreamSubscription>> _listSubscription = Lazy(() => []);

  List<StreamSubscription> get listSubscription => _listSubscription();

  Future<void> cancelSubscriptions() {
    if (_listSubscription.isCreated) {
      return Future.wait(_listSubscription().map((e) => e.cancel()));
    }
    return Future.value();
  }
}

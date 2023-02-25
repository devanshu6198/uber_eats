
import 'package:flutter/material.dart';
import 'package:uber_eats/core/core.dart';

class LoadingDialog extends Loader {
  @override
  Widget buildLoader() => const CircularProgressIndicator.adaptive();
}

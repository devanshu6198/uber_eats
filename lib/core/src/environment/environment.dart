import 'config.dart';
export 'config.dart';

abstract class Environment {
  final BaseConfig config;

  const Environment(this.config);
}

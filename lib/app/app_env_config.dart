import 'package:injectable/injectable.dart';

@module
abstract class EnvConfigurations {
  // You can register named preemptive types like follows
  @Environment(Env.dev)
  @Named("BaseUrl")
  String get baseDevUrl => 'https://attendance-application-devlopment-api.wastles.com/';

  @Environment(Env.prod)
  @Named("BaseUrl")
  String get baseProdUrl => 'https://attendance.com/api/v1/';
}

abstract class Env {
  static const dev = "dev";
  static const prod = "prod";
}

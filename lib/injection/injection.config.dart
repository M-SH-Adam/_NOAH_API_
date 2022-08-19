// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../app/app_env_config.dart' as _i5;
import '../repository/location_repository.dart' as _i3;
import '../web_services/http_client.dart' as _i6;

const String _dev = 'dev';
const String _prod = 'prod';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final envConfigurations = _$EnvConfigurations();
  final httpClient = _$HttpClient();
  gh.factory<_i3.LocationRepository>(() => _i3.LocationRepository());
  gh.factory<String>(() => envConfigurations.baseDevUrl,
      instanceName: 'BaseUrl', registerFor: {_dev});
  gh.factory<String>(() => envConfigurations.baseProdUrl,
      instanceName: 'BaseUrl', registerFor: {_prod});
  gh.lazySingleton<_i4.Dio>(
      () => httpClient.dio(get<String>(instanceName: 'BaseUrl')));
  return get;
}

class _$EnvConfigurations extends _i5.EnvConfigurations {}

class _$HttpClient extends _i6.HttpClient {}

import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:dio/dio.dart';
import '../utils/utils_functions.dart';
import 'dio_flutter_transformer.dart';
import 'error_helper.dart';

@module
abstract class HttpClient {
  @lazySingleton
  Dio dio(@Named('BaseUrl') String url) {
    BaseOptions options = BaseOptions(
      baseUrl: url,
      connectTimeout: 60 * 1000, // 60 seconds
      receiveTimeout: 60 * 1000, // 60 seconds
    );
    return Dio(options)
      ..interceptors.add(PrettyDioLogger(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
      ))
      ..interceptors.add(InterceptorsWrapper(onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) {
        //TODO send user token to the api header
        // var token = getIt<PreferenceUtils>().getData(SharedPrefsKeys.userToken);
        // if (token != null) {
        //   options.headers['Authorization'] = "Bearer $token";
        // }
        return handler.next(options);
      }, onError: (DioError error, ErrorInterceptorHandler handler) {
        UtilsFunctions.showSnackBar(
            text: ExceptionHelper.parse(err: error).message!);
        return handler.next(error);
      }))
      ..transformer = FlutterTransformer();
  }
}

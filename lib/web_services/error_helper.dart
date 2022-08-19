import 'package:dio/dio.dart';


class ExceptionHelper implements Exception {
  String? tag;
  String? message;
  ExceptionHelper([this.message, this.tag]);

  static ExceptionHelper parse({Exception? err, String? message}) {
    String eMsg = "Unknown Error";
    String nMsg = eMsg;

    try {
      if (err is DioError) {
        switch (err.type) {
          case DioErrorType.cancel:
            eMsg = "Request Cancelled";
            break;
          case DioErrorType.connectTimeout:
            eMsg = "Request Timeout";
            break;
          // case DioErrorType.DEFAULT:
          case DioErrorType.other:
            eMsg = "No Internet Connection";
            break;
          case DioErrorType.receiveTimeout:
            eMsg = "Send Timeout";
            break;
          case DioErrorType.response:
            switch (err.response!.statusCode) {
              case 400:
                eMsg = err.response!.data['message'];
                break;
              case 401:
                eMsg = err.response!.data['message'] ?? "Unauthorised Request";
                break;
              case 403:
                eMsg = err.response!.data['message'] ??  "Unauthorised Request";
                break;
              case 404:
                eMsg = err.response!.data['message'] ?? "Not Found";
                break;
              case 409:
                eMsg = err.response!.data['message'] ??  "Conflict";
                break;
              case 408:
                eMsg = err.response!.data['message'] ??  "Request Timeout";
                break;
              case 500:
                eMsg = err.response!.data['message'] ??  "Internal Server Error";
                break;
              case 503:
                eMsg = err.response!.data['message'] ??  "Service Unavailable";
                break;
              case 504:
                eMsg = err.response!.data['message'] ??  "Gateway Time-out";
                break;
              default:
                var responseCode = err.response!.statusCode;
                eMsg = "${"Received invalid status code"}: $responseCode";
            }
            break;
          case DioErrorType.sendTimeout:
            eMsg = "Send Timeout";
            break;
        }
        if (err.response!.data['message'] == 'validation error(s)') {
          eMsg = err.response!.data['details'][0]['message'];
        }
      } else {
        eMsg = "Internal Server Error";
      }
    } catch (e) {} finally {
      if (message != null) {
        nMsg = '$message\n$eMsg';
      } else {
        nMsg = eMsg;
      }
    }
    return ExceptionHelper(nMsg);
  }
}

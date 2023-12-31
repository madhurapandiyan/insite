import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class DioException implements Exception {
  DioException.fromDioError(DioError dioError) {
    Logger().d(dioError.type);
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.unknown:
        message = "Connection to API server failed due to internet connection";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.badResponse:
        message = _handleError(dioError.response!.statusCode, dioError);
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String? message;

  String _handleError(int? statusCode, DioError dioError) {
    Logger().e(statusCode);
    switch (statusCode) {
      case 400:
        return 'Bad request:${dioError.response!.data["message"]}';
      case 401:
        return "Unauthorized:${dioError.response!.data}";
      case 404:
        return 'The requested resource was not found';
      case 500:
        return 'Internal server error';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message!;
}

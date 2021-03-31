import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'Retrofit.dart';

class MyApi {
  MyApi._internal() {
    httpWrapper = HttpWrapper();
  }

  static final MyApi _singleton = MyApi._internal();

  factory MyApi() => _singleton;

  HttpWrapper httpWrapper;

  RestClient getClient() {
    return httpWrapper.client;
  }
}

class HttpWrapper {
  final String _baseUrl = "https://identity.trimble.com";
  final bool SHOW_LOGS = true;

  Dio dio = new Dio();
  var client;

  HttpWrapper._internal() {
    BaseOptions options = new BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    dio = Dio(options);
    var cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));

    dio.interceptors
      ..add(InterceptorsWrapper(
        onRequest: (Options options) async {
          options.headers.addAll({"token": "token", "timezoneoffset": -330});
          return options;
        },
      ))
      ..add(LogInterceptor(
        responseBody: SHOW_LOGS,
        requestBody: SHOW_LOGS,
      ));

    client = RestClient(dio);
  }

  static final HttpWrapper _singleton = HttpWrapper._internal();

  factory HttpWrapper() => _singleton;
}

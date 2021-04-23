import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:insite/core/services/local_service.dart';
import '../locator.dart';
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

  RestClient getClientOne() {
    return httpWrapper.clientOne;
  }
}

class HttpWrapper {
  final String _baseUrl = "https://unifiedfleet.myvisionlink.com";
  final String _baseUrlOne = "https://identity.trimble.com";

  final bool SHOW_LOGS = true;
  final _localService = locator<LocalService>();

  Dio dio = new Dio();
  Dio dioOne = new Dio();
  var client;
  var clientOne;

  HttpWrapper._internal() {
    BaseOptions options = new BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    dio = Dio(options);
    dioOne = Dio(options);
    var cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
    dioOne.interceptors.add(CookieManager(cookieJar));

    dio.interceptors
      ..add(InterceptorsWrapper(
        onRequest: (Options options) async {
          options.headers.addAll({
            "content-type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer " + await _localService.getToken(),
            // "Authorization": "Bearer   9e1c28d386c47462d88f3cda26f3841",
            "timezoneoffset": -330
          });
          return options;
        },
      ))
      ..add(LogInterceptor(
        responseBody: SHOW_LOGS,
        requestBody: SHOW_LOGS,
      ));

    dioOne.interceptors
      ..add(InterceptorsWrapper(
        onRequest: (Options options) async {
          options.headers.addAll({
            "content-type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer " + await _localService.getToken(),
            "timezoneoffset": -330
          });
          return options;
        },
      ))
      ..add(LogInterceptor(
        responseBody: SHOW_LOGS,
        requestBody: SHOW_LOGS,
      ));

    client = RestClient(dio, baseUrl: _baseUrl);
    clientOne = RestClient(dioOne, baseUrl: _baseUrlOne);
  }

  static final HttpWrapper _singleton = HttpWrapper._internal();

  factory HttpWrapper() => _singleton;
}

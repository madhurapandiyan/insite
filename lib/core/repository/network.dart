import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:insite/core/flavor/flavor.dart';
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

  RestClient getClientTwo() {
    return httpWrapper.clientTwo;
  }

  RestClient getClientThree() {
    return httpWrapper.clientThree;
  }

  RestClient getClientFour() {
    return httpWrapper.clientFour;
  }

  RestClient getClientFive() {
    return httpWrapper.clientFive;
  }

  RestClient getClientSix() {
    return httpWrapper.clientSix;
  }
}

class HttpWrapper {
  final String _baseUrlService = "https://unifiedservice.myvisionlink.com";
  final String _baseUrlOne = "https://identity.trimble.com";
  final String _baseUrlTwo = "https://singlesearch.alk.com";
  final String _baseUrlFour = "https://api.trimble.com";
  final String _baseUrlFive = "https://id.trimble.com";
  final String _baseUrlSix = "https://cloud.api.trimble.com";

  final bool SHOW_LOGS = true;
  final _localService = locator<LocalService>();

  Dio dio = new Dio();
  Dio dioOne = new Dio();
  Dio dioTwo = new Dio();
  Dio dioThree = new Dio();
  Dio dioFour = new Dio();
  Dio dioFive = new Dio();
  Dio dioSix = new Dio();

  var client;
  var clientOne;
  var clientTwo;
  var clientThree;
  var clientFour;
  var clientFive;
  var clientSix;

  HttpWrapper._internal() {
    BaseOptions options = new BaseOptions(
      baseUrl: AppConfig.instance.baseUrl,
      connectTimeout: 30000,
      receiveTimeout: 30000,
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
            "Accept": "application/json",
            //"Authorization": "Bearer " + await _localService.getToken(),
            "timezoneoffset": -330
          });
          return options;
        },
      ))
      ..add(LogInterceptor(
        responseBody: SHOW_LOGS,
        requestBody: SHOW_LOGS,
      ));

    dioTwo.interceptors
      ..add(InterceptorsWrapper(
        onRequest: (Options options) async {
          options.headers.addAll({
            "content-type": "application/json",
            "Accept": "application/json",
          });
          return options;
        },
      ))
      ..add(LogInterceptor(
        responseBody: SHOW_LOGS,
        requestBody: SHOW_LOGS,
      ));

    dioThree.interceptors
      ..add(InterceptorsWrapper(
        onRequest: (Options options) async {
          options.headers.addAll({
            "content-type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer " + await _localService.getToken(),
          });
          return options;
        },
      ))
      ..add(LogInterceptor(
        responseBody: SHOW_LOGS,
        requestBody: SHOW_LOGS,
      ));

    dioFour.interceptors
      ..add(InterceptorsWrapper(
        onRequest: (Options options) async {
          options.headers.addAll({
            "content-type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer " + await _localService.getToken(),
          });
          return options;
        },
      ))
      ..add(LogInterceptor(
        responseBody: SHOW_LOGS,
        requestBody: SHOW_LOGS,
      ));

    dioFive.interceptors
      ..add(InterceptorsWrapper(
        onRequest: (Options options) async {
          options.headers
              .addAll({"Accept": "application/json", "timezoneoffset": -330});
          return options;
        },
      ))
      ..add(LogInterceptor(
        responseBody: SHOW_LOGS,
        requestBody: SHOW_LOGS,
      ));

    dioSix.interceptors
      ..add(InterceptorsWrapper(
        onRequest: (Options options) async {
          options.headers.addAll({
            "content-type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer " + await _localService.getToken(),
          });
          return options;
        },
      ))
      ..add(LogInterceptor(
        responseBody: SHOW_LOGS,
        requestBody: SHOW_LOGS,
      ));

    client = RestClient(dio, baseUrl: AppConfig.instance.baseUrl);
    clientOne = RestClient(dioOne, baseUrl: _baseUrlOne);
    clientTwo = RestClient(dioTwo, baseUrl: _baseUrlTwo);
    clientThree = RestClient(dioThree, baseUrl: _baseUrlService);
    clientFour = RestClient(dioFour, baseUrl: _baseUrlFour);
    clientFive = RestClient(dioFive, baseUrl: _baseUrlFive);
    clientSix = RestClient(dioSix, baseUrl: _baseUrlSix);
  }

  static final HttpWrapper _singleton = HttpWrapper._internal();

  factory HttpWrapper() => _singleton;
}

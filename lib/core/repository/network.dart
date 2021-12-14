import 'dart:async';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:insite/core/flavor/flavor.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:logger/logger.dart';
import '../locator.dart';
import 'Retrofit.dart';

class MyApi {
  MyApi._internal() {
    httpWrapper = HttpWrapper();
  }
  static final MyApi _singleton = MyApi._internal();

  final LocalService? _localService1 = locator<LocalService>();

  factory MyApi() => _singleton;

  late HttpWrapper httpWrapper;

  RestClient? getClient() {
    return httpWrapper.client;
  }

  RestClient? getClientOne() {
    return httpWrapper.clientOne;
  }

  RestClient? getClientTwo() {
    return httpWrapper.clientTwo;
  }

  RestClient? getClientThree() {
    return httpWrapper.clientThree;
  }

  RestClient? getClientFour() {
    return httpWrapper.clientFour;
  }

  RestClient? getClientFive() {
    return httpWrapper.clientFive;
  }

  RestClient? getClientSix() {
    return httpWrapper.clientSix;
  }

  RestClient? getClientSeven() {
    return httpWrapper.clientSeven;
  }

  RestClient? getClientEight() {
    return httpWrapper.clientEight;
  }

  RestClient? getClientNine() {
    return httpWrapper.clientNine;
  }

  RestClient? getClientTen() {
    return httpWrapper.clientTen;
  }
}

class HttpWrapper {
  String token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6IjEifQ.eyJpc3MiOiJodHRwczovL3N0YWdlLmlkLnRyaW1ibGVjbG91ZC5jb20iLCJleHAiOjE2MzgwMDMwMDYsIm5iZiI6MTYzNzk5OTQwNiwiaWF0IjoxNjM3OTk5NDA2LCJqdGkiOiJlZGE2ZDJlODcwM2I0ZTQ5YjY2MGEyYmFiMzdhZjE5MCIsImp3dF92ZXIiOjIsInN1YiI6ImQ4ZjA4MGEzLTZmZDEtNDUzNi1iMmVkLWI0MTk5MTg4ZjNlNCIsImlkZW50aXR5X3R5cGUiOiJ1c2VyIiwiYW1yIjpbInBhc3N3b3JkIl0sImF1dGhfdGltZSI6MTYzNzk5OTQwNCwiYXpwIjoiN2JlNzU5YjEtYWZjNS00YTRhLThhODYtYmRhNWUwNDVhNTA4IiwiYXVkIjpbIjdiZTc1OWIxLWFmYzUtNGE0YS04YTg2LWJkYTVlMDQ1YTUwOCJdLCJzY29wZSI6Ik9TRy1GUkFNRS1BUFAtU1RBR0UifQ.JZrlVQIEon6thyyKdkRxfr_7CW_5T6Ma7u7hx8GSSaLIBDWh7jMKN5eMfOr13kk7IuYHHVsWZ6_CGV_hGeCw7Ifa5cD6Xcoq2-hwNyKLKLbNYv1IE2HEvEzYeRwS93XDs4nnySztRdvOUCcJ62q1c8BJQ2IgEE4KHukra89sF07SLTr8mfcfyTxCHFQRQgEgZTxRytt1afMZls8oSVzpuX5w4UintmP5MSuLyPppC3NQ1TvU76sYkeWUxuTs73DuY-Uz_Hip_3O4WwApbN6WUgyaXhVzpUKk7oWyb_JB-IOjvFNICr-DmNOLZ7Ie8PUxpHaaLn1jZEDv6Gt0ieowAg";

  final String _baseUrlService = "https://unifiedservice.myvisionlink.com";
  final String _baseUrlOne = "https://identity.trimble.com";
  final String _baseUrlTwo = "https://singlesearch.alk.com";
  final String _baseUrlFour = "https://api.trimble.com";
  final String _baseUrlFive = "https://id.trimble.com";
  final String _baseUrlSix = "https://cloud.api.trimble.com";
  final String _baseUrlSeven = "https://administrator.myvisionlink.com";
  final String _baseUrlEight = "https://cloud.stage.api.trimblecloud.com/";

  final bool SHOW_LOGS = true;
  final LocalService? _localService = locator<LocalService>();

  Dio dio = new Dio();
  Dio dioOne = new Dio();
  Dio dioTwo = new Dio();
  Dio dioThree = new Dio();
  Dio dioFour = new Dio();
  Dio dioFive = new Dio();
  Dio dioSix = new Dio();
  Dio dioSeven = new Dio();
  Dio dioEight = new Dio();
  Dio dioNine = new Dio();
  Dio dioTen = new Dio();

  var client;
  var clientOne;
  var clientTwo;
  var clientThree;
  var clientFour;
  var clientFive;
  var clientSix;
  var clientSeven;
  var clientEight;
  var clientNine;
  var clientTen;

  HttpWrapper._internal() {
    BaseOptions options = new BaseOptions(
      baseUrl: AppConfig.instance!.baseUrl!,
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
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
              token=await (_localService!.getToken());
          options.headers.addAll({
            "content-type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer " + token,
          });
          return handler.next(options);
        },
      ))
      ..add(LogInterceptor(
        responseBody: SHOW_LOGS,
        requestBody: SHOW_LOGS,
      ));

    dioOne.interceptors
      ..add(InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          options.headers.addAll({
            "Accept": "application/json",
            //"Authorization": "Bearer " + await _localService.getToken(),
            "timezoneoffset": -330
          });
           return handler.next(options);
        },
      ))
      ..add(LogInterceptor(
        responseBody: SHOW_LOGS,
        requestBody: SHOW_LOGS,
      ));

    dioTwo.interceptors
      ..add(InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          options.headers.addAll({
            "content-type": "application/json",
            "Accept": "application/json",
          });
          return handler.next(options);
        },
      ))
      ..add(LogInterceptor(
        responseBody: SHOW_LOGS,
        requestBody: SHOW_LOGS,
      ));

    dioThree.interceptors
      ..add(InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          options.headers.addAll({
            "content-type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer " +
                await (_localService!.getToken() as FutureOr<String>),
          });
           return handler.next(options);
        },
      ))
      ..add(LogInterceptor(
        responseBody: SHOW_LOGS,
        requestBody: SHOW_LOGS,
      ));

    dioFour.interceptors
      ..add(InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          options.headers.addAll({
            "content-type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer " +
                await (_localService!.getToken() as FutureOr<String>),
          });
           return handler.next(options);
        },
      ))
      ..add(LogInterceptor(
        responseBody: SHOW_LOGS,
        requestBody: SHOW_LOGS,
      ));

    dioFive.interceptors
      ..add(InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          options.headers
              .addAll({"Accept": "application/json", "timezoneoffset": -330});
           return handler.next(options);
        },
      ))
      ..add(LogInterceptor(
        responseBody: SHOW_LOGS,
        requestBody: SHOW_LOGS,
      ));

    dioSix.interceptors
      ..add(InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          options.headers.addAll({
            "content-type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer " +
                await (_localService!.getToken() as FutureOr<String>),
          });
           return handler.next(options);
        },
      ))
      ..add(LogInterceptor(
        responseBody: SHOW_LOGS,
        requestBody: SHOW_LOGS,
      ));

    dioSeven.interceptors
      ..add(InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          options.headers.addAll({
            "content-type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer " +
                await (_localService!.getToken() as FutureOr<String>),
          });
           return handler.next(options);
        },
      ))
      ..add(LogInterceptor(
        responseBody: SHOW_LOGS,
        requestBody: SHOW_LOGS,
      ));

    dioEight.interceptors
      ..add(InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          options.headers.addAll({
            "content-type": "application/json",
            "Accept": "application/json",
            "Authorization": "bearer " + token,
          });
          // var check = await _localService.getToken();
          // log('interceptor $check');
           return handler.next(options);
        },
      ))
      ..add(LogInterceptor(
        responseBody: SHOW_LOGS,
        requestBody: SHOW_LOGS,
      ));

    dioNine.interceptors
      ..add(InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          options.headers.addAll({
            "content-type": "application/json",
            "Accept": "application/json",
            "Authorization": "bearer " +
                await (_localService!.getToken() as FutureOr<String>),
          });

           return handler.next(options);
        },
      ))
      ..add(LogInterceptor(
        responseBody: SHOW_LOGS,
        requestBody: SHOW_LOGS,
      ));

    dioTen.interceptors
      ..add(InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          options.headers.addAll({
            "content-type": "application/json",
            "Accept": "application/json",
            "Authorization": "bearer " + token,
          });

           return handler.next(options);
        },
      ))
      ..add(LogInterceptor(
        responseBody: SHOW_LOGS,
        requestBody: SHOW_LOGS,
      ));

    client = RestClient(dio, baseUrl: AppConfig.instance!.baseUrl!);
    clientOne = RestClient(dioOne, baseUrl: _baseUrlOne);
    clientTwo = RestClient(dioTwo, baseUrl: _baseUrlTwo);
    clientThree = RestClient(dioThree, baseUrl: _baseUrlService);
    clientFour = RestClient(dioFour, baseUrl: _baseUrlFour);
    clientFive = RestClient(dioFive, baseUrl: _baseUrlFive);
    clientSix = RestClient(dioSix, baseUrl: _baseUrlSix);
    clientSeven = RestClient(dioSeven, baseUrl: _baseUrlSeven);
    clientEight = RestClient(dioEight, baseUrl: _baseUrlEight);
    clientNine = RestClient(dioNine, baseUrl: _baseUrlSix);
    clientTen = RestClient(dioTen, baseUrl: _baseUrlEight);
  }

  static final HttpWrapper _singleton = HttpWrapper._internal();

  factory HttpWrapper() => _singleton;
}

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

  RestClient getClientSeven() {
    return httpWrapper.clientSeven;
  }

  RestClient getClientEight() {
    return httpWrapper.clientEight;
  }

  RestClient getClientNine() {
    return httpWrapper.clientNine;
  }

  RestClient getClientTen() {
    return httpWrapper.clientTen;
  }
}

class HttpWrapper {
  String token =
      " eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6IjEifQ.eyJpc3MiOiJodHRwczovL3N0YWdlLmlkLnRyaW1ibGVjbG91ZC5jb20iLCJleHAiOjE2MzgyNDQ0MzUsIm5iZiI6MTYzODI0MDgzNSwiaWF0IjoxNjM4MjQwODM1LCJqdGkiOiJjODgyMjRlYjJhOTg0ZTAxOTY1NzExMjUzZDljZDEwNCIsImp3dF92ZXIiOjIsInN1YiI6ImQ4ZjA4MGEzLTZmZDEtNDUzNi1iMmVkLWI0MTk5MTg4ZjNlNCIsImlkZW50aXR5X3R5cGUiOiJ1c2VyIiwiYW1yIjpbInBhc3N3b3JkIl0sImF1dGhfdGltZSI6MTYzODI0MDgzNCwiYXpwIjoiN2JlNzU5YjEtYWZjNS00YTRhLThhODYtYmRhNWUwNDVhNTA4IiwiYXVkIjpbIjdiZTc1OWIxLWFmYzUtNGE0YS04YTg2LWJkYTVlMDQ1YTUwOCJdLCJzY29wZSI6Ik9TRy1GUkFNRS1BUFAtU1RBR0UifQ.c-faKHG9pRh519dEXz4ao7YnAYTqlkCAawQs_nv4qAq7Czw7TlwXB6wTzGAWAuv0cO39q_IjNupkPcU20okYnB9CyTrX9MbhWFFE6pMsft9S9SXEFDRy07-D2FTexYuZHHZRwHkUeoPHVka1aMMWMgxKc9IcZVvyA3DLqXKorqgEaKC8L-e46h0d5x9_PS65h9B_TWwXl11KoZo4sKAop6SRN-EFQC3YAbozui9NawXyTGKskNy8esIcWOc4GxNDlqqfV3HTserTf_Xg5E1YtdyyCLM12XhxtRDxilxbZ0TlzHXQRzempzbkGZEzFS6LT7AUXyWaUfQFYKrxQbSBpA";

  final String _baseUrlService = "https://unifiedservice.myvisionlink.com";
  final String _baseUrlOne = "https://identity.trimble.com";
  final String _baseUrlTwo = "https://singlesearch.alk.com";
  final String _baseUrlFour = "https://api.trimble.com";
  final String _baseUrlFive = "https://id.trimble.com";
  final String _baseUrlSix = "https://cloud.api.trimble.com";
  final String _baseUrlSeven = "https://administrator.myvisionlink.com";
  final String _baseUrlEight = "https://cloud.stage.api.trimblecloud.com/";

  final bool SHOW_LOGS = true;
  final _localService = locator<LocalService>();

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

    dioSeven.interceptors
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

    dioEight.interceptors
      ..add(InterceptorsWrapper(
        onRequest: (Options options) async {
          options.headers.addAll({
            "content-type": "application/json",
            "Accept": "application/json",
            "Authorization": "bearer " + token,
          });
          // var check = await _localService.getToken();
          // log('interceptor $check');
          return options;
        },
      ))
      ..add(LogInterceptor(
        responseBody: SHOW_LOGS,
        requestBody: SHOW_LOGS,
      ));

    dioNine.interceptors
      ..add(InterceptorsWrapper(
        onRequest: (Options options) async {
          options.headers.addAll({
            "content-type": "application/json",
            "Accept": "application/json",
            "Authorization": "bearer " + await _localService.getToken(),
          });

          return options;
        },
      ))
      ..add(LogInterceptor(
        responseBody: SHOW_LOGS,
        requestBody: SHOW_LOGS,
      ));

    dioTen.interceptors
      ..add(InterceptorsWrapper(
        onRequest: (Options options) async {
          options.headers.addAll({
            "content-type": "application/json",
            "Accept": "application/json",
            "Authorization": "bearer " + token,
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
    clientSeven = RestClient(dioSeven, baseUrl: _baseUrlSeven);
    clientEight = RestClient(dioEight, baseUrl: _baseUrlEight);
    clientNine = RestClient(dioNine, baseUrl: _baseUrlSix);
    clientTen = RestClient(dioTen, baseUrl: _baseUrlEight);
  }

  static final HttpWrapper _singleton = HttpWrapper._internal();

  factory HttpWrapper() => _singleton;
}

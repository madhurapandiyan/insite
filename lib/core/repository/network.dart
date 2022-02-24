import 'dart:async';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'package:insite/core/flavor/flavor.dart';
import 'package:insite/core/models/login_response.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/login_service.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/splash/india_stack_splash_view.dart';
import 'package:logger/logger.dart';
import 'package:random_string/random_string.dart';
import 'package:stacked_services/stacked_services.dart' as service;
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
  service.SnackbarService? snackbarService = locator<service.SnackbarService>();
  service.NavigationService? navigationService =
      locator<service.NavigationService>();
  String codeVerifier = randomAlphaNumeric(43);
  static String _createCodeVerifier() {
    // return List.generate(
    //     128, (i) => _charset[Random.secure().nextInt(_charset.length)]).join();
    return randomAlphaNumeric(43);
  }

  String? codeChallenge;
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
  final LoginService? _loginService = locator<LoginService>();
  //final NavigationService? _navigationService = locator<NavigationService>();

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

  Future<Response<dynamic>> dioRetryInterceptor(
      RequestOptions requestOption) async {
    Logger().i(requestOption.baseUrl);
    Logger().i(requestOption.path);
    final options = Options(
        method: requestOption.method,
        headers: requestOption.headers,
        extra: requestOption.extra);
    return dio.request(requestOption.baseUrl + requestOption.path,
        data: requestOption.data,
        queryParameters: requestOption.queryParameters,
        options: options);
  }

  Future<Response<dynamic>> dioOneRetryInterceptor(
      RequestOptions requestOption) async {
    Logger().i(requestOption.baseUrl);
    Logger().i(requestOption.path);
    final options = Options(
        method: requestOption.method,
        headers: requestOption.headers,
        extra: requestOption.extra);
    return dioOne.request(requestOption.baseUrl + requestOption.path,
        data: requestOption.data,
        queryParameters: requestOption.queryParameters,
        options: options);
  }

  Future<Response<dynamic>> dioTwoRetryInterceptor(
      RequestOptions requestOption) async {
    Logger().i(requestOption.baseUrl);
    Logger().i(requestOption.path);
    final options = Options(
        method: requestOption.method,
        headers: requestOption.headers,
        extra: requestOption.extra);
    return dioTwo.request(requestOption.baseUrl + requestOption.path,
        data: requestOption.data,
        queryParameters: requestOption.queryParameters,
        options: options);
  }

  Future<Response<dynamic>> dioThreeRetryInterceptor(
      RequestOptions requestOption) async {
    Logger().i(requestOption.baseUrl);
    Logger().i(requestOption.path);
    final options = Options(
        method: requestOption.method,
        headers: requestOption.headers,
        extra: requestOption.extra);
    return dioTwo.request(requestOption.baseUrl + requestOption.path,
        data: requestOption.data,
        queryParameters: requestOption.queryParameters,
        options: options);
  }

  Future<Response<dynamic>> dioFourRetryInterceptor(
      RequestOptions requestOption) async {
    Logger().i(requestOption.baseUrl);
    Logger().i(requestOption.path);
    final options = Options(
        method: requestOption.method,
        headers: requestOption.headers,
        extra: requestOption.extra);
    return dioTwo.request(requestOption.baseUrl + requestOption.path,
        data: requestOption.data,
        queryParameters: requestOption.queryParameters,
        options: options);
  }

  Future<Response<dynamic>> dioFiveRetryInterceptor(
      RequestOptions requestOption) async {
    Logger().i(requestOption.baseUrl);
    Logger().i(requestOption.path);
    final options = Options(
        method: requestOption.method,
        headers: requestOption.headers,
        extra: requestOption.extra);
    return dioTwo.request(requestOption.baseUrl + requestOption.path,
        data: requestOption.data,
        queryParameters: requestOption.queryParameters,
        options: options);
  }

  dioSixRetryInterceptor(RequestOptions requestOption) async {
    Logger().i(requestOption.baseUrl);
    Logger().i(requestOption.path);
    final options = Options(
        method: requestOption.method,
        headers: requestOption.headers,
        extra: requestOption.extra);

    return dioTwo.request(requestOption.baseUrl + requestOption.path,
        data: requestOption.data,
        queryParameters: requestOption.queryParameters,
        options: options);
  }

  Future<Response<dynamic>> dioSevenRetryInterceptor(
      RequestOptions requestOption) async {
    Logger().i(requestOption.baseUrl);
    Logger().i(requestOption.path);
    final options = Options(
        method: requestOption.method,
        headers: requestOption.headers,
        extra: requestOption.extra);
    return dioTwo.request(requestOption.baseUrl + requestOption.path,
        data: requestOption.data,
        queryParameters: requestOption.queryParameters,
        options: options);
  }

  Future<Response<dynamic>> dioEightRetryInterceptor(
      RequestOptions requestOption) async {
    Logger().i(requestOption.baseUrl);
    Logger().i(requestOption.path);
    final options = Options(
        method: requestOption.method,
        headers: requestOption.headers,
        extra: requestOption.extra);
    return dioTwo.request(requestOption.baseUrl + requestOption.path,
        data: requestOption.data,
        queryParameters: requestOption.queryParameters,
        options: options);
  }

  dioNineRetryInterceptor(RequestOptions requestOption) async {
    Logger().i(requestOption.baseUrl);
    Logger().i(requestOption.path);
    Logger().i(requestOption.baseUrl);
    Logger().i(requestOption.path);
    final options = Options(
        method: requestOption.method,
        contentType: requestOption.contentType,
        headers: requestOption.headers,
        extra: requestOption.extra);

    return dioNine.request(requestOption.baseUrl + requestOption.path,
        data: requestOption.data,
        queryParameters: requestOption.queryParameters,
        options: options);
  }

  Future<Response<dynamic>> dioTenRetryInterceptor(
      RequestOptions requestOption) async {
    Logger().i(requestOption.baseUrl);
    Logger().i(requestOption.path);
    final options = Options(
        method: requestOption.method,
        headers: requestOption.headers,
        extra: requestOption.extra);
    return dioTwo.request(requestOption.baseUrl + requestOption.path,
        data: requestOption.data,
        queryParameters: requestOption.queryParameters,
        options: options);
  }

  Future<LoginResponse?> refreshToken() async {
    var currentCodeVerifier = await _localService!.getCodeVerifier();
    var refreshToken = await _localService!.getRefreshToken();
    codeChallenge = Utils.generateCodeChallenge(_createCodeVerifier(), true);
    Logger().e("code verifier $currentCodeVerifier");
    Logger().i("refresh token $refreshToken");
    Logger().w("code challenge $codeChallenge");
    LoginResponse? result = await _loginService!.getRefreshLoginDataV4(
        code_challenge: codeChallenge,
        code_verifier: currentCodeVerifier,
        token: refreshToken);
    return result;
  }

  HttpWrapper._internal() {
    BaseOptions options = new BaseOptions(
      baseUrl: AppConfig.instance!.baseUrl,
      connectTimeout: 60000,
      receiveTimeout: 60000,
    );
    dio = Dio(options);
    dioOne = Dio(options);

    var cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
    dioOne.interceptors.add(CookieManager(cookieJar));

    dio.interceptors
      ..add(InterceptorsWrapper(
        onResponse: (responce, handler) {
          return handler.next(responce);
        },
        onError: (DioError error,
            ErrorInterceptorHandler errorInterceptorHandler) async {
          dio.interceptors.requestLock;
          if (error.response?.statusCode == 401) {
            snackbarService!
                .showSnackbar(message: "Session Expired Please Try Again");
            navigationService!
                .navigateToView(IndiaStackSplashView(showingSnackbar: true));
            return errorInterceptorHandler.next(error);
            // var refreshLoginResponce = await refreshToken();
            // if (refreshLoginResponce != null) {
            //   await _localService!.saveTokenInfo(refreshLoginResponce);
            //   await _localService!.saveToken(refreshLoginResponce.access_token);
            //   await _localService!
            //       .saveRefreshToken(refreshLoginResponce.refresh_token);
            //   return errorInterceptorHandler
            //       .resolve(await dioRetryInterceptor(error.requestOptions));

            // await _loginService!.saveToken(
            //     result.access_token, result.expires_in.toString(), false);
            // }
          } else {
            return errorInterceptorHandler.next(error);
          }
        },
        //   if (error.response?.statusCode == 401) {
        //     var code = await _localService!.getAuthCode();
        //     var token = await _localService!.getRefreshToken();
        //     codeChallenge = Utils.generateCodeChallenge(_createCodeVerifier());
        //     LoginResponse? result = await _loginService!.getRefreshLoginDataV4(
        //         code: code,
        //         code_challenge: codeChallenge,
        //         code_verifier: codeVerifier,
        //         token: token);
        //     if (result != null) {
        //       await _localService!.saveTokenInfo(result);
        //       await _localService!.saveRefreshToken(result.refresh_token);
        //       await _localService!.saveAuthCode(code);
        //       await _loginService!.saveToken(
        //           result.access_token, result.expires_in.toString(), false);
        //     }
        //     return errorInterceptorHandler.next(error);
        //   }
        // },
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          options.headers.addAll({
            "content-type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer " + await _localService!.getToken(),
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
        onError: (DioError error,
            ErrorInterceptorHandler errorInterceptorHandler) async {
          if (error.response?.statusCode == 401) {
            snackbarService!
                .showSnackbar(message: "Session Expired Please Try Again");
            navigationService!
                .navigateToView(IndiaStackSplashView(showingSnackbar: true));
            return errorInterceptorHandler.next(error);
            // var refreshLoginResponce = await refreshToken();
            // if (refreshLoginResponce != null) {
            //   await _localService!.saveTokenInfo(refreshLoginResponce);
            //   await _localService!.saveToken(refreshLoginResponce.access_token);
            //   await _localService!
            //       .saveRefreshToken(refreshLoginResponce.refresh_token);
            //   return errorInterceptorHandler
            //       .resolve(await dioOneRetryInterceptor(error.requestOptions));
            // }
          } else {
            return errorInterceptorHandler.next(error);
          }
        },
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
        onError: (DioError error,
            ErrorInterceptorHandler errorInterceptorHandler) async {
          if (error.response?.statusCode == 401) {
            snackbarService!
                .showSnackbar(message: "Session Expired Please Try Again");
            navigationService!
                .navigateToView(IndiaStackSplashView(showingSnackbar: true));
            return errorInterceptorHandler.next(error);
            // var refreshLoginResponce = await refreshToken();
            // if (refreshLoginResponce != null) {
            //   await _localService!.saveTokenInfo(refreshLoginResponce);
            //   await _localService!.saveToken(refreshLoginResponce.access_token);
            //   await _localService!
            //       .saveRefreshToken(refreshLoginResponce.refresh_token);
            //   return errorInterceptorHandler
            //       .resolve(await dioTwoRetryInterceptor(error.requestOptions));
            // }
          } else {
            return errorInterceptorHandler.next(error);
          }
        },
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
        onError: (DioError error,
            ErrorInterceptorHandler errorInterceptorHandler) async {
          if (error.response?.statusCode == 401) {
            snackbarService!
                .showSnackbar(message: "Session Expired Please Try Again");
            navigationService!
                .navigateToView(IndiaStackSplashView(showingSnackbar: true));
            return errorInterceptorHandler.next(error);
            // var refreshLoginResponce = await refreshToken();
            // if (refreshLoginResponce != null) {
            //   await _localService!.saveTokenInfo(refreshLoginResponce);
            //   await _localService!.saveToken(refreshLoginResponce.access_token);
            //   await _localService!
            //       .saveRefreshToken(refreshLoginResponce.refresh_token);
            //   return errorInterceptorHandler.resolve(
            //       await dioThreeRetryInterceptor(error.requestOptions));
            // }
          } else {
            return errorInterceptorHandler.next(error);
          }
        },
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          options.headers.addAll({
            "content-type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer " + await _localService!.getToken(),
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
        onError: (DioError error,
            ErrorInterceptorHandler errorInterceptorHandler) async {
          if (error.response?.statusCode == 401) {
            snackbarService!
                .showSnackbar(message: "Session Expired Please Try Again");
            navigationService!
                .navigateToView(IndiaStackSplashView(showingSnackbar: true));
            return errorInterceptorHandler.next(error);
            // var refreshLoginResponce = await refreshToken();
            // if (refreshLoginResponce != null) {
            //   await _localService!.saveTokenInfo(refreshLoginResponce);
            //   await _localService!.saveToken(refreshLoginResponce.access_token);
            //   await _localService!
            //       .saveRefreshToken(refreshLoginResponce.refresh_token);
            //   return errorInterceptorHandler
            //       .resolve(await dioFourRetryInterceptor(error.requestOptions));
            // }
          } else {
            return errorInterceptorHandler.next(error);
          }
        },
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          options.headers.addAll({
            "content-type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer " + await _localService!.getToken(),
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
        onError: (DioError error,
            ErrorInterceptorHandler errorInterceptorHandler) async {
          if (error.response?.statusCode == 401) {
            snackbarService!
                .showSnackbar(message: "Session Expired Please Try Again");
            navigationService!
                .navigateToView(IndiaStackSplashView(showingSnackbar: true));
            return errorInterceptorHandler.next(error);
            // var refreshLoginResponce = await refreshToken();
            // if (refreshLoginResponce != null) {
            //   await _localService!.saveTokenInfo(refreshLoginResponce);
            //   await _localService!.saveToken(refreshLoginResponce.access_token);
            //   await _localService!
            //       .saveRefreshToken(refreshLoginResponce.refresh_token);
            //   return errorInterceptorHandler
            //       .resolve(await dioFiveRetryInterceptor(error.requestOptions));
            // }
          } else {
            return errorInterceptorHandler.next(error);
          }
        },
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
        onError: (DioError error,
            ErrorInterceptorHandler errorInterceptorHandler) async {
          if (error.response?.statusCode == 401) {
            snackbarService!
                .showSnackbar(message: "Session Expired Please Try Again");
            navigationService!
                .navigateToView(IndiaStackSplashView(showingSnackbar: true));
            return errorInterceptorHandler.next(error);
            // var refreshLoginResponce = await refreshToken();
            // if (refreshLoginResponce != null) {
            //   await _localService!.saveTokenInfo(refreshLoginResponce);
            //   await _localService!.saveToken(refreshLoginResponce.access_token);
            //   await _localService!
            //       .saveRefreshToken(refreshLoginResponce.refresh_token);
            //   return errorInterceptorHandler
            //       .resolve(await dioSixRetryInterceptor(error.requestOptions));
            // }
          } else {
            return errorInterceptorHandler.next(error);
          }
        },
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          options.headers.addAll({
            "content-type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer " + await _localService!.getToken(),
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
        onError: (DioError error,
            ErrorInterceptorHandler errorInterceptorHandler) async {
          if (error.response?.statusCode == 401) {
            snackbarService!
                .showSnackbar(message: "Session Expired Please Try Again");
            navigationService!
                .navigateToView(IndiaStackSplashView(showingSnackbar: true));
            return errorInterceptorHandler.next(error);
            // var refreshLoginResponce = await refreshToken();
            // if (refreshLoginResponce != null) {
            //   await _localService!.saveTokenInfo(refreshLoginResponce);
            //   await _localService!.saveToken(refreshLoginResponce.access_token);
            //   await _localService!
            //       .saveRefreshToken(refreshLoginResponce.refresh_token);
            //   return errorInterceptorHandler.resolve(
            //       await dioSevenRetryInterceptor(error.requestOptions));
            // }
          } else {
            return errorInterceptorHandler.next(error);
          }
        },
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          options.headers.addAll({
            "content-type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer " + await _localService!.getToken()
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
        onError: (DioError error,
            ErrorInterceptorHandler errorInterceptorHandler) async {
          if (error.response?.statusCode == 401) {
            snackbarService!
                .showSnackbar(message: "Session Expired Please Try Again");
            navigationService!
                .navigateToView(IndiaStackSplashView(showingSnackbar: true));
            return errorInterceptorHandler.next(error);
            // var refreshLoginResponce = await refreshToken();
            // if (refreshLoginResponce != null) {
            //   await _localService!.saveTokenInfo(refreshLoginResponce);
            //   await _localService!.saveToken(refreshLoginResponce.access_token);
            //   await _localService!
            //       .saveRefreshToken(refreshLoginResponce.refresh_token);
            //   return errorInterceptorHandler.resolve(
            //       await dioEightRetryInterceptor(error.requestOptions));
            // }
          } else {
            return errorInterceptorHandler.next(error);
          }
        },
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          options.headers.addAll({
            "content-type": "application/json",
            "Accept": "application/json",
            "Authorization": "bearer " + await _localService!.getToken(),
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
        onError: (DioError error,
            ErrorInterceptorHandler errorInterceptorHandler) async {
          if (error.response?.statusCode == 401) {
            snackbarService!
                .showSnackbar(message: "Session Expired Please Try Again");
            navigationService!
                .navigateToView(IndiaStackSplashView(showingSnackbar: true));
            return errorInterceptorHandler.next(error);
            // var refreshLoginResponce = await refreshToken();
            // if (refreshLoginResponce != null) {
            //   await _localService!.saveTokenInfo(refreshLoginResponce);
            //   await _localService!.saveToken(refreshLoginResponce.access_token);
            //   await _localService!
            //       .saveRefreshToken(refreshLoginResponce.refresh_token);
            //   return errorInterceptorHandler
            //       .resolve(await dioNineRetryInterceptor(error.requestOptions));
            // }
          } else {
            return errorInterceptorHandler.next(error);
          }
        },
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          options.headers.addAll({
            "content-type": "application/json",
            "Accept": "application/json",
            "Authorization": "bearer " + await _localService!.getToken()
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
        onError: (DioError error,
            ErrorInterceptorHandler errorInterceptorHandler) async {
          if (error.response?.statusCode == 401) {
            snackbarService!
                .showSnackbar(message: "Session Expired Please Try Again");
            navigationService!
                .navigateToView(IndiaStackSplashView(showingSnackbar: true));
            return errorInterceptorHandler.next(error);
            // var refreshLoginResponce = await refreshToken();
            // if (refreshLoginResponce != null) {
            //   await _localService!.saveTokenInfo(refreshLoginResponce);
            //   await _localService!.saveToken(refreshLoginResponce.access_token);
            //   await _localService!
            //       .saveRefreshToken(refreshLoginResponce.refresh_token);
            //   return errorInterceptorHandler
            //       .resolve(await dioNineRetryInterceptor(error.requestOptions));
            // }
          } else {
            return errorInterceptorHandler.next(error);
          }
        },
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          options.headers.addAll({
            "content-type": "application/json",
            "Accept": "application/json",
            "Authorization": "bearer " + await _localService!.getToken()
          });

          return handler.next(options);
        },
      ))
      ..add(LogInterceptor(
        responseBody: SHOW_LOGS,
        requestBody: SHOW_LOGS,
      ));

    client = RestClient(dio, baseUrl: AppConfig.instance!.baseUrl);
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

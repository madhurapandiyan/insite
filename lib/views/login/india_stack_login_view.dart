import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:insite/core/flavor/flavor.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/login_response.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/login_service.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/utils/urls.dart';
import 'package:insite/views/splash/india_stack_splash_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:logger/logger.dart';
import 'package:random_string/random_string.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'login_view_model.dart';
import 'package:insite/core/router_constants_india_stack.dart' as indiaStack;

class IndiaStackLoginView extends StatefulWidget {
  final LoginResponse? arguments;
  IndiaStackLoginView({this.arguments});
  @override
  _IndiaStackLoginViewState createState() => _IndiaStackLoginViewState();
}

class LoginArguments {
  final LoginResponse? response;
  LoginArguments({this.response});
}

class _IndiaStackLoginViewState extends State<IndiaStackLoginView> {
  StreamSubscription? _onDestroy;
  StreamSubscription<String>? _onUrlChanged;
  StreamSubscription<WebViewStateChanged>? _onStateChanged;
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  bool isLoading = false;
  NavigationService? _navigationService = locator<NavigationService>();
  final LocalService? _localService = locator<LocalService>();
  final LoginService? _loginService = locator<LoginService>();

  bool receivedToken = false;
  LoginResponse? loginResponse;
  String codeVerifier = randomAlphaNumeric(43);
  String state = randomAlphaNumeric(43);
  String? codeChallenge;

  static const String _charset =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~';

  static String _createCodeVerifier() {
    // return List.generate(
    //     128, (i) => _charset[Random.secure().nextInt(_charset.length)]).join();
    return randomAlphaNumeric(43);
  }

  @override
  void dispose() {
    _onDestroy?.cancel();
    _onUrlChanged?.cancel();
    _onStateChanged?.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  void initState() {
    loginResponse = widget.arguments;
    print(Urls.getV4LogoutUrl(
        loginResponse?.id_token, Urls.tataHitachiLogoutUrl));
    Logger().d(
        "IndiaStackLoginView pkce logout url ${Urls.getV4LogoutUrl(loginResponse!.id_token, Urls.tataHitachiLogoutUrl)}");
    Logger().d("IndiaStackLoginView codeVerifier $codeVerifier");
    codeChallenge = Utils.generateCodeChallenge(codeVerifier, false);
    Logger().d("IndiaStackLoginView codeChallenge $codeChallenge");
    Logger().d("IndiaStackLoginView state $state");
    Logger().d(
        "IndiaStackLoginView pkce login url ${Urls.getV4LoginUrl(state, codeChallenge)}");
    super.initState();
    // flutterWebviewPlugin.close();

    // Add a listener to on destroy WebView, so you can make came actions.
    // _onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {
    //   Logger().i("IndiaStackLoginView destroy");
    // } as void Function(Null)?);

    _onStateChanged =
        flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      print("IndiaStackLoginView onStateChanged: ${state.type} ${state.url}");
      if (state.url.startsWith(Urls.idTokenBaseUrl +
          "/oauth/authorize?response_type=code&client_id=${Urls.indiaStackClientId}")) {
        print(
            "IndiaStackLoginView STATE changed with logout redirect : ${state.url}");
        try {
          // Future.delayed(Duration(seconds: 2), () {
          // flutterWebviewPlugin.cleanCookies();
          // flutterWebviewPlugin.clearCache();
          Logger().d(
              "IndiaStackLoginView pkce login url launch state ${Urls.getV4LoginUrl(state, codeChallenge)}");
          // flutterWebviewPlugin.launch(Urls.getV4LoginUrl(state, codeChallenge));
          gotoSplashview();
          // _navigationService.replaceWith(logoutViewRoute);
          // _navigationService.pushNamedAndRemoveUntil(logoutViewRoute,
          //     predicate: (Route<dynamic> route) => false);
          // });
          // flutterWebviewPlugin.close();
        } catch (e) {
          Logger().e(e);
        }
      } else if (state.url.startsWith(Urls.tataHitachiRedirectUri + "?code=")) {
        Logger().i(
            "IndiaStackLoginView State URL changed with access token: $state.url");
        try {
          List<String> list = state.url.split("=");
          Logger().i("IndiaStackLoginView url split list $list");
          if (list.isNotEmpty) {
            // _onUrlChanged.cancel();
            //for vision link (oauth style login)
            // String accessTokenString = list[1];
            // String expiresTokenString = list[3];
            // List<String> accessTokenList = accessTokenString.split("&");
            // List<String> expiryList = expiresTokenString.split("&");
            // print("accessToken split list $list");
            // String accessToken = accessTokenList[0];
            // String expiryTime = expiryList[0];
            // print("accessToken $accessToken");
            // print("expiryTime $expiryTime");
            // saveToken(accessToken, expiryTime);

            // String codeString = list[1];
            // List<String> codeStringList = codeString.split("&");
            // if (codeStringList.isNotEmpty && !receivedToken) {
            //   receivedToken = true;
            //   getLoginDataV4(
            //     codeStringList[0],
            //   );
            // }
          }
          flutterWebviewPlugin.close();
        } catch (e) {
          Logger().e(e);
        }
      }
    });

    // Add a listener to on url changed
    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        Logger().i("IndiaStackLoginView URL changed: $url");
        Logger().w(url.startsWith(Urls.tataHitachiLogoutUrl + "?code="));
        if (url.isNotEmpty &&
            url.startsWith(AppConfig.instance!.apiFlavor == "visionlink"
                ? Urls.administratorBaseUrl + "/?code="
                : Urls.tataHitachiLogoutUrl )) {
          try {
            gotoSplashview();
            // List<String> list = url.split("=");
            // Logger().i("IndiaStackLoginView url split list $list");
            // if (list.isNotEmpty) {
            //   _onUrlChanged!.cancel();
            //   gotoSplashview();
              //for vision link (oauth style login)
              // String accessTokenString = list[1];
              // String expiresTokenString = list[2];
              // List<String> accessTokenList = accessTokenString.split("&");
              // List<String> expiryList = expiresTokenString.split("&");
              // print("accessToken split list $list");
              // String accessToken = accessTokenList[0];
              // String expiryTime = expiryList[0];
              // print("accessToken $accessToken");
              // print("expiryTime $expiryTime");
              // saveToken(accessToken, expiryTime);

              // String codeString = list[1];
              // List<String> codeStringList = codeString.split("&");
              // if (codeStringList.isNotEmpty) {
              //   getLoginDataV4(
              //     codeStringList[0],
              //   );
              // }
           // }
            flutterWebviewPlugin.close();
          } catch (e) {
            Logger().e(e.toString());
          }
        } else if (url
            .startsWith(Urls.idTokenBaseUrl + "/oauth/logout?id_token_hint")) {
          Logger()
              .i("IndiaStackLoginView URL changed with logout redirect: $url");
          // Future.delayed(Duration(seconds: 2), () {
          // flutterWebviewPlugin.cleanCookies();
          // flutterWebviewPlugin.clearCache();
          Logger().d(
              "IndiaStackLoginView pkce login url launch URL ${Urls.getV4LoginUrl(state, codeChallenge)}");
          // flutterWebviewPlugin.launch(Urls.getV4LoginUrl(state, codeChallenge));
          //gotoSplashview();
          // _navigationService.replaceWith(logoutViewRoute);
          // _navigationService.pushNamedAndRemoveUntil(logoutViewRoute,
          //     predicate: (Route<dynamic> route) => false);
          // });
          // flutterWebviewPlugin.close();
        } else if (url.startsWith(Urls.tataHitachiRedirectUri + "?code=")) {
          Logger().i("IndiaStackLoginView URL changed with access token: $url");
          try {
            List<String> list = url.split("=");
            Logger().i("IndiaStackLoginView url split list $list");
            if (list.isNotEmpty) {
              _onUrlChanged!.cancel();
              //for vision link (oauth style login)
              // String accessTokenString = list[1];
              // String expiresTokenString = list[3];
              // List<String> accessTokenList = accessTokenString.split("&");
              // List<String> expiryList = expiresTokenString.split("&");
              // print("accessToken split list $list");
              // String accessToken = accessTokenList[0];
              // String expiryTime = expiryList[0];
              // print("accessToken $accessToken");
              // print("expiryTime $expiryTime");
              // saveToken(accessToken, expiryTime);

              String codeString = list[1];
              List<String> codeStringList = codeString.split("&");
              if (codeStringList.isNotEmpty) {
                getLoginDataV4(
                  codeStringList[0],
                );
              }
            }
            flutterWebviewPlugin.close();
          } catch (e) {
            Logger().e(e);
          }
        }
      }
    });
  }

  gotoSplashview() {
    Logger().i("IndiaStackLoginView gotoSplashview");
    // PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
    //   Logger().i("IndiaStackLoginView packageInfo ${packageInfo.packageName}");
    //   if (packageInfo.packageName == "com.trimble.insite.indiastack") {
    //     // _navigationService.pushNamedAndRemoveUntil(indiaStack.indiaStackLogoutViewRoute,
    //     //     predicate: (Route<dynamic> route) => false);
    //     _navigationService.navigateTo(indiaStack.indiaStackLogoutViewRoute);
    //   } else {
    //     _navigationService.replaceWith(splashViewRoute);
    //   }
    // });
    if (AppConfig.instance!.apiFlavor == "indiastack") {
      _navigationService!.clearTillFirstAndShowView(IndiaStackSplashView(showingSnackbar: false));
    } else {
      _navigationService!.navigateTo(indiaStack.indiaStackLogoutViewRoute);
    }
  }

  saveToken(token, String expiryTime) {
    Logger().i("IndiaStackLoginView saveToken from webview");
    _loginService!.getUser(token, true);
    _loginService!.saveExpiryTime(expiryTime);
  }

  getLoginDataV4(code) async {
    Logger().i("IndiaStackLoginView getLoginDataV4 for code $code");
    codeChallenge = Utils.generateCodeChallenge(_createCodeVerifier(), false);
    LoginResponse? result =
        await _loginService!.getLoginDataV4(code, codeChallenge, codeVerifier);
    if (result != null) {
      await _localService!.saveTokenInfo(result);
      await _loginService!
          .saveToken(result.access_token, result.expires_in.toString(), false);
    } else {
      receivedToken = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (BuildContext context, LoginViewModel viewModel, Widget? _) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                WebviewScaffold(
                  url: AppConfig.instance!.apiFlavor == "visionlink"
                      ? Uri.encodeFull(
                          Urls.logoutUrlVl(loginResponse!.id_token))
                      : Uri.encodeFull(Urls.getV4LogoutUrl(
                          loginResponse!.id_token, Urls.tataHitachiLogoutUrl)),
                ),
                isLoading ? InsiteProgressBar() : SizedBox()
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}

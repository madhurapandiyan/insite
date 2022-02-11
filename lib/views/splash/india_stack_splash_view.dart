import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:insite/core/flavor/flavor.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/login_response.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/login_service.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/utils/urls.dart';
import 'package:logger/logger.dart';
import 'package:random_string/random_string.dart';
import 'package:stacked/stacked.dart';
import 'splash_view_model.dart';

class IndiaStackSplashView extends StatefulWidget {
  final bool showingSnackbar;
  IndiaStackSplashView({required this.showingSnackbar});
  @override
  _IndiaStackSplashViewState createState() => _IndiaStackSplashViewState();
}

class _IndiaStackSplashViewState extends State<IndiaStackSplashView> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  StreamSubscription? _onDestroy;
  StreamSubscription<String>? _onUrlChanged;
  StreamSubscription<WebViewStateChanged>? _onStateChanged;
  String? token;

  final _loginService = locator<LoginService>();
  final _localService = locator<LocalService>();

  @override
  void dispose() {
    Logger().i("IndiaStackSplashView dispose state");
    _onDestroy!.cancel();
    _onUrlChanged!.cancel();
    _onStateChanged!.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  bool isLoading = false;

  bool receivedToken = false;
  String codeVerifier = randomAlphaNumeric(43);
  String state = randomAlphaNumeric(43);
  String? codeChallenge;

  @override
  void initState() {
    Logger().d("IndiaStackSplashView codeVerifier $codeVerifier");
    codeChallenge = Utils.generateCodeChallenge(codeVerifier,false);
    Logger().d("IndiaStackSplashView codeChallenge $codeChallenge");
    Logger().d("IndiaStackSplashView state $state");
    if (AppConfig.instance!.apiFlavor == "visionlink") {
      Logger().d(
          "IndiaStackSplashView pkce login url ${Urls.getV4LoginUrlVL(state, codeChallenge)}");
    } else {
      Logger().d(
          "IndiaStackSplashView pkce login url ${Urls.getV4LoginUrl(state, codeChallenge)}");
    }

    super.initState();
    setupListeners();
  }

  static const String _charset =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~';

  static String _createCodeVerifier = randomAlphaNumeric(43);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(IndiaStackSplashView oldWidget) {
    print("IndiaStackSplashView didUpdateWidget called");
    super.didUpdateWidget(oldWidget);
  }

  setupListeners() {
    Logger().i("IndiaStackSplashView init state splash view");
    // flutterWebviewPlugin.close();

    // Add a listener to on destroy WebView, so you can make came actions.
    _onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {
      print("IndiaStackSplashView destroy");
    });

    _onStateChanged =
        flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      print(
          "IndiaStackSplashView STATE onStateChanged: ${state.type} ${state.url}");
      if (state.url.isNotEmpty &&
          state.url.startsWith(AppConfig.instance!.apiFlavor == "visionlink"
              ? Urls.administratorBaseUrl
              : Urls.tataHitachiRedirectUri + "?code=")) {
        print("IndiaStackSplashView STATE changed with auth code: $state.url");
        try {
          if (state.url.contains("=")) {
            List<String> list = state.url.split("=");
            print("IndiaStackSplashView STATE url split list $list");
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
              String codeString = list[1];
              List<String> codeStringList = codeString.split("&");
              if (codeStringList.isNotEmpty && !receivedToken) {
                receivedToken = true;
                getLoginDataV4(
                  codeStringList[0],
                );
              }
            }
          }
          flutterWebviewPlugin.close();
        } catch (e) {
          Logger().i("IndiaStackSplashView login exceptoion");
          Logger().e(e);
        }
      }
    });

    // Add a listener to on url changed
    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        print("IndiaStackSplashView URL changed: $url");
        Logger().wtf(url);
        if (url.isNotEmpty &&
            url.startsWith(AppConfig.instance!.apiFlavor == "visionlink"
                ? Urls.administratorBaseUrl + "/?code="
                : Urls.tataHitachiRedirectUri + "?code=")) {
          print("IndiaStackSplashView URL changed with auth code : $url");
          try {
            if (url.contains("=")) {
              List<String> list = url.split("=");
              print("IndiaStackSplashView URL url split list $list");
              if (list.isNotEmpty) {
                // _onUrlChanged!.cancel();
                // // for vision link (oauth style login)
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

                String codeString = list[1];
                List<String> codeStringList = codeString.split("&");
                if (codeStringList.isNotEmpty) {
                  getLoginDataV4(
                    codeStringList[0],
                  );
                }
              }
            }
            flutterWebviewPlugin.close();
          } catch (e) {
            Logger().i("IndiaStackSplashView login exceptoion");
            Logger().e(e);
          }
        }
      }
    });

    flutterWebviewPlugin.onHttpError.listen((event) {
      Logger().e(event);
    });
  }

  getLoginDataV4(code) async {
    Logger().i("IndiaStackSplashView getLoginDataV4 for code $code");
    codeChallenge = Utils.generateCodeChallenge(_createCodeVerifier,true);
    LoginResponse? result =
        await _loginService.getLoginDataV4(code, codeChallenge, codeVerifier);
    if (result != null) {
      await _localService.saveTokenInfo(result);
      await _localService.saveRefreshToken(result.refresh_token);
      await _loginService.saveToken(
          result.access_token, result.expires_in.toString(), false);
    }
  }

  saveToken(token, String expiryTime) {
    Logger().i("IndiaStackSplashView saveToken from webview");
    _loginService.getUser(token, false);
    _loginService.saveExpiryTime(expiryTime);
  }

  @override
  Widget build(BuildContext context) {
    Logger().d(AppConfig.instance!.apiFlavor);
    return ViewModelBuilder<SplashViewModel>.reactive(
      builder: (BuildContext context, SplashViewModel viewModel, Widget? _) {
        // setupListeners();
        return Scaffold(
          backgroundColor:widget.showingSnackbar?white: Theme.of(context).buttonColor,
          body: SafeArea(
            child: Stack(
              children: [
                viewModel.shouldLoadWebview &&
                        !AppConfig.instance!.enalbeNativeLogin
                    ? WebviewScaffold(
                        url: AppConfig.instance!.apiFlavor == "visionlink"
                            ? Uri.encodeFull(
                                Urls.getV4LoginUrlVL(state, codeChallenge))
                            : Uri.encodeFull(
                                Urls.getV4LoginUrl(state, codeChallenge)))
                    : SizedBox(),
                Center(
                  child: CircularProgressIndicator(
                    color:widget.showingSnackbar?Theme.of(context).buttonColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => SplashViewModel(),
    );
  }
}

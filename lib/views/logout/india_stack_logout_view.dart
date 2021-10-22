import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/login_response.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/login_service.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/utils/urls.dart';
import 'package:logger/logger.dart';
import 'package:random_string/random_string.dart';
import 'package:stacked/stacked.dart';
import 'logout_view_model.dart';

class IndiaStackLogoutView extends StatefulWidget {
  @override
  _IndiaStackLogoutViewState createState() => _IndiaStackLogoutViewState();
}

class _IndiaStackLogoutViewState extends State<IndiaStackLogoutView> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  StreamSubscription _onDestroy;
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;

  final _loginService = locator<LoginService>();
  final _localService = locator<LocalService>();

  @override
  void dispose() {
    Logger().i("IndiaStackLogoutView dispose state");
    _onDestroy.cancel();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  bool receivedToken = false;
  String codeVerifier = randomAlphaNumeric(43);
  String state = randomAlphaNumeric(43);
  String codeChallenge;

  @override
  void initState() {
    Logger().d("IndiaStackLogoutView  codeVerifier $codeVerifier");
    codeChallenge = Utils.generateCodeChallenge(codeVerifier);
    Logger().d("IndiaStackLogoutView  codeChallenge $codeChallenge");
    Logger().d("IndiaStackLogoutView  state $state");
    Logger().d(
        "IndiaStackLogoutView pkce login url ${Urls.getV4LoginUrl(state, codeChallenge)}");
    super.initState();
    setupListeners();
  }

  static const String _charset =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~';

  static String _createCodeVerifier() {
    // return List.generate(
    //     128, (i) => _charset[Random.secure().nextInt(_charset.length)]).join();
    return randomAlphaNumeric(43);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(IndiaStackLogoutView oldWidget) {
    Logger().i("IndiaStackLogoutView  didUpdateWidget called");
    super.didUpdateWidget(oldWidget);
  }

  setupListeners() {
    Logger().i("IndiaStackLogoutView  init logout logout view");
    // flutterWebviewPlugin.close();

    // Add a listener to on destroy WebView, so you can make came actions.
    _onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {
      Logger().i("IndiaStackLogoutView destroy");
    });

    _onStateChanged =
        flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      Logger()
          .i("IndiaStackLogoutView onStateChanged: ${state.type} ${state.url}");
      Logger()
          .i("IndiaStackLogoutView onStateChanged: ${state.type} ${state.url}");
      if (state.url != null &&
          state.url.startsWith(Urls.tataHitachiRedirectUri + "?code=")) {
        Logger()
            .i("IndiaStackLogoutView STATE changed with auth code: $state.url");
        try {
          if (state.url.contains("=")) {
            List<String> list = state.url.split("=");
            Logger().i("IndiaStackLogoutView url split list $list");
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
          Logger().i("IndiaStackLogoutView login exceptoion");
          Logger().e(e);
        }
      }
    });

    // Add a listener to on url changed
    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        Logger().i("IndiaStackLogoutView  URL changed: $url");
        if (url != null &&
            url.startsWith(Urls.tataHitachiRedirectUri + "?code=")) {
          Logger().i("IndiaStackLogoutView URL changed with auth code : $url");
          try {
            if (url.contains("=")) {
              List<String> list = url.split("=");
              Logger().i("IndiaStackLogoutView url split list $list");
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
                // if (codeStringList.isNotEmpty) {
                //   getLoginDataV4(
                //     codeStringList[0],
                //   );
                // }
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

  saveToken(token, String expiryTime) {
    Logger().i("IndiaStackLogoutView saveToken from webview");
    _loginService.getUser(token, true);
    _loginService.saveExpiryTime(expiryTime);
  }

  getLoginDataV4(code) async {
    Logger().i("IndiaStackLogoutView getLoginDataV4 for code $code");
    codeChallenge = Utils.generateCodeChallenge(_createCodeVerifier());
    LoginResponse result =
        await _loginService.getLoginDataV4(code, codeChallenge, codeVerifier);
    if (result != null) {
      await _localService.saveTokenInfo(result);
      await _loginService.saveToken(
          result.access_token, result.expires_in.toString(), true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LogoutViewModel>.reactive(
      builder: (BuildContext context, LogoutViewModel viewModel, Widget _) {
        return WillPopScope(
          onWillPop: () {
            return onBackPressed();
          },
          child: Scaffold(
            body: SafeArea(
              child: WebviewScaffold(
                url: Urls.getV4LoginUrl(state, codeChallenge),
                hidden: true,
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => LogoutViewModel(),
    );
  }

  Future<bool> onBackPressed() {
    SystemNavigator.pop();
    return Future.value(false);
  }
}

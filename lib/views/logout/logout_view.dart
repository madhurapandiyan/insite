import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/login_service.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'logout_view_model.dart';

class LogoutView extends StatefulWidget {
  @override
  _LogoutViewState createState() => _LogoutViewState();
}

class _LogoutViewState extends State<LogoutView> {
  String loginUrl =
      "https://identity.trimble.com/i/oauth2/authorize?scope=openid&response_type=token&redirect_uri=" +
          "https://unifiedfleet.myvisionlink.com" +
          "&client_id=" +
          "2JkDsLlgBWwDEdRHkUiaO9TRWMYa" +
          "&state=https://unifiedfleet.myvisionlink.com/tatahitachi/&nonce=1&t=DCCCF741-6BC4-436D-A4D5-68C6D3403573";
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  StreamSubscription _onDestroy;
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  String token;

  final _localService = locator<LocalService>();
  final _loginService = locator<LoginService>();

  @override
  void dispose() {
    Logger().i("dispose state splash view");
    _onDestroy.cancel();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setupListeners();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(LogoutView oldWidget) {
    print("didUpdateWidget called");
    super.didUpdateWidget(oldWidget);
  }

  setupListeners() {
    Logger().i("init logout logout view");
    // flutterWebviewPlugin.close();

    // Add a listener to on destroy WebView, so you can make came actions.
    _onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {
      print("destroy");
    });

    _onStateChanged =
        flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      print("onStateChanged: ${state.type} ${state.url}");
      if (state == WebViewState.finishLoad) {
        isLoading = false;
        setState(() {});
      } else if (state == WebViewState.startLoad) {
        isLoading = true;
      }
    });

    // Add a listener to on url changed
    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        print("URL changed: $url");
        if (url.startsWith(
            "https://unifiedfleet.myvisionlink.com/#access_token=")) {
          print("URL changed with access token: $url");
          try {
            if (url.contains("=")) {
              List<String> list = url.split("=");
              print("url split list $list");
              if (list.isNotEmpty) {
                // _onUrlChanged.cancel();
                String accessTokenString = list[1];
                String expiresTokenString = list[3];
                List<String> accessTokenList = accessTokenString.split("&");
                List<String> expiryList = expiresTokenString.split("&");
                print("accessToken split list $list");
                String accessToken = accessTokenList[0];
                String expiryTime = expiryList[0];
                print("accessToken $accessToken");
                print("expiryTime $expiryTime");
                saveToken(accessToken, expiryTime);
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
    Logger().i("saveToken from webview");
    _loginService.getUser(token, true);
    _loginService.saveExpiryTime(expiryTime);
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
              child: Stack(
                children: [
                  WebviewScaffold(url: loginUrl),
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : SizedBox()
                ],
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
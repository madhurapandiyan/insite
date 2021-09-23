import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/services/login_service.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/urls.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'splash_view_model.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  StreamSubscription _onDestroy;
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  String token;

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
  void didUpdateWidget(SplashView oldWidget) {
    print("didUpdateWidget called");
    super.didUpdateWidget(oldWidget);
  }

  setupListeners() {
    Logger().i("init state splash view");
    flutterWebviewPlugin.close();

    // Add a listener to on destroy WebView, so you can make came actions.
    _onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {
      print("destroy");
    });

    _onStateChanged =
        flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      print("onStateChanged: ${state.type} ${state.url}");
      if (state.url != null &&
          state.url
              .startsWith(Urls.administratorBaseUrl + "/#access_token=")) {
        print("STATE changed with access token: $state.url");
        try {
          if (state.url.contains("=")) {
            List<String> list = state.url.split("=");
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
          Logger().i("login exceptoion");
          Logger().e(e);
        }
      }
    });

    // Add a listener to on url changed
    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        print("URL changed: $url");
        if (url != null &&
            url.startsWith(Urls.administratorBaseUrl + "/#access_token=")) {
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
            Logger().i("login exceptoion");
            Logger().e(e);
          }
        }
      }
    });
  }

  saveToken(token, String expiryTime) {
    Logger().i("saveToken from webview");
    _loginService.getUser(token, false);
    _loginService.saveExpiryTime(expiryTime);
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      builder: (BuildContext context, SplashViewModel viewModel, Widget _) {
        // setupListeners();
        return Scaffold(
          backgroundColor: tango,
          body: SafeArea(
            child: Stack(
              children: [
                viewModel.shouldLoadWebview
                    ? WebviewScaffold(url: Urls.administratorloginUrl,)
                    : SizedBox(),
                Center(
                  child: CircularProgressIndicator(),
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

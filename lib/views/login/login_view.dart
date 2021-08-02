import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/login_service.dart';
import 'package:insite/utils/urls.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'login_view_model.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  StreamSubscription _onDestroy;
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  bool isLoading = false;
  var _navigationService = locator<NavigationService>();
  final _localService = locator<LocalService>();
  final _loginService = locator<LoginService>();

  @override
  void dispose() {
    _onDestroy.cancel();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin.close();

    // Add a listener to on destroy WebView, so you can make came actions.
    _onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {
      print("destroy");
    });

    _onStateChanged =
        flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      print("onStateChanged: ${state.type} ${state.url}");
      // if (state == WebViewState.finishLoad) {
      //   isLoading = false;
      //   setState(() {});
      // } else if (state == WebViewState.startLoad) {
      //   isLoading = true;
      // }
    });

    // Add a listener to on url changed
    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        print("URL changed: $url");
        if (url.startsWith(Urls.unifiedServiceBaseUrl +
            "/?sessionDataKey=E294FEF4A64BF7E14940E2964F78E351")) {
          print("URL changed with access token: $url");
          // Future.delayed(Duration(seconds: 2), () {
          // flutterWebviewPlugin.launch(loginUrl);
          flutterWebviewPlugin.cleanCookies();
          _navigationService.navigateTo(logoutViewRoute);
          // _navigationService.pushNamedAndRemoveUntil(logoutViewRoute,
          //     predicate: (Route<dynamic> route) => false);
          // });
          // flutterWebviewPlugin.close();
        } else if (url
            .startsWith(Urls.unifiedServiceBaseUrl + "/#/access_token=")) {
          print("URL changed with access token: $url");
          try {
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
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (BuildContext context, LoginViewModel viewModel, Widget _) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                WebviewScaffold(
                  url: Urls.logoutUrlUnifiedService,
                ),
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : SizedBox()
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}

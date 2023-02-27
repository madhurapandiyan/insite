import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/views/home/home_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/router_constants.dart';

class ManageAccountViewModel extends BaseViewModel {
  Logger? log;

  ManageAccountViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    
  }

  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  var _navigationService = locator<NavigationService>();
  Future<bool>? onWillPop(BuildContext context) async {
    print("onwillpop");
    if (await flutterWebviewPlugin.canGoBack()) {
      flutterWebviewPlugin.goBack();
    } else {
      _navigationService.replaceWith(homeViewRoute);
    }
    return Future.value(false);
  }
}

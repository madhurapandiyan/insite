import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:insite/core/services/local_service.dart';

class NativeService {
  static const platform =
      const MethodChannel('com.example.insite.flutterchannel');
  final LocalService localService;

  NativeService(this.localService) {
    platform.setMethodCallHandler(nativeMethodCallHandler);
  }

  Future<dynamic> nativeMethodCallHandler(MethodCall methodCall) async {
    print('Native call!');
    switch (methodCall.method) {
      case "OauthCode":
        localService.setIsloggedIn(true);
        debugPrint(methodCall.arguments);
        return "This data from flutter.....";
        break;
      default:
        return "Nothing";
        break;
    }
  }

  Future<String> openLogin() async {
    return await platform.invokeMethod('open_login');
  }
}

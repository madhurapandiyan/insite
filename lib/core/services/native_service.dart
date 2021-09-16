import 'package:flutter/services.dart';
import 'package:insite/core/services/local_service.dart';

class NativeService {
   final platform =
      const MethodChannel('com.trimble.insite.flutterchannel');
  final LocalService localService;

  NativeService(this.localService) {
  }

  Future<String> openLogin() async {
    return await platform.invokeMethod('open_login');
  }
}

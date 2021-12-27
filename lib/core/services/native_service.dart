import 'package:flutter/services.dart';
import 'package:insite/core/services/local_service.dart';

class NativeService {
  final nativeToFlutterplatform = const MethodChannel(
      'com.trimble.insite.flutterchannel.native_to_flutter');
  final flutterToNativeplatform =
      const MethodChannel('com.trimble.insite.flutterchannel.flutter_to_native');
  final LocalService localService;

  NativeService(this.localService) {}

  Future<String> login() async {
    return await flutterToNativeplatform.invokeMethod('open_login');
  }

  Future<String> logout(String id_token) async {
    return await flutterToNativeplatform.invokeMethod('open_logout',id_token);
  }
}

import 'package:flutter/services.dart';

class NativeService {
  static const platform =
      const MethodChannel('com.example.insite.flutterchannel');

  NativeService();
}

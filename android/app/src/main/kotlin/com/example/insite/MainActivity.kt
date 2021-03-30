package com.example.insite

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    companion object {
      const val CHANNEL = "com.example.insite.flutterchannel"
      const val METHOD_OPEN_LOGIN = "open_login"
      const val KEY_MESSAGE = "message"
      var OPEN_LOGIN = 1
    }

    lateinit var methodResult: MethodChannel.Result;

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
              GeneratedPluginRegistrant.registerWith(flutterEngine)
        super.configureFlutterEngine(flutterEngine)
      MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
        call, result ->  
          if (call.method == METHOD_OPEN_LOGIN) {
            openLogin()
          } 
      }
    }

    private fun openLogin(){

    }
}

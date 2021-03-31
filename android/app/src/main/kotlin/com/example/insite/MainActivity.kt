package com.example.insite

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import android.net.Uri
import android.content.Intent
import android.util.Log

class MainActivity: FlutterActivity() {
    companion object {
      const val CHANNEL = "com.example.insite.flutterchannel"
      const val METHOD_OPEN_LOGIN = "open_login"
      const val KEY_MESSAGE = "message"
      var OPEN_LOGIN = 1
    }

    lateinit var methodResult: MethodChannel.Result;
    lateinit var methodChannel: MethodChannel;

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
              GeneratedPluginRegistrant.registerWith(flutterEngine)
        super.configureFlutterEngine(flutterEngine)
        methodChannel =      MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL);
methodChannel.setMethodCallHandler {
        call, result ->  
          if (call.method == METHOD_OPEN_LOGIN) {
             methodResult=result
              openLogin()
          } 
      }
    }

    private fun openLogin(){
            val loginUrl=  "https://identity-stg.trimble.com/i/oauth2/authorize?scope=openid&response_type=code&redirect_uri="+"eoltool://mobile"+"&client_id="+"r9GxbyX4uNMjpB1yZge6fiWSGQ4a"
            val intent = Intent(Intent.ACTION_VIEW, Uri.parse(loginUrl))
            startActivity(intent)
    }

    private fun openLogout(){

    }

    //things needs to be changed accordingly here if you want to take build with or with out login
    override fun onResume() {
        super.onResume()
            val uri = intent.data
            Log.d("onresume %s",uri.toString())
            if (uri != null) {
                Log.d("uri", uri.toString())
                var code = getCodeFromURI(uri)
                if(code!=null){
                  if(methodChannel!=null){
                    Log.d("invoking flutter mehtod ",code)
                      methodChannel.invokeMethod("OauthCode", code)
                  }
                }
            } 
    }

    fun getCodeFromURI(uri: Uri): String? {
        if (uri.toString().startsWith("eoltool://mobile")) {
            if (uri.toString().contains("code")) {
                val code = uri.getQueryParameter("code")
                                Log.d("code", code.toString())
                return code
            }
        }
        return ""
    }
}

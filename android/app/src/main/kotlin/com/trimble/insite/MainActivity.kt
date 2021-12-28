package com.trimble.insite

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    companion object {
        const val NATIVE_TO_FLUTTER_CHANNEL = "com.trimble.insite.flutterchannel.native_to_flutter"
        const val FLUTTER_TO_NATIVE_CHANNEL = "com.trimble.insite.flutterchannel.flutter_to_native"
        const val METHOD_OPEN_LOGIN = "open_login"
        const val METHOD_OPEN_LOGOUT = "open_logout"
        const val KEY_MESSAGE = "message"
        const val clientId = "0fc72a71-e4e5-4ac1-9c7b-e966050154c9"
        const val redirectUri = "insite://mobile"
        const val applicationName = "Frame-Administrator-IND"
        var OPEN_LOGIN = 1
    }

    private lateinit var CODE_VERIFIER: String
    private lateinit var CODE_CHALLENGE: String
    private lateinit var methodResult: MethodChannel.Result
    private lateinit var methodChannel: MethodChannel
    private lateinit var nativeToFlutterMethodChannel: MethodChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        super.configureFlutterEngine(flutterEngine)
        methodChannel =
            MethodChannel(flutterEngine.dartExecutor.binaryMessenger, FLUTTER_TO_NATIVE_CHANNEL)
        nativeToFlutterMethodChannel =
            MethodChannel(flutterEngine.dartExecutor.binaryMessenger, NATIVE_TO_FLUTTER_CHANNEL)
        methodChannel.setMethodCallHandler { call, result ->
            if (call.method == METHOD_OPEN_LOGIN) {
                methodResult = result
                openLogin()
            } else if (call.method == METHOD_OPEN_LOGOUT) {
                methodResult = result
                openLogout(call.arguments as String)
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        CODE_VERIFIER = Utils.getCodeVerifier()
    }

    private fun openLogin() {
        Utils.setCodeVerifier(context, CODE_VERIFIER)
        CODE_CHALLENGE = Utils.getCodeChallenge(CODE_VERIFIER)
        val loginUrl =
            "https://id.trimble.com/oauth/authorize?response_type=code&client_id=$clientId&redirect_uri=$redirectUri" +
                    "&scope=openid%20" + "$applicationName&code_challenge=$CODE_CHALLENGE&code_challenge_method=S256&navigationRedirectUri=/"
        Log.d("loginUrl %s", loginUrl)
        val intent = Intent(Intent.ACTION_VIEW, Uri.parse(loginUrl))
        startActivity(intent)
    }

    private fun openLogout(arguments: String) {
        val idToken = Utils.getIDToken(context)
        val logoutUrl =
            "https://id.trimble.com/oauth/logout?id_token_hint=$arguments&post_logout_redirect_uri=$redirectUri"
        Log.d("logoutUrl %s", logoutUrl)
        val intent = Intent(Intent.ACTION_VIEW, Uri.parse(logoutUrl))
        startActivity(intent)
    }

    //things needs to be changed accordingly here if you want to take build with or with out login
    override fun onResume() {
        super.onResume()
            val uri = intent.data
            Log.d("onResume %s", uri.toString())
            if (uri != null) {
                Log.d("uri", uri.toString())
                val code = getCodeFromURI(uri)
                if (code != null&&code.isNotEmpty()) {
                    Log.d("invoking flutter method ", code)
                    val codeChallenge = Utils.getCodeChallenge(Utils.getCodeVerifier())
                    val previousCodeVerifier = Utils.getStoredCodeVerifier(context)
                    val codeData = "$code,$codeChallenge,$previousCodeVerifier"
                    nativeToFlutterMethodChannel.invokeMethod("code_received", codeData)
            }
        }
    }

         override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        val uri = intent.data
        Log.d("onNewIntent %s", uri.toString())
        if (uri != null) {
            Log.d("uri", uri.toString())
            val code = getCodeFromURI(uri)
            if (code != null&&code.isNotEmpty()) {
                Log.d("invoking flutter method ", code)
                val codeChallenge = Utils.getCodeChallenge(Utils.getCodeVerifier())
                val previousCodeVerifier = Utils.getStoredCodeVerifier(context)
                val codeData = "$code,$codeChallenge,$previousCodeVerifier"
                nativeToFlutterMethodChannel.invokeMethod("code_received", codeData)
            }
        }
    }

    private fun getCodeFromURI(uri: Uri): String? {
        if (uri.toString().startsWith("insite://mobile")) {
            if (uri.toString().contains("code")) {
                val code = uri.getQueryParameter("code")
                Log.d("code", code.toString())
                return code
            }
        }
        return ""
    }
}

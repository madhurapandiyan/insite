package com.trimble.insite

import android.annotation.TargetApi
import android.content.Context
import android.content.SharedPreferences
import android.os.Build
import android.util.Base64
import android.util.Log
import org.json.JSONObject
import java.security.MessageDigest
import java.security.SecureRandom

object Utils {
    @TargetApi(Build.VERSION_CODES.FROYO)
    fun getCodeVerifier(): String {
        val secureRandom = SecureRandom()
        val code = ByteArray(64)
        secureRandom.nextBytes(code)
        return Base64.encodeToString(
            code,
            Base64.URL_SAFE or Base64.NO_WRAP or Base64.NO_PADDING
        )
    }

    @TargetApi(Build.VERSION_CODES.FROYO)
    fun getCodeChallenge(verifier: String): String {
        val bytes = verifier.toByteArray()
        val messageDigest = MessageDigest.getInstance("SHA-256")
        messageDigest.update(bytes, 0, bytes.size)
        val digest = messageDigest.digest()
        return Base64.encodeToString(
            digest,
            Base64.URL_SAFE or Base64.NO_WRAP or Base64.NO_PADDING
        )
    }

    fun getIDToken(context: Context): String? {
        Log.d("getIDToken","")
        try {
            val sharedPref: SharedPreferences =
                context.getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
            val data = sharedPref.getString("flutter.tokenInfo", "")
            if (data != null && data.isNotEmpty()) {
                val userJson = JSONObject(data)
                Log.d("id token json ", "$userJson")
                return userJson["id_token"].toString()
            }
            return null
        } catch (e: Exception) {
            Log.e("isCurrentUser", e.localizedMessage)
            return null
        }
    }

    fun getStoredCodeVerifier(context: Context): String? {
        try {
            val sharedPref: SharedPreferences =
                context.getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
            val data = sharedPref.getString("flutter.codeVerifierInfo", "")
            if (data != null && data.isNotEmpty()) {
                Log.d("getStoredCodeVerifier", data)
                return data
            }
            return null
        } catch (e: Exception) {
            Log.e("getCodeVerifier error", e.localizedMessage)
            return null
        }
    }

    fun setCodeVerifier(context: Context, codeVerifier: String) {
        try {
            Log.d("setCodeVerifier", codeVerifier)
            val sharedPref: SharedPreferences =
                context.getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
            val editor: SharedPreferences.Editor = sharedPref.edit()
            editor.putString("flutter.codeVerifierInfo", codeVerifier).commit()
        } catch (e: Exception) {
            Log.e("setCodeVerifier error", e.localizedMessage)
        }
    }
}
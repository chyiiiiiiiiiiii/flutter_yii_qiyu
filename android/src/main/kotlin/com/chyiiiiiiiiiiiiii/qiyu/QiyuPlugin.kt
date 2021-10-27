package com.chyiiiiiiiiiiiiii.qiyu

import android.app.Activity
import android.content.Context
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** QiyuPlugin */
class QiyuPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private val tag = "[QiyuPlugin]"

  private lateinit var channel : MethodChannel

  private lateinit var applicationContext: Context
  private var activity: Activity? = null

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    val sendData: Any? = call.arguments
    ///
    val qiyuManager = QiyuManager(call, result, applicationContext)
    when (call.method) {
      "initialize" -> {
        val appKey = call.argument<String>("appKey")
//        val appName = call.argument<String>("appName")
        val deviceIdentifier = call.argument<String>("deviceIdentifier")
        qiyuManager.initQiyu(appKey, deviceIdentifier)
      }
      "setDeviceIdentifier" -> {
        val deviceIdentifier = call.argument<String>("deviceIdentifier")
        qiyuManager.setDeviceIdentifier(deviceIdentifier)
      }
      "setUserInfo" -> {
        val userId = call.argument<String>("userId") ?: ""
        val userInfoDataList = call.argument<String>("userInfoDataList") ?: ""
        qiyuManager.setUserInfo(userId, userInfoDataList)
      }
      "showCustomerService" ->{
        qiyuManager.showServiceActivity()
      }
      "logoutUser" -> {
        qiyuManager.logout()
      }
      else -> {
        result.notImplemented()
      }
    }
    if (sendData != null) {
      result.success(sendData)
    } else {
      result.success(null)
    }
  }

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    applicationContext = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "qiyu")
    channel.setMethodCallHandler(this)
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivity() {
    activity = null
  }

}

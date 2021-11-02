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

  companion object{
    const val tag = "[QiyuPlugin]"
  }

  private lateinit var channel : MethodChannel

  private lateinit var applicationContext: Context
  private var activity: Activity? = null

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    val qiyuManager = QiyuManager(call, result, applicationContext)
    when (call.method) {
      "initialize" -> {
        qiyuManager.initQiyu()
      }
      "setDeviceIdentifier" -> {
        qiyuManager.setDeviceIdentifier()
      }
      "setUserInfo" -> {
        qiyuManager.setUserInfo()
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

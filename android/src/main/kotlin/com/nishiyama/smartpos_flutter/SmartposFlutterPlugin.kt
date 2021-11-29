package com.nishiyama.smartpos_flutter

import android.app.Activity
import androidx.annotation.NonNull
import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodChannel

/** SmartposFlutterPlugin */
class SmartposFlutterPlugin: FlutterPlugin, ActivityAware {
  private lateinit var channel : MethodChannel
  private lateinit var context: Context

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    channel.setMethodCallHandler(Handlers(context, binding.activity))
  }

  override fun onDetachedFromActivityForConfigChanges() {

  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {

  }

  override fun onDetachedFromActivity() {

  }

  override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(binding.binaryMessenger, "smartpos_flutter")
    context = binding.applicationContext
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}

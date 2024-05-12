package com.example.flutternativedata

import android.content.Context
import android.content.pm.PackageManager
import android.os.BatteryManager
import android.os.Build
import android.app.ActivityManager

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutternativedataPlugin */
class FlutternativedataPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android

   // Declare context variable
    private lateinit var context: Context
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var batteryManager: BatteryManager
  private lateinit var packageManager: PackageManager
  private lateinit var activityManager: ActivityManager


  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutternativedata")
    channel.setMethodCallHandler(this)

   // Initialize context and other variables
    context = flutterPluginBinding.applicationContext
    packageManager = context.packageManager
    batteryManager = flutterPluginBinding.applicationContext.getSystemService(Context.BATTERY_SERVICE) as BatteryManager
    activityManager = flutterPluginBinding.applicationContext.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "getBatteryLevel" -> {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
          result.success(batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY));
        } else {
          result.error("WRONG_VERSION", "android version not supported", "");
        }
      }
      "getPlatformVersion" -> {
        // Implement the logic to retrieve the platform version
        val version = "Android ${android.os.Build.VERSION.RELEASE}"
        result.success(version)
      }
      "getDeviceInfo" -> {
        val deviceInfo = getDeviceInfo()
                result.success(deviceInfo)
            }
      "getMemoryInfo" -> {
          val memoryInfo = getMemoryInfo()
                result.success(memoryInfo)
            }
      else -> {
        result.notImplemented()
      }
    }
  }

 private fun getDeviceInfo(): Map<String, Any>? {
    val infoMap = mutableMapOf<String, Any>()
    try {
        val packageInfo = packageManager.getPackageInfo(context.packageName, 0)
        infoMap["versionName"] = packageInfo.versionName
        infoMap["versionCode"] = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            packageInfo.longVersionCode
        } else {
            packageInfo.versionCode
        }
        infoMap["packageName"] = context.packageName
    } catch (e: PackageManager.NameNotFoundException) {
        // Handle exception if package information is not found
        return null
    }
    return infoMap
}

private fun getMemoryInfo(): Map<String, Any>? {
    val memoryInfo = ActivityManager.MemoryInfo()
    activityManager.getMemoryInfo(memoryInfo)
    val memoryInfoMap = mutableMapOf<String, Any>()
    memoryInfoMap["totalMemory"] = memoryInfo.totalMem
    memoryInfoMap["availableMemory"] = memoryInfo.availMem
    return memoryInfoMap
}

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}

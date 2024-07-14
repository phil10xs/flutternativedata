package com.example.flutternativedata
import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
import android.os.BatteryManager
import android.os.Build
import android.app.ActivityManager
import java.util.Locale
import java.util.TimeZone
import android.provider.Settings
import android.telephony.TelephonyManager
import androidx.core.app.ActivityCompat
import android.net.wifi.WifiManager
import java.net.NetworkInterface
import java.util.Collections

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
     "getPackageInfo" -> {
        val packageInfo = getPackageInfo()
                result.success(packageInfo)
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

 private fun getPackageInfo(): Map<String, Any>? {
    val infoMap = mutableMapOf<String, Any>()
     val packageManager = context.packageManager
     val packageInfo = packageManager.getPackageInfo(context.packageName, 0)
    val applicationInfo = packageManager.getApplicationInfo(context.packageName, 0)
    val appName = packageManager.getApplicationLabel(applicationInfo).toString()

    try {
        val packageInfo = packageManager.getPackageInfo(context.packageName, 0)
        infoMap["versionName"] = packageInfo.versionName
        infoMap["versionCode"] = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            packageInfo.longVersionCode
        } else {
            packageInfo.versionCode
        }
        infoMap["packageName"] = context.packageName
        infoMap["appName"] =  appName 
    } catch (e: PackageManager.NameNotFoundException) {
        // Handle exception if package information is not found
        return null
    }
    return infoMap
}

fun getSecondIMEI(context: Context): String? {
    val telephonyManager = context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
    return if (ActivityCompat.checkSelfPermission(context, Manifest.permission.READ_PHONE_STATE) == PackageManager.PERMISSION_GRANTED) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            telephonyManager.getImei(1) // 1 for the second SIM slot
        } else {
            null
        }
    } else {
        null
    }
}

fun getMacAddress(context: Context): String? {
    val wifiManager = context.applicationContext.getSystemService(Context.WIFI_SERVICE) as WifiManager
    return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
        try {
            val all = Collections.list(NetworkInterface.getNetworkInterfaces())
            for (nif in all) {
                if (nif.name.equals("wlan0", ignoreCase = true)) {
                    val macBytes = nif.hardwareAddress ?: return null
                    val macAddress = StringBuilder()
                    for (b in macBytes) {
                        macAddress.append(String.format("%02X:", b))
                    }
                    if (macAddress.isNotEmpty()) {
                        macAddress.deleteCharAt(macAddress.length - 1)
                    }
                    return macAddress.toString()
                }
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
        null
    } else {
        val wifiInfo = wifiManager.connectionInfo
        wifiInfo.macAddress
    }
}


fun getDeviceSerialNumber(): String {
    return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
        Build.getSerial()
    } else {
        Build.SERIAL
    }
}


private fun getDeviceInfo(): Map<String, Any> {
    val deviceInfoMap = mutableMapOf<String, Any>()
    deviceInfoMap["deviceModel"] = Build.MODEL
    deviceInfoMap["deviceManufacturer"] = Build.MANUFACTURER
    deviceInfoMap["deviceBrand"] = Build.BRAND
    deviceInfoMap["deviceName"] = Build.DEVICE
    deviceInfoMap["deviceProduct"] = Build.PRODUCT
    deviceInfoMap["deviceHardware"] = Build.HARDWARE
    deviceInfoMap["deviceOSVersion"] = Build.VERSION.RELEASE
    deviceInfoMap["deviceSDKVersion"] = Build.VERSION.SDK_INT
    deviceInfoMap["deviceID"] = Build.ID
    deviceInfoMap["deviceType"] = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
        if (context.checkSelfPermission(Manifest.permission.READ_PHONE_STATE) == PackageManager.PERMISSION_GRANTED) {
            "Phone"
        } else {
            "Phone"
        }
    } else {
        "Unknown"
    }
    deviceInfoMap["localizedModel"] = Build.MODEL 
    deviceInfoMap["deviceLanguage"] = Locale.getDefault().language // Added
    deviceInfoMap["deviceCountry"] = Locale.getDefault().country // Added
    deviceInfoMap["deviceTimeZone"] = TimeZone.getDefault().id // Added
    deviceInfoMap["systemVersion"] = Build.VERSION.RELEASE // Updated
    deviceInfoMap["deviceIMEI"] = Settings.Secure.getString(context.contentResolver, Settings.Secure.ANDROID_ID) // Updated
    deviceInfoMap["secondIMEI"] = getSecondIMEI(context) ?: "Unavailable"
    deviceInfoMap["serialNumber"] = getDeviceSerialNumber()
    deviceInfoMap["macAddress"] = getMacAddress(context) ?: "Unavailable"
    deviceInfoMap["identifierForVendor"] = Settings.Secure.getString(context.contentResolver, Settings.Secure.ANDROID_ID) // Updated
    return deviceInfoMap
}


private fun getMemoryInfo(): Map<String, Any>? {
    val memoryInfo = ActivityManager.MemoryInfo()
    activityManager.getMemoryInfo(memoryInfo)
    val memoryInfoMap = mutableMapOf<String, Any>()
    memoryInfoMap["totalMemory"] = memoryInfo.totalMem
    memoryInfoMap["availableMemory"] = memoryInfo.availMem
    memoryInfoMap["usedMemory"] = memoryInfo.totalMem - memoryInfo.availMem // Calculate used memory
    return memoryInfoMap
}

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}

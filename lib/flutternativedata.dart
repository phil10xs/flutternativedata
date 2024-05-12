import 'package:flutter/services.dart';

import 'flutternativedata_platform_interface.dart';

class Flutternativedata {
  Future<String?> getPlatformVersion() {
    return FlutternativedataPlatform.instance.getPlatformVersion();
  }

  /// récupération du niveau de la batterie
  Future<num?> getBatteryLevel() {
    return FlutternativedataPlatform.instance.getBatteryLevel();
  }

  Future<Map<String, dynamic>?> getDeviceInfo() async {
    try {
      final Map<String, dynamic>? deviceInfo =
          await FlutternativedataPlatform.instance.getDeviceInfo();
      return deviceInfo;
    } on PlatformException catch (e) {
      return {"error": "Failed to get device info: '${e.message}'."};
    }
  }

  Future<Map<String, dynamic>?> getMemoryInfo() async {
    try {
      final Map<String, dynamic>? memoryInfo =
          await FlutternativedataPlatform.instance.getMemoryInfo();
      return memoryInfo;
    } on PlatformException catch (e) {
      return {"error": "Failed to get device info: '${e.message}'."};
    }
  }
}

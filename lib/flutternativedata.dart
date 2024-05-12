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

  Future<Map<Object?, Object?>?> getDeviceInfo() async {
    try {
      final Map<Object?, Object?> deviceInfo =
          await FlutternativedataPlatform.instance.getDeviceInfo() ?? {};
      return deviceInfo;
    } on PlatformException catch (e) {
      return {"error": "Failed to get device info: '${e.message}'."};
    }
  }

  Future<Map<Object?, Object?>?> getMemoryInfo() async {
    try {
      final Map<Object?, Object?> memoryInfo =
          await FlutternativedataPlatform.instance.getMemoryInfo() ?? {};
      return memoryInfo;
    } on PlatformException catch (e) {
      return {"error": "Failed to get device info: '${e.message}'."};
    }
  }
}

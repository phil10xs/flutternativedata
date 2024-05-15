import 'dart:developer';

import 'package:flutternativedata/entities/fn_device_info.dart';
import 'package:flutternativedata/entities/fn_memory_info.dart';
import 'package:flutternativedata/entities/fn_package_info.dart';
import 'package:flutternativedata/util/primitive_ext.dart';
import 'flutternativedata_platform_interface.dart';

class Flutternativedata {
  Future<String?> getPlatformVersion() {
    return FlutternativedataPlatform.instance.getPlatformVersion();
  }

  Future<num?> getBatteryLevel() {
    return FlutternativedataPlatform.instance.getBatteryLevel();
  }

  Future<FNDeviceInfo?> getDeviceInfo() async {
    FNDeviceInfo? fnDeviceInfo;
    final Map<Object?, Object?>? deviceInfo =
        await FlutternativedataPlatform.instance.getDeviceInfo();
    if (deviceInfo != null && deviceInfo.isNotEmpty) {
      fnDeviceInfo = FNDeviceInfo.fromJson(deviceInfo.convertToDynamicMap());
    }
    log(' fnDeviceInfo $deviceInfo');
    return fnDeviceInfo;
  }

  Future<FNMemoryInfo?> getMemoryInfo() async {
    FNMemoryInfo? fnMemoryInfo;
    final Map<Object?, Object?>? memoryInfo =
        await FlutternativedataPlatform.instance.getMemoryInfo();
    if (memoryInfo != null && memoryInfo.isNotEmpty) {
      fnMemoryInfo = FNMemoryInfo.fromJson(memoryInfo.convertToDynamicMap());
    }
    log('fnMemoryInfo $memoryInfo');
    return fnMemoryInfo;
  }

  Future<FNPackageInfo?> getPackageInfo() async {
    FNPackageInfo? fnPackageInfo;
    final Map<Object?, Object?>? packageInfo =
        await FlutternativedataPlatform.instance.getPackageInfo();
    if (packageInfo != null && packageInfo.isNotEmpty) {
      fnPackageInfo = FNPackageInfo.fromJson(packageInfo.convertToDynamicMap());
    }
    log('fnPackageInfo $packageInfo');
    return fnPackageInfo;
  }
}

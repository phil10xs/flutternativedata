import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutternativedata_platform_interface.dart';

/// An implementation of [FlutternativedataPlatform] that uses method channels.
class MethodChannelFlutternativedata extends FlutternativedataPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutternativedata');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<num?> getBatteryLevel() {
    return methodChannel.invokeMethod<num?>('getBatteryLevel');
  }

  @override
  Future<Map<Object?, Object?>?> getDeviceInfo() async {
    return await methodChannel
        .invokeMethod<Map<Object?, Object?>>('getDeviceInfo');
  }

  @override
  Future<Map<Object?, Object?>?> getMemoryInfo() {
    return methodChannel.invokeMethod<Map<Object?, Object?>>('getMemoryInfo');
  }
}

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutternativedata_method_channel.dart';

abstract class FlutternativedataPlatform extends PlatformInterface {
  /// Constructs a FlutternativedataPlatform.
  FlutternativedataPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutternativedataPlatform _instance = MethodChannelFlutternativedata();

  /// The default instance of [FlutternativedataPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutternativedata].
  static FlutternativedataPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutternativedataPlatform] when
  /// they register themselves.
  static set instance(FlutternativedataPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<num?> getBatteryLevel() {
    throw UnimplementedError('getBatteryLevel() has not been implemented.');
  }

  Future<Map<Object?, Object?>?> getDeviceInfo() {
    throw UnimplementedError('getDeviceInfo() has not been implemented.');
  }

  Future<Map<Object?, Object?>?> getMemoryInfo() {
    throw UnimplementedError('getMemoryInfo() has not been implemented.');
  }

  Future<Map<Object?, Object?>?> getPackageInfo() {
    throw UnimplementedError('getMemoryInfo() has not been implemented.');
  }
}

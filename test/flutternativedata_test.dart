import 'package:flutter_test/flutter_test.dart';
import 'package:flutternativedata/flutternativedata.dart';
import 'package:flutternativedata/flutternativedata_platform_interface.dart';
import 'package:flutternativedata/flutternativedata_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutternativedataPlatform
    with MockPlatformInterfaceMixin
    implements FlutternativedataPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<num?> getBatteryLevel() => Future.value(21);

  @override
  Future<Map<Object?, Object?>> getDeviceInfo() => Future.value({
        'model': 'MockDevice',
        'manufacturer': 'MockManufacturer',
        'osVersion': 'MockOS',
      });

  @override
  Future<Map<Object?, Object?>?> getPackageInfo() {
    final packageInfo = {
      'versionName': '1.0.0',
      'versionCode': '1',
      'packageName': 'com.example.app',
    };
    return Future.value(packageInfo);
  }

  @override
  Future<Map<String, dynamic>?> getMemoryInfo() => Future.value({
        'totalMemory': 1024 * 1024 * 1024, // 1GB
        'availableMemory': 512 * 1024 * 1024, // 512MB
      });
}

void main() {
  final FlutternativedataPlatform initialPlatform =
      FlutternativedataPlatform.instance;
  Flutternativedata flutternativedataPlugin = Flutternativedata();
  MockFlutternativedataPlatform fakePlatform = MockFlutternativedataPlatform();
  FlutternativedataPlatform.instance = fakePlatform;

  test('$MethodChannelFlutternativedata is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutternativedata>());
  });

  test('getPlatformVersion', () async {
    expect(await flutternativedataPlugin.getPlatformVersion(), '42');
  });

  // We're creating a new test to verify if the previously overridden value is returned correctly.
  test('getBatteryLevel', () async {
    expect(await flutternativedataPlugin.getBatteryLevel(), 21);
  });

  test('getDeviceInfo', () async {
    final deviceInfo = await flutternativedataPlugin.getDeviceInfo();
    expect(deviceInfo, isNotNull);
    expect(deviceInfo!['model'], 'MockDevice');
    expect(deviceInfo['manufacturer'], 'MockManufacturer');
    expect(deviceInfo['osVersion'], 'MockOS');
  });

  test('getPackageInfo', () async {
    final packageInfo = await flutternativedataPlugin.getPackageInfo();
    expect(packageInfo, isNotNull);
    expect(packageInfo!['versionName'], 'com.example.app');
  });

  test('getMemoryInfo', () async {
    final memoryInfo = await flutternativedataPlugin.getMemoryInfo();
    expect(memoryInfo, isNotNull);
    expect(memoryInfo!['totalMemory'], 1024 * 1024 * 1024); // 1GB
    expect(memoryInfo['availableMemory'], 512 * 1024 * 1024); // 512MB
  });
}

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutternativedata/flutternativedata_method_channel.dart';

//  * @file flutternativedata_method_channel_test.dart
//  * @description This file contains unit tests for the [MethodChannelFlutternativedata] class.
//  * It uses the flutter_test package to ensure the correct functionality of methods that interact
//  * with the native platform via method channels.

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelFlutternativedata platform = MethodChannelFlutternativedata();
  const MethodChannel channel = MethodChannel('flutternativedata');

  setUp(
    () {
      TestDefaultBinaryMessengerBinding.instance?.defaultBinaryMessenger
          .setMockMethodCallHandler(
        channel,
        (MethodCall methodCall) async {
          switch (methodCall.method) {
            case 'getPlatformVersion':
              return '42';
            case 'getBatteryLevel':
              return 21;
            case 'getDeviceInfo':
              return {
                'deviceModel': 'Pixel',
                'deviceManufacturer': 'Google',
                'deviceOSVersion': '12',
                'deviceLanguage': 'en',
                'deviceCountry': 'US',
              };
            case 'getMemoryInfo':
              return {
                'totalMemory': 4096,
                'availableMemory': 2048,
                'usedMemory': 2048,
              };
            case 'getPackageInfo':
              return {
                'versionName': '1.0.0',
                'versionCode': 1,
                'packageName': 'com.example.app',
                'appName': 'Example App',
              };
            default:
              return null;
          }
        },
      );
    },
  );

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance?.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });

  test('getBatteryLevel', () async {
    expect(await platform.getBatteryLevel(), 21);
  });

  test('getDeviceInfo', () async {
    final deviceInfo = await platform.getDeviceInfo();
    expect(deviceInfo?['deviceModel'], 'Pixel');
    expect(deviceInfo?['deviceManufacturer'], 'Google');
    expect(deviceInfo?['deviceOSVersion'], '12');
    expect(deviceInfo?['deviceLanguage'], 'en');
    expect(deviceInfo?['deviceCountry'], 'US');
  });

  test('getMemoryInfo', () async {
    final memoryInfo = await platform.getMemoryInfo();
    expect(memoryInfo?['totalMemory'], 4096);
    expect(memoryInfo?['availableMemory'], 2048);
    expect(memoryInfo?['usedMemory'], 2048);
  });

  test('getPackageInfo', () async {
    final packageInfo = await platform.getPackageInfo();
    expect(packageInfo?['versionName'], '1.0.0');
    expect(packageInfo?['versionCode'], 1);
    expect(packageInfo?['packageName'], 'com.example.app');
    expect(packageInfo?['appName'], 'Example App');
  });
}

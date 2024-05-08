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
}

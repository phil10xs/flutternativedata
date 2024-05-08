import 'flutternativedata_platform_interface.dart';

class Flutternativedata {
  Future<String?> getPlatformVersion() {
    return FlutternativedataPlatform.instance.getPlatformVersion();
  }

  /// récupération du niveau de la batterie
  Future<num?> getBatteryLevel() {
    return FlutternativedataPlatform.instance.getBatteryLevel();
  }
}

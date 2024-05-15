class FNDeviceInfo {
  final String? deviceType;
  final String? deviceLanguage;
  final String? identifierForVendor;
  final String? systemVersion;
  final String? deviceCountry;
  final String? deviceTimeZone;
  final String? deviceName;
  final String? localizedModel;
  final String? deviceModel;

  FNDeviceInfo({
    required this.deviceType,
    required this.deviceLanguage,
    required this.identifierForVendor,
    required this.systemVersion,
    required this.deviceCountry,
    required this.deviceTimeZone,
    required this.deviceName,
    required this.localizedModel,
    required this.deviceModel,
  });

  factory FNDeviceInfo.fromJson(Map<dynamic, dynamic> json) {
    return FNDeviceInfo(
      deviceType: json['deviceType'],
      deviceLanguage: json['deviceLanguage'],
      identifierForVendor: json['identifierForVendor'],
      systemVersion: json['systemVersion'],
      deviceCountry: json['deviceCountry'],
      deviceTimeZone: json['deviceTimeZone'],
      deviceName: json['deviceName'],
      localizedModel: json['localizedModel'],
      deviceModel: json['deviceModel'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'deviceType': deviceType,
      'deviceLanguage': deviceLanguage,
      'identifierForVendor': identifierForVendor,
      'systemVersion': systemVersion,
      'deviceCountry': deviceCountry,
      'deviceTimeZone': deviceTimeZone,
      'deviceName': deviceName,
      'localizedModel': localizedModel,
      'deviceModel': deviceModel,
    };
  }
}

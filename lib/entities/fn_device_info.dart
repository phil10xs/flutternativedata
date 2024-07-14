class FNDeviceInfo {
  final String? deviceType;
  final String? deviceLanguage;
  final String? identifierForVendor;
  final String? deviceIMEI;
  final String? systemVersion;
  final String? deviceCountry;
  final String? deviceTimeZone;
  final String? deviceName;
  final String? localizedModel;
  final String? deviceModel;
  final String? deviceManufacturer;
  final String? deviceBrand;
  final String? deviceProduct;
  final String? deviceHardware;
  final String? deviceOSVersion;
  final String? deviceSDKVersion;
  final String? deviceID;
  final String? secondIMEI;
  final String? macAddress;
  final String? serialNumber;

  FNDeviceInfo({
    required this.macAddress,
    required this.serialNumber,
    required this.secondIMEI,
    required this.deviceType,
    required this.deviceLanguage,
    required this.identifierForVendor,
    required this.deviceIMEI,
    required this.systemVersion,
    required this.deviceCountry,
    required this.deviceTimeZone,
    required this.deviceName,
    required this.localizedModel,
    required this.deviceModel,
    required this.deviceManufacturer,
    required this.deviceBrand,
    required this.deviceProduct,
    required this.deviceHardware,
    required this.deviceOSVersion,
    required this.deviceSDKVersion,
    required this.deviceID,
  });

  factory FNDeviceInfo.fromJson(Map<dynamic, dynamic> json) {
    return FNDeviceInfo(
      deviceType: json['deviceType'],
      deviceLanguage: json['deviceLanguage'],
      identifierForVendor: json['identifierForVendor'],
      deviceIMEI: json['deviceIMEI'],
      secondIMEI: json["secondIMEI"],
      macAddress: json['macAddress'],
      serialNumber: json['serialNumber'],
      systemVersion: json['systemVersion'],
      deviceCountry: json['deviceCountry'],
      deviceTimeZone: json['deviceTimeZone'],
      deviceName: json['deviceName'],
      localizedModel: json['localizedModel'],
      deviceModel: json['deviceModel'],
      deviceManufacturer: json['deviceManufacturer'],
      deviceBrand: json['deviceBrand'],
      deviceProduct: json['deviceProduct'],
      deviceHardware: json['deviceHardware'],
      deviceOSVersion: json['deviceOSVersion'],
      deviceSDKVersion: json['deviceSDKVersion'].toString(),
      deviceID: json['deviceID'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'deviceType': deviceType,
      'deviceLanguage': deviceLanguage,
      'identifierForVendor': identifierForVendor,
      'deviceIMEI': deviceIMEI,
      'secondIMEI': secondIMEI,
      'macAddress': macAddress,
      'serialNumber': serialNumber,
      'systemVersion': systemVersion,
      'deviceCountry': deviceCountry,
      'deviceTimeZone': deviceTimeZone,
      'deviceName': deviceName,
      'localizedModel': localizedModel,
      'deviceModel': deviceModel,
      'deviceManufacturer': deviceManufacturer,
      'deviceBrand': deviceBrand,
      'deviceProduct': deviceProduct,
      'deviceHardware': deviceHardware,
      'deviceOSVersion': deviceOSVersion,
      'deviceSDKVersion': deviceSDKVersion,
      'deviceID': deviceID,
    };
  }
}

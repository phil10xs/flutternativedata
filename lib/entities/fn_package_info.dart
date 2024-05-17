class FNPackageInfo {
  final String? versionCode;
  final String? packageName;
  final String? versionName;
  final String? appName;

  FNPackageInfo({
    this.versionCode,
    this.packageName,
    this.versionName,
    this.appName,
  });

  factory FNPackageInfo.fromJson(Map<String, dynamic> json) {
    return FNPackageInfo(
      versionCode: json['versionCode'].toString(),
      packageName: json['packageName'],
      versionName: json['versionName'],
      appName: json['appName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'versionCode': versionCode,
      'packageName': packageName,
      'versionName': versionName,
      'appName': appName,
    };
  }
}

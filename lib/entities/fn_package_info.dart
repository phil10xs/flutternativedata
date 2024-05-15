class FNPackageInfo {
  final String? versionCode;
  final String? packageName;
  final String? versionName;

  FNPackageInfo({
    this.versionCode,
    this.packageName,
    this.versionName,
  });

  factory FNPackageInfo.fromJson(Map<String, dynamic> json) {
    return FNPackageInfo(
      versionCode: json['versionCode'].toString(),
      packageName: json['packageName'],
      versionName: json['versionName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'versionCode': versionCode,
      'packageName': packageName,
      'versionName': versionName,
    };
  }
}

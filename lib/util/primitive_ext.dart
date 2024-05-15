extension MapExt on Map<Object?, Object?>? {
  Map<String, dynamic> convertToDynamicMap() {
    Map<String, dynamic> convertedMap = {};
    if (this != null) {
      this!.forEach((key, value) {
        if (key != null && value != null) {
          convertedMap[key.toString()] = value;
        }
      });
    }
    return convertedMap;
  }
}

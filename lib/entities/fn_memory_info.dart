class FNMemoryInfo {
  final int? totalMemory;
  final int? availableMemory;
  final int? usedMemory;

  FNMemoryInfo({
    this.totalMemory,
    this.availableMemory,
    this.usedMemory,
  });

  factory FNMemoryInfo.fromJson(Map<String, dynamic> json) {
    return FNMemoryInfo(
      totalMemory: json['totalMemory'],
      availableMemory: json['availableMemory'],
      usedMemory: json['usedMemory'],
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    data['totalMemory'] = totalMemory;
    data['availableMemory'] = availableMemory;
    data['usedMemory'] = usedMemory;
    return data;
  }
}

class BachModel {
  final String batchNumber;
  final DateTime expirationDate;

  BachModel({
    required this.batchNumber,
    required this.expirationDate,
  });

  factory BachModel.fromJson(Map<String, dynamic> json) {
    return BachModel(
      batchNumber: json['batchNumber'],
      expirationDate: DateTime.parse(json['expirationDate']),
    );
  }

  static List<BachModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => BachModel.fromJson(json)).toList();
  }

  BachModel copyWith({
    String? batchNumber,
    DateTime? expirationDate,
  }) {
    return BachModel(
      batchNumber: batchNumber ?? this.batchNumber,
      expirationDate: expirationDate ?? this.expirationDate,
    );
  }
}

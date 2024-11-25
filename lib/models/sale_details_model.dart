class SaleDetailsModel {
  final String productBarCode;
  final String productName;
  final double unitPrice;
  final int quantity;
  final double total;

  SaleDetailsModel({
    required this.productBarCode,
    required this.productName,
    required this.unitPrice,
    required this.quantity,
    required this.total,
  });

  factory SaleDetailsModel.fromJson(Map<String, dynamic> json) {
    return SaleDetailsModel(
      productBarCode: json['productBarCode'],
      productName: json['productName'],
      unitPrice: json['unitPrice'],
      quantity: json['quantity'],
      total: json['total'],
    );
  }

  static List<SaleDetailsModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => SaleDetailsModel.fromJson(json)).toList();
  }

  SaleDetailsModel copyWith({
    String? productBarCode,
    String? productName,
    double? unitPrice,
    int? quantity,
    double? total,
  }) {
    return SaleDetailsModel(
      productBarCode: productBarCode ?? this.productBarCode,
      productName: productName ?? this.productName,
      unitPrice: unitPrice ?? this.unitPrice,
      quantity: quantity ?? this.quantity,
      total: total ?? this.total,
    );
  }
}

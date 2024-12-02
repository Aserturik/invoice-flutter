import 'package:facturacion/models/bach_model.dart';

class BuyDetailsModel {
  final String productBarCode;
  final String productName;
  final String productBatch;
  final double unitPrice;
  final int quantity;
  final double total;
  final BachModel bach;

  BuyDetailsModel({
    required this.productBarCode,
    required this.productName,
    required this.productBatch,
    required this.unitPrice,
    required this.quantity,
    required this.total,
    required this.bach,
  });

  factory BuyDetailsModel.fromJson(Map<String, dynamic> json) {
    return BuyDetailsModel(
      productBarCode: json['productBarCode'],
      productName: json['productName'],
      productBatch: json['productBatch'],
      unitPrice: json['unitPrice'],
      quantity: json['quantity'],
      total: json['total'],
      bach: BachModel.fromJson(json['bach']),
    );
  }

  static List<BuyDetailsModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => BuyDetailsModel.fromJson(json)).toList();
  }

  BuyDetailsModel copyWith({
    String? productBarCode,
    String? productName,
    String? productBatch,
    double? unitPrice,
    int? quantity,
    double? total,
    BachModel? bach,
  }) {
    return BuyDetailsModel(
      productBarCode: productBarCode ?? this.productBarCode,
      productName: productName ?? this.productName,
      productBatch: productBatch ?? this.productBatch,
      unitPrice: unitPrice ?? this.unitPrice,
      quantity: quantity ?? this.quantity,
      total: total ?? this.total,
      bach: bach ?? this.bach,
    );
  }
}

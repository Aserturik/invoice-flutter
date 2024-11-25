import 'package:facturacion/models/sale_details_model.dart';

class SaleModel {
  final int id;
  final double total;
  final String paymentMethod;
  final String saleDate;
  final String workerName;
  final List<SaleDetailsModel> details;

  SaleModel({
    required this.id,
    required this.total,
    required this.paymentMethod,
    required this.saleDate,
    required this.workerName,
    required this.details,
  });

  factory SaleModel.fromJson(Map<String, dynamic> json) {
    return SaleModel(
      id: json['id'],
      total: json['total'],
      paymentMethod: json['paymentMethod'],
      saleDate: json['saleDate'],
      workerName: json['workerName'],
      details: SaleDetailsModel.fromJsonList(json['saleDetails']),
    );
  }

  static List<SaleModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => SaleModel.fromJson(json)).toList();
  }

  SaleModel copyWith({
    int? id,
    double? total,
    String? paymentMethod,
    String? saleDate,
    String? workerName,
    List<SaleDetailsModel>? details,
  }) {
    return SaleModel(
      id: id ?? this.id,
      total: total ?? this.total,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      saleDate: saleDate ?? this.saleDate,
      workerName: workerName ?? this.workerName,
      details: details ?? this.details,
    );
  }
}

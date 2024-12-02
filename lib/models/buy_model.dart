import 'package:facturacion/models/buy_details_model.dart';

class BuyModel {
  final int id;
  final String purchaseNumber;
  final DateTime purchaseDate;
  final double total;
  final List<BuyDetailsModel> purchaseDetails;

  BuyModel({
    required this.id,
    required this.purchaseNumber,
    required this.purchaseDate,
    required this.total,
    required this.purchaseDetails,
  });

  factory BuyModel.fromJson(Map<String, dynamic> json) {
    return BuyModel(
      id: json['id'],
      purchaseNumber: json['purchaseNumber'],
      purchaseDate: DateTime.parse(json['purchaseDate']),
      total: json['total'],
      purchaseDetails: BuyDetailsModel.fromJsonList(json['purchaseDetails']),
    );
  }

  static List<BuyModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => BuyModel.fromJson(json)).toList();
  }

  BuyModel copyWith({
    int? id,
    String? purchaseNumber,
    DateTime? purchaseDate,
    double? total,
    List<BuyDetailsModel>? purchaseDetails,
  }) {
    return BuyModel(
      id: id ?? this.id,
      purchaseNumber: purchaseNumber ?? this.purchaseNumber,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      total: total ?? this.total,
      purchaseDetails: purchaseDetails ?? this.purchaseDetails,
    );
  }
}

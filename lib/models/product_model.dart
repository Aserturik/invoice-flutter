class ProductModel {
  final int id;
  final String name;
  final String barCode;
  final double salePrice;
  final int stock;

  ProductModel({
    required this.id,
    required this.name,
    required this.barCode,
    required this.salePrice,
    required this.stock,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      barCode: json['barCode'],
      salePrice: json['salePrice'],
      stock: json['stock'],
    );
  }

  static List<ProductModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ProductModel.fromJson(json)).toList();
  }
}

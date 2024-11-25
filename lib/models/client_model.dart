class ClientModel {
  final int id;
  final String name;
  final int documentNumber;
  final String documentType;
  final String email;
  final String phone;

  ClientModel(
      {required this.id,
      required this.name,
      required this.documentNumber,
      required this.documentType,
      required this.email,
      required this.phone});

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['id'],
      name: json['name'],
      documentNumber: json['documentNumber'],
      documentType: json['documentType'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  static List<ClientModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ClientModel.fromJson(json)).toList();
  }

  ClientModel copyWith({
    int? id,
    String? name,
    int? documentNumber,
    String? documentType,
    String? email,
    String? phone,
  }) {
    return ClientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      documentNumber: documentNumber ?? this.documentNumber,
      documentType: documentType ?? this.documentType,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }
}

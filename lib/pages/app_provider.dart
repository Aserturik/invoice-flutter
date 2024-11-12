import 'dart:convert';

import 'package:facturacion/shared/constants/constants.dart';
import 'package:facturacion/shared/network/local_network.dart';
import 'package:facturacion/widgets/ss_alert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:facturacion/models/product_model.dart';
import 'package:facturacion/pages/app_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthSignUpNotifier extends StateNotifier<AppState> {
  AuthSignUpNotifier() : super(AppState());
  final url = 'https://petshop-production-cd0a.up.railway.app';

  Future<void> signUpPress(
      {required String correo, required String password}) async {
    final response = await http.post(
      Uri.parse('$url/login'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(
        {
          "username": correo,
          "password": password,
        },
      ),
    );
    Map<String, dynamic> jsonData = json.decode(response.body);
    await CacheNetwork.insertToCache(
        key: "jwtToken", value: jsonData['jwtToken']);
    jwtToken = CacheNetwork.getCacheData(key: 'jwtToken');
  }

  Future<void> fetchData({loading = true}) async {
    if (loading) {
      state = state.copyWith(loadingHome: true);
    }
    final response = await http.get(
      Uri.parse('$url/products'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List<dynamic> productsJson = jsonData['content'];
      List<ProductModel> products = ProductModel.fromJsonList(productsJson);
      state = state.copyWith(
        products: products,
      );
      print('Productos cargados correctamente');
    } else {
      print('Failed to fetch products');
    }
    if (loading) {
      state = state.copyWith(loadingHome: false);
    }
  }

  Future<ProductModel?> searchProduct(String barcode) async {
    final response = await http.get(
      Uri.parse('$url/products/$barcode'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      ProductModel product = ProductModel.fromJson(jsonData);
      state = state.copyWith(
        product: product,
      );
      return product;
    } else {
      print('Failed to fetch product');
      return null;
    }
  }

  Future<void> addProduct({
    required String name,
    required String barcode,
    required double purchasePrice,
    required double salePrice,
    required BuildContext context,
  }) async {
    state = state.copyWith(loadingHome: true);
    try {
      final response = await http.post(
        Uri.parse('$url/products'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
        body: jsonEncode({
          "name": name,
          "barCode": barcode,
          "purchasePrice": purchasePrice,
          "salePrice": salePrice,
        }),
      );

      if (response.statusCode == 200) {
        // Registro exitoso
        // print('Producto registrado con éxito: ${response.body}');
        SsAlert.showAutoDismissSnackbar(
            // ignore: use_build_context_synchronously
            context,
            Colors.green,
            'Producto registrado con éxito');
      } else {
        // Error en el registro
        SsAlert.showAutoDismissSnackbar(
            // ignore: use_build_context_synchronously
            context,
            Colors.green,
            'Error al registrar el producto');
        // print(
        //     'Error al registrar el producto: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      // print(e);
    } finally {
      state = state.copyWith(loadingHome: false);
    }
  }

  Future<void> sales({
    required List<SaleModel> sales,
  }) async {
    state = state.copyWith(loadingHome: true);
    try {
      List<Map<String, dynamic>> saleDetailsJson =
          sales.map((sale) => sale.toJson()).toList();
      final response = await http.post(
        Uri.parse('http://$url:8080/sales'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "saleDetails": saleDetailsJson,
        }),
      );
      if (response.statusCode == 200) {
        print('Venta enviada con éxito');
      } else {
        print('Error al enviar la venta: ${response.body}');
      }
    } catch (e) {
      print(e);
    } finally {
      state = state.copyWith(loadingHome: false);
    }
  }

  Future<void> postSales({
    required List<SaleModel> sales,
  }) async {
    state = state.copyWith(loadingHome: true);
    try {
      List<Map<String, dynamic>> saleDetailsJson =
          sales.map((sale) => sale.toJson()).toList();
      final response = await http.get(
        Uri.parse('http://$url:8080/sales'),
      );
      if (response.statusCode == 200) {
        print('Venta enviada con éxito');
      } else {
        print('Error al enviar la venta: ${response.body}');
      }
    } catch (e) {
      print(e);
    } finally {
      state = state.copyWith(loadingHome: false);
    }
  }
}

final appProvider = StateNotifierProvider<AuthSignUpNotifier, AppState>((ref) {
  return AuthSignUpNotifier();
});

class SaleModel {
  final int idProduct;
  final int quantity;
  final double unitPrice;

  SaleModel({
    required this.idProduct,
    required this.quantity,
    required this.unitPrice,
  });

  SaleModel copyWith({
    int? idProduct,
    int? quantity,
    double? unitPrice,
  }) {
    return SaleModel(
      idProduct: idProduct ?? this.idProduct,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "productId": idProduct,
      "quantity": quantity,
      "unitPrice": unitPrice,
      "subTotal": quantity * unitPrice,
    };
  }
}

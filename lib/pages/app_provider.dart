import 'dart:convert';

import 'package:facturacion/models/client_model.dart';
import 'package:facturacion/routes/app_router.dart';
import 'package:facturacion/routes/app_router.gr.dart';
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

  Future<void> signUpPress(
      {required String correo, required String password}) async {
    final response = await http.post(
      Uri.parse('$api/login'),
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

  Future<void> signInPress({
    required String name,
    required String document,
    required String documentType,
    required String correo,
    required String phone,
    required String password,
  }) async {
    await http.post(
      Uri.parse('$api/login/registerAdmin'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(
        {
          "personRegisterDTO": {
            "name": correo,
            "documentNumber": document,
            "documentType": documentType,
            "email": correo,
            "phone": phone,
          },
          "loginRegisterDTO": {
            "email": correo,
            "password": password,
            "role": "WORKER",
          },
        },
      ),
    );
  }

  Future<void> fetchData({loading = true}) async {
    if (loading) {
      state = state.copyWith(loadingHome: true);
    }
    final response = await http.get(
      Uri.parse('$api/products'),
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
    }
    if (loading) {
      state = state.copyWith(loadingHome: false);
    }
  }

  Future<void> sendSale({
    required ClientModel client,
    required ClientModel employee,
    required List<ProductModel> products,
  }) async {
    const String paymentMethod = 'CASH';
    final saleDetails = products.map((product) {
      return {
        "productBarCode": product.barCode,
        "quantity": product.stock,
      };
    }).toList();

    final requestBody = {
      "username": employee.email,
      "clientId": client.id,
      "paymentMethod": paymentMethod,
      "saleDetails": saleDetails,
    };

    try {
      final response = await http.post(
        Uri.parse('$api/sales'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        SsAlert.showAutoDismissSnackbar(
          appRouter.navigatorKey.currentContext!,
          Colors.green,
          'Venta realizada con éxito',
        );
        appRouter.popAndPush(const HomeRoute());
      } else {
        SsAlert.showAutoDismissSnackbar(
          appRouter.navigatorKey.currentContext!,
          Colors.red,
          'Error al realizar la venta: ${response.statusCode}',
        );
      }
    } catch (e) {
      SsAlert.showAutoDismissSnackbar(
        appRouter.navigatorKey.currentContext!,
        Colors.red,
        'Error al realizar la venta: $e',
      );
    }
  }

  Future<void> sendBuy({
    required List<ProductModel> products,
    required String batchNumber,
    required String purchaseNumber,
    required String expirationDate,
  }) async {
    final purchaseDetails = products.map((product) {
      return {
        "productBarCode": product.barCode,
        "unitPrice": product.purchasePrice,
        "quantity": product.stock,
        "batch": {
          "batchNumber": batchNumber,
          "expirationDate": expirationDate,
        }
      };
    }).toList();
    final requestBody = {
      "purchaseNumber": purchaseNumber,
      "purchaseDetails": purchaseDetails,
    };
    try {
      final response = await http.post(
        Uri.parse('$api/purchases'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        SsAlert.showAutoDismissSnackbar(
          appRouter.navigatorKey.currentContext!,
          Colors.green,
          'Compra realizada con éxito',
        );
        appRouter.popAndPush(const HomeRoute());
      } else {
        SsAlert.showAutoDismissSnackbar(
          appRouter.navigatorKey.currentContext!,
          Colors.red,
          'Error al realizar la compra: ${response.statusCode}',
        );
      }
    } catch (e) {
      SsAlert.showAutoDismissSnackbar(
        appRouter.navigatorKey.currentContext!,
        Colors.red,
        'Error al realizar la compra: $e',
      );
    }
  }

  Future<ProductModel?> searchProduct(String barcode) async {
    final response = await http.get(
      Uri.parse('$api/products/$barcode'),
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
      SsAlert.showAutoDismissSnackbar(
        appRouter.navigatorKey.currentContext!,
        Colors.red,
        'Producto no encontrado',
      );
      return null;
    }
  }

  Future<void> addProduct({
    required String name,
    required String barcode,
    required double purchasePrice,
    required double salePrice,
    required String urlImage,
  }) async {
    state = state.copyWith(loadingHome: true);
    try {
      final response = await http.post(
        Uri.parse('$api/products'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
        body: jsonEncode({
          "name": name,
          "barCode": barcode,
          "purchasePrice": purchasePrice,
          "salePrice": salePrice,
          "urlImage": urlImage,
        }),
      );

      if (response.statusCode == 201) {
        SsAlert.showAutoDismissSnackbar(
          appRouter.navigatorKey.currentContext!,
          Colors.green,
          'Producto registrado con éxito',
        );
      } else {
        SsAlert.showAutoDismissSnackbar(appRouter.navigatorKey.currentContext!,
            Colors.green, 'Error al registrar el producto');
      }
    } catch (e) {
      SsAlert.showAutoDismissSnackbar(
        appRouter.navigatorKey.currentContext!,
        Colors.red,
        'Error al registrar el producto: $e',
      );
    } finally {
      state = state.copyWith(loadingHome: false);
    }
  }

  Future<void> updateProduct({
    required int id,
    required String name,
    required String barcode,
    required double purchasePrice,
    required double salePrice,
    required String urlImage,
  }) async {
    state = state.copyWith(loadingHome: true);
    try {
      final response = await http.put(
        Uri.parse('$api/products'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
        body: jsonEncode({
          "id": id,
          "name": name,
          "barCode": barcode,
          "purchasePrice": purchasePrice,
          "salePrice": salePrice,
          "urlImage": urlImage,
        }),
      );
      if (response.statusCode == 200) {
        SsAlert.showAutoDismissSnackbar(
          appRouter.navigatorKey.currentContext!,
          Colors.green,
          'Producto registrado con éxito',
        );
      } else {
        SsAlert.showAutoDismissSnackbar(appRouter.navigatorKey.currentContext!,
            Colors.green, 'Error al registrar el producto');
      }
    } catch (e) {
      SsAlert.showAutoDismissSnackbar(
        appRouter.navigatorKey.currentContext!,
        Colors.red,
        'Error al registrar el producto: $e',
      );
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
        Uri.parse('http://$api:8080/sales'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "saleDetails": saleDetailsJson,
        }),
      );
      if (response.statusCode != 200) {
        SsAlert.showAutoDismissSnackbar(
          appRouter.navigatorKey.currentContext!,
          Colors.red,
          'Error al enviar la venta: ${response.body}',
        );
      }
    } catch (e) {
      SsAlert.showAutoDismissSnackbar(
        appRouter.navigatorKey.currentContext!,
        Colors.red,
        'Error al enviar la venta: $e',
      );
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

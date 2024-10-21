import 'dart:convert';

import 'package:facturacion/routes/app_router.dart';
import 'package:http/http.dart' as http;

import 'package:facturacion/models/product_model.dart';
import 'package:facturacion/pages/app_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthSignUpNotifier extends StateNotifier<AppState> {
  AuthSignUpNotifier() : super(AppState());
  final ip = '192.168.1.74';

  Future<void> fetchData({loading = true}) async {
    if (loading) {
      state = state.copyWith(loadingHome: true);
    }
    final response = await http.get(
      Uri.parse('http://$ip:8080/products'),
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

  Future<void> addProduct({
    required String name,
    required int stock,
    required String barcode,
    required String description,
    required double price,
  }) async {
    state = state.copyWith(loadingHome: true);
    try {
      final response = await http.post(
        Uri.parse('http://$ip:8080/products'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "name": name,
          "stock": stock,
          "barCode": barcode,
          "salePrice": price,
        }),
      );
      if (response.statusCode == 201) {
        print('Post created successfully');
        await fetchData(loading: false);
        await appRouter.maybePop();
      } else {
        print('Failed to create post');
      }
    } catch (e) {
      print(e);
    } finally {
      state = state.copyWith(loadingHome: false);
    }
  }

  Future<void> sales({
    required List products,
    required int stock,
    required String barcode,
    required String description,
    required double price,
  }) async {
    state = state.copyWith(loadingHome: true);
    try {
      final response = await http.post(
        Uri.parse('http://$ip:8080/products'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          // "name": name,
          // "stock": stock,
          // "barCode": barcode,
          // "salePrice": price,
        }),
      );
      if (response.statusCode == 201) {
        print('Post created successfully');
        await fetchData(loading: false);
        await appRouter.maybePop();
      } else {
        print('Failed to create post');
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
  final String idProduct;
  final int quantity;

  SaleModel({
    required this.idProduct,
    required this.quantity,
  });

  SaleModel copyWith({
    String? idProduct,
    int? quantity,
  }) {
    return SaleModel(
      idProduct: idProduct ?? this.idProduct,
      quantity: quantity ?? this.quantity,
    );
  }
}

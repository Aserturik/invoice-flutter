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
    // final response = await http.get(
    //   Uri.parse('http://$ip:8080/products'),
    // );
    // if (response.statusCode == 200) {
    //   final jsonData = jsonDecode(response.body);
    //   List<dynamic> productsJson = jsonData['content'];
    //   List<ProductModel> products = ProductModel.fromJsonList(productsJson);
    //   state = state.copyWith(
    //     products: products,
    //   );
    //   print('Productos cargados correctamente');
    // } else {
    //   print('Failed to fetch products');
    // }
    final products = [
      ProductModel(
        id: 1,
        name: 'Producto 1',
        stock: 10,
        barCode: '123456789',
        salePrice: 100.0,
      ),
      ProductModel(
        id: 1,
        name: 'Producto 3',
        stock: 10,
        barCode: '123456789',
        salePrice: 100.0,
      ),
      ProductModel(
        id: 1,
        name: 'Producto 2',
        stock: 10,
        barCode: '123456789',
        salePrice: 100.0,
      )
    ];
    state = state.copyWith(
      products: products,
    );
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
    required List<SaleModel> sales,
  }) async {
    state = state.copyWith(loadingHome: true);
    try {
      List<Map<String, dynamic>> saleDetailsJson =
          sales.map((sale) => sale.toJson()).toList();
      final response = await http.post(
        Uri.parse('http://$ip:8080/sales'),
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
        Uri.parse('http://$ip:8080/sales'),
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

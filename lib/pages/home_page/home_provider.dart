import 'dart:convert';

import 'package:facturacion/models/client_model.dart';
import 'package:facturacion/models/sale_model.dart';
import 'package:facturacion/pages/home_page/home_state.dart';
import 'package:facturacion/shared/constants/constants.dart';
import 'package:facturacion/widgets/ss_alert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum HomePages {
  products,
  clientes,
  invoice,
}

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier() : super(HomeState());

  setPage(HomePages page) {
    state = state.copyWith(page: page);
  }

  Future<void> fetchDataClients({loading = true}) async {
    state = state.copyWith(loadingClients: true);
    final response = await http.get(
      Uri.parse('$api/people'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List<dynamic> clientsJson = jsonData['content'];
      List<ClientModel> clients = ClientModel.fromJsonList(clientsJson);
      state = state.copyWith(
        clients: clients,
      );
      print('Clientes cargados correctamente');
    } else {
      print('Failed to fetch products');
    }
    state = state.copyWith(loadingClients: false);
  }

  Future<void> fetchDataSales({bool loading = true}) async {
    state = state.copyWith(loadingClients: true);
    try {
      final response = await http.get(
        Uri.parse('$api/sales'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        List<dynamic> salesJson = jsonData['content'];
        List<SaleModel> sales = SaleModel.fromJsonList(salesJson);

        state = state.copyWith(
          sale: sales,
        );
        print('Ventas cargadas correctamente');
      } else {
        print('Error al cargar ventas: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al cargar ventas: $e');
    } finally {
      state = state.copyWith(loadingClients: false);
    }
  }

  Future<void> addClient(
      {loading = true,
      required ClientModel client,
      required BuildContext context}) async {
    try {
      final response = await http.post(
        Uri.parse('$api/people'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
        body: jsonEncode({
          "name": client.name,
          "documentNumber": client.documentNumber,
          "documentType": client.documentType,
          "email": client.email,
          "phone": client.phone,
        }),
      );

      if (response.statusCode == 201) {
        SsAlert.showAutoDismissSnackbar(
            // ignore: use_build_context_synchronously
            context,
            Colors.green,
            'Cliente registrado con éxito');
      } else {
        // Error en el registro
        SsAlert.showAutoDismissSnackbar(
            // ignore: use_build_context_synchronously
            context,
            Colors.red,
            'Error al registrar el cliente');
      }
    } catch (e) {
      print(e);
    }
  }
}

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier();
});

import 'dart:convert';

import 'package:facturacion/models/buy_model.dart';
import 'package:facturacion/models/client_model.dart';
import 'package:facturacion/models/sale_model.dart';
import 'package:facturacion/pages/home_page/home_state.dart';
import 'package:facturacion/routes/app_router.dart';
import 'package:facturacion/shared/constants/constants.dart';
import 'package:facturacion/widgets/ss_alert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum HomePages {
  products,
  clientes,
  invoice,
  buy,
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
    } else {
      SsAlert.showAutoDismissSnackbar(
        appRouter.navigatorKey.currentContext!,
        Colors.red,
        'Error al cargar los clientes',
      );
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
          sales: sales,
        );
        SsAlert.showAutoDismissSnackbar(
          appRouter.navigatorKey.currentContext!,
          Colors.green,
          'Ventas cargadas con éxito',
        );
      } else {
        SsAlert.showAutoDismissSnackbar(
          appRouter.navigatorKey.currentContext!,
          Colors.red,
          'Error al cargar las ventas',
        );
      }
    } catch (e) {
      SsAlert.showAutoDismissSnackbar(
        appRouter.navigatorKey.currentContext!,
        Colors.red,
        'Error al cargar las ventas: $e',
      );
    } finally {
      state = state.copyWith(loadingClients: false);
    }
  }

  Future<void> fetchDataBuys({bool loading = true}) async {
    state = state.copyWith(loadingClients: true);
    try {
      final response = await http.get(
        Uri.parse('$api/purchases'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        // Extraemos la lista de compras del JSON
        List<dynamic> buysJson = jsonData['content'];
        // Convertimos la lista de JSON a objetos BuyModel
        List<BuyModel> buys = BuyModel.fromJsonList(buysJson);

        state = state.copyWith(
          buys: buys, // Actualizamos el estado con las compras obtenidas
        );

        SsAlert.showAutoDismissSnackbar(
          appRouter.navigatorKey.currentContext!,
          Colors.green,
          'Compras cargadas con éxito',
        );
      } else {
        SsAlert.showAutoDismissSnackbar(
          appRouter.navigatorKey.currentContext!,
          Colors.red,
          'Error al cargar las compras',
        );
      }
    } catch (e) {
      SsAlert.showAutoDismissSnackbar(
        appRouter.navigatorKey.currentContext!,
        Colors.red,
        'Error al cargar las compras: $e',
      );
    } finally {
      state = state.copyWith(loadingClients: false);
    }
  }

  Future<void> addClient({
    loading = true,
    required ClientModel client,
  }) async {
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
          appRouter.navigatorKey.currentContext!,
          Colors.green,
          'Cliente registrado con éxito',
        );
      } else {
        SsAlert.showAutoDismissSnackbar(
          appRouter.navigatorKey.currentContext!,
          Colors.red,
          'Error al registrar el cliente',
        );
      }
    } catch (e) {
      SsAlert.showAutoDismissSnackbar(
        appRouter.navigatorKey.currentContext!,
        Colors.red,
        'Error al registrar el cliente: $e',
      );
    }
  }

  Future<void> updateClient({
    loading = true,
    required ClientModel client,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$api/people'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
        body: jsonEncode({
          "id": client.id,
          "name": client.name,
          "documentNumber": client.documentNumber,
          "documentType": client.documentType,
          "email": client.email,
          "phone": client.phone,
        }),
      );
      if (response.statusCode == 200) {
        SsAlert.showAutoDismissSnackbar(
          appRouter.navigatorKey.currentContext!,
          Colors.green,
          'Cliente registrado con éxito',
        );
      } else {
        SsAlert.showAutoDismissSnackbar(
          appRouter.navigatorKey.currentContext!,
          Colors.red,
          'Error al registrar el cliente',
        );
      }
    } catch (e) {
      SsAlert.showAutoDismissSnackbar(
        appRouter.navigatorKey.currentContext!,
        Colors.red,
        'Error al registrar el cliente: $e',
      );
    }
  }
}

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier();
});

import 'package:facturacion/models/client_model.dart';
import 'package:facturacion/models/sale_model.dart';
import 'package:facturacion/pages/home_page/home_provider.dart';

class HomeState {
  final HomePages? page;
  final List<ClientModel>? clients;
  final bool loadingClients;
  final List<SaleModel>? sales;

  HomeState({
    this.page = HomePages.products,
    this.loadingClients = false,
    this.clients,
    this.sales,
  });

  HomeState copyWith({
    HomePages? page,
    List<ClientModel>? clients,
    bool? loadingClients,
    List<SaleModel>? sale,
  }) {
    return HomeState(
      page: page ?? this.page,
      clients: clients ?? this.clients,
      loadingClients: loadingClients ?? this.loadingClients,
      sales: sale ?? this.sales,
    );
  }
}

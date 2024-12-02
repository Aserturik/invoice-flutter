import 'package:facturacion/models/buy_model.dart';
import 'package:facturacion/models/client_model.dart';
import 'package:facturacion/models/sale_model.dart';
import 'package:facturacion/pages/home_page/home_provider.dart';

class HomeState {
  final HomePages? page;
  final List<ClientModel>? clients;
  final bool loadingClients;
  final List<SaleModel>? sales;
  final List<BuyModel>? buys;

  HomeState({
    this.page = HomePages.products,
    this.loadingClients = false,
    this.clients,
    this.sales,
    this.buys,
  });

  HomeState copyWith({
    HomePages? page,
    List<ClientModel>? clients,
    bool? loadingClients,
    List<SaleModel>? sales,
    List<BuyModel>? buys,
  }) {
    return HomeState(
      page: page ?? this.page,
      clients: clients ?? this.clients,
      loadingClients: loadingClients ?? this.loadingClients,
      sales: sales ?? this.sales,
      buys: buys ?? this.buys,
    );
  }
}

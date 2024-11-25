import 'package:facturacion/pages/home_page/home_state.dart';
// import 'package:http/http.dart' as http;
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
}

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier();
});

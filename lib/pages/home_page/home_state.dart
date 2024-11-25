import 'package:facturacion/pages/home_page/home_provider.dart';

class HomeState {
  final HomePages? page;

  HomeState({
    this.page = HomePages.products,
  });

  HomeState copyWith({
    HomePages? page,
  }) {
    return HomeState(
      page: page ?? this.page,
    );
  }
}

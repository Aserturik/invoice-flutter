import 'package:facturacion/models/product_model.dart';

class AppState {
  final List<ProductModel>? products;
  final bool loadingHome;

  AppState({
    this.products,
    this.loadingHome = false,
  });

  AppState copyWith({
    List<ProductModel>? products,
    bool? loadingHome,
  }) {
    return AppState(
      products: products ?? this.products,
      loadingHome: loadingHome ?? this.loadingHome,
    );
  }
}

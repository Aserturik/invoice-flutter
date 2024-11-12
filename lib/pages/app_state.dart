import 'package:facturacion/models/product_model.dart';

class AppState {
  final List<ProductModel>? products;
  final bool loadingHome;
  final ProductModel? product;

  AppState({
    this.products,
    this.loadingHome = false,
    this.product,
  });

  AppState copyWith({
    List<ProductModel>? products,
    bool? loadingHome,
    ProductModel? product,
  }) {
    return AppState(
      products: products ?? this.products,
      loadingHome: loadingHome ?? this.loadingHome,
      product: product ?? this.product,
    );
  }
}

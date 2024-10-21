// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:facturacion/models/product_model.dart' as _i6;
import 'package:facturacion/pages/home_page.dart' as _i1;
import 'package:facturacion/pages/product_add_page.dart' as _i2;
import 'package:facturacion/pages/product_edit_page.dart' as _i3;
import 'package:facturacion/pages/sales/sale_page.dart' as _i4;
import 'package:flutter/material.dart' as _i7;

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.HomePage();
    },
  );
}

/// generated route for
/// [_i2.ProductAddPage]
class ProductAddRoute extends _i5.PageRouteInfo<void> {
  const ProductAddRoute({List<_i5.PageRouteInfo>? children})
      : super(
          ProductAddRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProductAddRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.ProductAddPage();
    },
  );
}

/// generated route for
/// [_i3.ProductEditPage]
class ProductEditRoute extends _i5.PageRouteInfo<ProductEditRouteArgs> {
  ProductEditRoute({
    required _i6.ProductModel product,
    _i7.Key? key,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          ProductEditRoute.name,
          args: ProductEditRouteArgs(
            product: product,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductEditRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductEditRouteArgs>();
      return _i3.ProductEditPage(
        product: args.product,
        key: args.key,
      );
    },
  );
}

class ProductEditRouteArgs {
  const ProductEditRouteArgs({
    required this.product,
    this.key,
  });

  final _i6.ProductModel product;

  final _i7.Key? key;

  @override
  String toString() {
    return 'ProductEditRouteArgs{product: $product, key: $key}';
  }
}

/// generated route for
/// [_i4.SalePage]
class SaleRoute extends _i5.PageRouteInfo<void> {
  const SaleRoute({List<_i5.PageRouteInfo>? children})
      : super(
          SaleRoute.name,
          initialChildren: children,
        );

  static const String name = 'SaleRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.SalePage();
    },
  );
}

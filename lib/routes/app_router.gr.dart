// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:facturacion/models/product_model.dart' as _i8;
import 'package:facturacion/pages/auth/auth_sign_in_page.dart' as _i1;
import 'package:facturacion/pages/home_page.dart' as _i2;
import 'package:facturacion/pages/product_add_page.dart' as _i3;
import 'package:facturacion/pages/product_edit_page.dart' as _i4;
import 'package:facturacion/pages/sales/sale_page.dart' as _i5;
import 'package:flutter/material.dart' as _i7;

/// generated route for
/// [_i1.AuthSignInPage]
class AuthSignInRoute extends _i6.PageRouteInfo<void> {
  const AuthSignInRoute({List<_i6.PageRouteInfo>? children})
      : super(
          AuthSignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthSignInRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i1.AuthSignInPage();
    },
  );
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute({List<_i6.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomePage();
    },
  );
}

/// generated route for
/// [_i3.ProductAddPage]
class ProductAddRoute extends _i6.PageRouteInfo<ProductAddRouteArgs> {
  ProductAddRoute({
    String? barcode,
    _i7.Key? key,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          ProductAddRoute.name,
          args: ProductAddRouteArgs(
            barcode: barcode,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductAddRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductAddRouteArgs>(
          orElse: () => const ProductAddRouteArgs());
      return _i3.ProductAddPage(
        barcode: args.barcode,
        key: args.key,
      );
    },
  );
}

class ProductAddRouteArgs {
  const ProductAddRouteArgs({
    this.barcode,
    this.key,
  });

  final String? barcode;

  final _i7.Key? key;

  @override
  String toString() {
    return 'ProductAddRouteArgs{barcode: $barcode, key: $key}';
  }
}

/// generated route for
/// [_i4.ProductEditPage]
class ProductEditRoute extends _i6.PageRouteInfo<ProductEditRouteArgs> {
  ProductEditRoute({
    required _i8.ProductModel? product,
    _i7.Key? key,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          ProductEditRoute.name,
          args: ProductEditRouteArgs(
            product: product,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductEditRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductEditRouteArgs>();
      return _i4.ProductEditPage(
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

  final _i8.ProductModel? product;

  final _i7.Key? key;

  @override
  String toString() {
    return 'ProductEditRouteArgs{product: $product, key: $key}';
  }
}

/// generated route for
/// [_i5.SalePage]
class SaleRoute extends _i6.PageRouteInfo<void> {
  const SaleRoute({List<_i6.PageRouteInfo>? children})
      : super(
          SaleRoute.name,
          initialChildren: children,
        );

  static const String name = 'SaleRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i5.SalePage();
    },
  );
}

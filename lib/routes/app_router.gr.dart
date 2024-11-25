// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:facturacion/models/product_model.dart' as _i10;
import 'package:facturacion/models/sale_details_model.dart' as _i11;
import 'package:facturacion/pages/auth/auth_sign_in_page.dart' as _i1;
import 'package:facturacion/pages/client/client_add_page.dart' as _i2;
import 'package:facturacion/pages/home_page/home_page.dart' as _i3;
import 'package:facturacion/pages/product_add_page.dart' as _i4;
import 'package:facturacion/pages/product_edit_page.dart' as _i5;
import 'package:facturacion/pages/sales/sale_details_page.dart' as _i6;
import 'package:facturacion/pages/sales/sale_page.dart' as _i7;
import 'package:flutter/material.dart' as _i9;

/// generated route for
/// [_i1.AuthSignInPage]
class AuthSignInRoute extends _i8.PageRouteInfo<void> {
  const AuthSignInRoute({List<_i8.PageRouteInfo>? children})
      : super(
          AuthSignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthSignInRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i1.AuthSignInPage();
    },
  );
}

/// generated route for
/// [_i2.ClientAddPage]
class ClientAddRoute extends _i8.PageRouteInfo<void> {
  const ClientAddRoute({List<_i8.PageRouteInfo>? children})
      : super(
          ClientAddRoute.name,
          initialChildren: children,
        );

  static const String name = 'ClientAddRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i2.ClientAddPage();
    },
  );
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute({List<_i8.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomePage();
    },
  );
}

/// generated route for
/// [_i4.ProductAddPage]
class ProductAddRoute extends _i8.PageRouteInfo<ProductAddRouteArgs> {
  ProductAddRoute({
    String? barcode,
    _i9.Key? key,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          ProductAddRoute.name,
          args: ProductAddRouteArgs(
            barcode: barcode,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductAddRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductAddRouteArgs>(
          orElse: () => const ProductAddRouteArgs());
      return _i4.ProductAddPage(
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

  final _i9.Key? key;

  @override
  String toString() {
    return 'ProductAddRouteArgs{barcode: $barcode, key: $key}';
  }
}

/// generated route for
/// [_i5.ProductEditPage]
class ProductEditRoute extends _i8.PageRouteInfo<ProductEditRouteArgs> {
  ProductEditRoute({
    required _i10.ProductModel? product,
    _i9.Key? key,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          ProductEditRoute.name,
          args: ProductEditRouteArgs(
            product: product,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductEditRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductEditRouteArgs>();
      return _i5.ProductEditPage(
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

  final _i10.ProductModel? product;

  final _i9.Key? key;

  @override
  String toString() {
    return 'ProductEditRouteArgs{product: $product, key: $key}';
  }
}

/// generated route for
/// [_i6.SaleDetailsPage]
class SaleDetailsRoute extends _i8.PageRouteInfo<SaleDetailsRouteArgs> {
  SaleDetailsRoute({
    required List<_i11.SaleDetailsModel> saleDetails,
    _i9.Key? key,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          SaleDetailsRoute.name,
          args: SaleDetailsRouteArgs(
            saleDetails: saleDetails,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'SaleDetailsRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SaleDetailsRouteArgs>();
      return _i6.SaleDetailsPage(
        saleDetails: args.saleDetails,
        key: args.key,
      );
    },
  );
}

class SaleDetailsRouteArgs {
  const SaleDetailsRouteArgs({
    required this.saleDetails,
    this.key,
  });

  final List<_i11.SaleDetailsModel> saleDetails;

  final _i9.Key? key;

  @override
  String toString() {
    return 'SaleDetailsRouteArgs{saleDetails: $saleDetails, key: $key}';
  }
}

/// generated route for
/// [_i7.SalePage]
class SaleRoute extends _i8.PageRouteInfo<void> {
  const SaleRoute({List<_i8.PageRouteInfo>? children})
      : super(
          SaleRoute.name,
          initialChildren: children,
        );

  static const String name = 'SaleRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i7.SalePage();
    },
  );
}

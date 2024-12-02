// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:facturacion/models/buy_details_model.dart' as _i17;
import 'package:facturacion/models/client_model.dart' as _i15;
import 'package:facturacion/models/product_model.dart' as _i16;
import 'package:facturacion/models/sale_details_model.dart' as _i13;
import 'package:facturacion/pages/auth/auth_sign_in_page.dart' as _i1;
import 'package:facturacion/pages/auth/auth_sign_up_page.dart' as _i2;
import 'package:facturacion/pages/buy/buy_details_page.dart' as _i3;
import 'package:facturacion/pages/buy/buy_page.dart' as _i4;
import 'package:facturacion/pages/client/client_add_page.dart' as _i5;
import 'package:facturacion/pages/home_page/home_page.dart' as _i6;
import 'package:facturacion/pages/product_add_page.dart' as _i7;
import 'package:facturacion/pages/product_edit_page.dart' as _i8;
import 'package:facturacion/pages/purchase/purchase_page.dart' as _i9;
import 'package:facturacion/pages/sales/sale_details_page.dart' as _i10;
import 'package:facturacion/pages/sales/sale_page.dart' as _i11;
import 'package:flutter/material.dart' as _i14;

/// generated route for
/// [_i1.AuthSignInPage]
class AuthSignInRoute extends _i12.PageRouteInfo<void> {
  const AuthSignInRoute({List<_i12.PageRouteInfo>? children})
      : super(
          AuthSignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthSignInRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i1.AuthSignInPage();
    },
  );
}

/// generated route for
/// [_i2.AuthSignUpPage]
class AuthSignUpRoute extends _i12.PageRouteInfo<void> {
  const AuthSignUpRoute({List<_i12.PageRouteInfo>? children})
      : super(
          AuthSignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthSignUpRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i2.AuthSignUpPage();
    },
  );
}

/// generated route for
/// [_i3.BuyDetailsPage]
class BuyDetailsRoute extends _i12.PageRouteInfo<BuyDetailsRouteArgs> {
  BuyDetailsRoute({
    required List<_i13.SaleDetailsModel> saleDetails,
    _i14.Key? key,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          BuyDetailsRoute.name,
          args: BuyDetailsRouteArgs(
            saleDetails: saleDetails,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'BuyDetailsRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<BuyDetailsRouteArgs>();
      return _i3.BuyDetailsPage(
        saleDetails: args.saleDetails,
        key: args.key,
      );
    },
  );
}

class BuyDetailsRouteArgs {
  const BuyDetailsRouteArgs({
    required this.saleDetails,
    this.key,
  });

  final List<_i13.SaleDetailsModel> saleDetails;

  final _i14.Key? key;

  @override
  String toString() {
    return 'BuyDetailsRouteArgs{saleDetails: $saleDetails, key: $key}';
  }
}

/// generated route for
/// [_i4.BuyPage]
class BuyRoute extends _i12.PageRouteInfo<void> {
  const BuyRoute({List<_i12.PageRouteInfo>? children})
      : super(
          BuyRoute.name,
          initialChildren: children,
        );

  static const String name = 'BuyRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i4.BuyPage();
    },
  );
}

/// generated route for
/// [_i5.ClientAddPage]
class ClientAddRoute extends _i12.PageRouteInfo<ClientAddRouteArgs> {
  ClientAddRoute({
    _i15.ClientModel? client,
    _i14.Key? key,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          ClientAddRoute.name,
          args: ClientAddRouteArgs(
            client: client,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ClientAddRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ClientAddRouteArgs>(
          orElse: () => const ClientAddRouteArgs());
      return _i5.ClientAddPage(
        client: args.client,
        key: args.key,
      );
    },
  );
}

class ClientAddRouteArgs {
  const ClientAddRouteArgs({
    this.client,
    this.key,
  });

  final _i15.ClientModel? client;

  final _i14.Key? key;

  @override
  String toString() {
    return 'ClientAddRouteArgs{client: $client, key: $key}';
  }
}

/// generated route for
/// [_i6.HomePage]
class HomeRoute extends _i12.PageRouteInfo<void> {
  const HomeRoute({List<_i12.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i6.HomePage();
    },
  );
}

/// generated route for
/// [_i7.ProductAddPage]
class ProductAddRoute extends _i12.PageRouteInfo<ProductAddRouteArgs> {
  ProductAddRoute({
    String? barcode,
    _i14.Key? key,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          ProductAddRoute.name,
          args: ProductAddRouteArgs(
            barcode: barcode,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductAddRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductAddRouteArgs>(
          orElse: () => const ProductAddRouteArgs());
      return _i7.ProductAddPage(
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

  final _i14.Key? key;

  @override
  String toString() {
    return 'ProductAddRouteArgs{barcode: $barcode, key: $key}';
  }
}

/// generated route for
/// [_i8.ProductEditPage]
class ProductEditRoute extends _i12.PageRouteInfo<ProductEditRouteArgs> {
  ProductEditRoute({
    required _i16.ProductModel? product,
    _i14.Key? key,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          ProductEditRoute.name,
          args: ProductEditRouteArgs(
            product: product,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductEditRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductEditRouteArgs>();
      return _i8.ProductEditPage(
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

  final _i16.ProductModel? product;

  final _i14.Key? key;

  @override
  String toString() {
    return 'ProductEditRouteArgs{product: $product, key: $key}';
  }
}

/// generated route for
/// [_i9.PurchasePage]
class PurchaseRoute extends _i12.PageRouteInfo<PurchaseRouteArgs> {
  PurchaseRoute({
    required List<_i17.BuyDetailsModel> saleDetails,
    _i14.Key? key,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          PurchaseRoute.name,
          args: PurchaseRouteArgs(
            saleDetails: saleDetails,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'PurchaseRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PurchaseRouteArgs>();
      return _i9.PurchasePage(
        saleDetails: args.saleDetails,
        key: args.key,
      );
    },
  );
}

class PurchaseRouteArgs {
  const PurchaseRouteArgs({
    required this.saleDetails,
    this.key,
  });

  final List<_i17.BuyDetailsModel> saleDetails;

  final _i14.Key? key;

  @override
  String toString() {
    return 'PurchaseRouteArgs{saleDetails: $saleDetails, key: $key}';
  }
}

/// generated route for
/// [_i10.SaleDetailsPage]
class SaleDetailsRoute extends _i12.PageRouteInfo<SaleDetailsRouteArgs> {
  SaleDetailsRoute({
    required List<_i13.SaleDetailsModel> saleDetails,
    _i14.Key? key,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          SaleDetailsRoute.name,
          args: SaleDetailsRouteArgs(
            saleDetails: saleDetails,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'SaleDetailsRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SaleDetailsRouteArgs>();
      return _i10.SaleDetailsPage(
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

  final List<_i13.SaleDetailsModel> saleDetails;

  final _i14.Key? key;

  @override
  String toString() {
    return 'SaleDetailsRouteArgs{saleDetails: $saleDetails, key: $key}';
  }
}

/// generated route for
/// [_i11.SalePage]
class SaleRoute extends _i12.PageRouteInfo<void> {
  const SaleRoute({List<_i12.PageRouteInfo>? children})
      : super(
          SaleRoute.name,
          initialChildren: children,
        );

  static const String name = 'SaleRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i11.SalePage();
    },
  );
}

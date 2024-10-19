// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:facturacion/pages/home_page.dart' as _i1;
import 'package:facturacion/pages/product_add_page.dart' as _i2;
import 'package:facturacion/pages/product_edit_page.dart' as _i3;

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute({List<_i4.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.HomePage();
    },
  );
}

/// generated route for
/// [_i2.ProductAddPage]
class ProductAddRoute extends _i4.PageRouteInfo<void> {
  const ProductAddRoute({List<_i4.PageRouteInfo>? children})
      : super(
          ProductAddRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProductAddRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.ProductAddPage();
    },
  );
}

/// generated route for
/// [_i3.ProductEditPage]
class ProductEditRoute extends _i4.PageRouteInfo<void> {
  const ProductEditRoute({List<_i4.PageRouteInfo>? children})
      : super(
          ProductEditRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProductEditRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.ProductEditPage();
    },
  );
}

import 'package:auto_route/auto_route.dart';
import 'package:facturacion/routes/app_router.dart';
import 'package:facturacion/routes/app_router.gr.dart';

final pageRoute = [
  CustomRoute(page: HomeRoute.page, initial: true),
  SsRoute(page: ProductAddRoute.page),
  SsRoute(page: ProductEditRoute.page)
];

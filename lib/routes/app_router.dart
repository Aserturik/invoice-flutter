import 'package:auto_route/auto_route.dart';
import 'package:facturacion/pages/auth/auth_route.dart';
import 'package:facturacion/pages/client/client_route.dart';
import 'package:facturacion/pages/pages_route.dart';
import 'package:facturacion/pages/sales/sales_route.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        ...pageRoute,
        ...authRoute,
        ...salesRoute,
        ...clientRoute,
      ];
}

class SsRoute extends CustomRoute {
  SsRoute({required super.page, super.children, super.guards, h})
      : super(
          transitionsBuilder: TransitionsBuilders.noTransition,
        );
}

final appRouter = AppRouter();

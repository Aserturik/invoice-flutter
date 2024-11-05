import 'package:auto_route/auto_route.dart';
import 'package:facturacion/pages/pages_route.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [...pageRoute];
}

class SsRoute extends CustomRoute {
  SsRoute({
    required super.page,
    super.children,
    super.guards,
  }) : super(
          transitionsBuilder: TransitionsBuilders.noTransition,
        );
}

final appRouter = AppRouter();

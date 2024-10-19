import 'package:auto_route/auto_route.dart';
import 'package:facturacion/pages/pages_route.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [...pageRoute];

  // bool contain(PageInfo page) {
  //   return appRouter.stack.any((e) => e.name == page.name);
  // }

  // bool currentIs(PageInfo page) {
  //   return appRouter.current.name == page.name;
  // }

  // Future<void> pushAndPopUntilTo(PageRouteInfo page) async {
  //   await appRouter.pushAndPopUntil(
  //     page,
  //     predicate: (route) => route.settings.name == HomeRoute.name,
  //   );
  // }

  // Future<void> popUntilHome() async {
  //   await appRouter.pushAndPopUntil(
  //     const HomeRoute(),
  //     predicate: (route) => false,
  //   );
  // }
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

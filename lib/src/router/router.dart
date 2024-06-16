import 'package:auto_route/auto_route.dart';
import 'package:profair/src/router/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(page: HomeRoute.page, path: "/", transitionsBuilder: TransitionsBuilders.noTransition),
        CustomRoute(page: Wallet.page, path: "/wallet", transitionsBuilder: TransitionsBuilders.noTransition),
        CustomRoute(page: Operation.page, path: "/operations", transitionsBuilder: TransitionsBuilders.noTransition),
        CustomRoute(page: ActionRoute.page, path: "/action", transitionsBuilder: TransitionsBuilders.noTransition)
      ];
}

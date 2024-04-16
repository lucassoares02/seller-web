import 'package:auto_route/auto_route.dart';
import 'package:profair/src/guards/auto_guard.dart';
import 'package:profair/src/router/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  final AuthGuard authGuard = AuthGuard();
  @override
  List<AutoRoute> get routes => [
        CustomRoute(page: SplashRoute.page, initial: true, path: "/splash", transitionsBuilder: TransitionsBuilders.noTransition),
        CustomRoute(page: LoginRoute.page, path: "/login", transitionsBuilder: TransitionsBuilders.noTransition),
        CustomRoute(page: CountRoute.page, path: "/counter", transitionsBuilder: TransitionsBuilders.noTransition),
        CustomRoute(
            guards: [authGuard],
            page: App.page,
            path: "/app",
            transitionsBuilder: TransitionsBuilders.noTransition,
            children: [
              CustomRoute(page: HomeRoute.page, path: "home", transitionsBuilder: TransitionsBuilders.noTransition),
              CustomRoute(page: Providers.page, path: "providers", transitionsBuilder: TransitionsBuilders.noTransition),
              CustomRoute(page: Reports.page, path: "reports", transitionsBuilder: TransitionsBuilders.noTransition),
              CustomRoute(page: Clients.page, path: "clients", transitionsBuilder: TransitionsBuilders.noTransition),
              CustomRoute(page: ListAttractions.page, path: "listattractions", transitionsBuilder: TransitionsBuilders.noTransition),
              CustomRoute(page: RequestsStores.page, path: "requeststores", transitionsBuilder: TransitionsBuilders.noTransition),
              CustomRoute(page: DetailsAttractions.page, path: "detailsattractions", transitionsBuilder: TransitionsBuilders.noTransition),
              CustomRoute(page: ProductsProvider.page, path: "productsprovider", transitionsBuilder: TransitionsBuilders.noTransition),
              CustomRoute(page: SelectNegotiation.page, path: "selectnegotiation", transitionsBuilder: TransitionsBuilders.noTransition),
              CustomRoute(page: Settings.page, path: "settings", transitionsBuilder: TransitionsBuilders.noTransition),
              CustomRoute(page: Upload.page, path: "upload", transitionsBuilder: TransitionsBuilders.noTransition),
              CustomRoute(page: Download.page, path: "download", transitionsBuilder: TransitionsBuilders.noTransition),
              CustomRoute(page: Users.page, path: "users", transitionsBuilder: TransitionsBuilders.noTransition),
              CustomRoute(page: RequestClient.page, path: "requestclient", transitionsBuilder: TransitionsBuilders.noTransition),
            ]),
      ];
}

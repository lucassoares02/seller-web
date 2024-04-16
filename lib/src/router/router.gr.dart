// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i20;
import 'package:flutter/material.dart' as _i21;
import 'package:profair/src/models/login_model.dart' as _i23;
import 'package:profair/src/views/app.dart' as _i1;
import 'package:profair/src/views/clients/clients.dart' as _i2;
import 'package:profair/src/views/count/count.dart' as _i3;
import 'package:profair/src/views/details_attraction/details_attraction.dart'
    as _i4;
import 'package:profair/src/views/download/download.dart' as _i5;
import 'package:profair/src/views/home/home.dart' as _i6;
import 'package:profair/src/views/home/home_controller.dart' as _i22;
import 'package:profair/src/views/list_attractions/list_attractions.dart'
    as _i7;
import 'package:profair/src/views/login/login.dart' as _i8;
import 'package:profair/src/views/products_provider/products_provider.dart'
    as _i9;
import 'package:profair/src/views/providers/providers.dart' as _i10;
import 'package:profair/src/views/reports/reports.dart' as _i11;
import 'package:profair/src/views/request_client/request_client.dart' as _i12;
import 'package:profair/src/views/requests_stores/requests_stores.dart' as _i13;
import 'package:profair/src/views/select_negotiation/select_negotiation.dart'
    as _i14;
import 'package:profair/src/views/select_store/select_store.dart' as _i15;
import 'package:profair/src/views/settings/settings.dart' as _i16;
import 'package:profair/src/views/splash/splash.dart' as _i17;
import 'package:profair/src/views/upload/upload.dart' as _i18;
import 'package:profair/src/views/users/users.dart' as _i19;

abstract class $AppRouter extends _i20.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i20.PageFactory> pagesMap = {
    App.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.App(),
      );
    },
    Clients.name: (routeData) {
      final args = routeData.argsAs<ClientsArgs>();
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.Clients(
          key: args.key,
          codeProvider: args.codeProvider,
          accessTargenting: args.accessTargenting,
          merchandise: args.merchandise,
          trading: args.trading,
        ),
      );
    },
    CountRoute.name: (routeData) {
      final args = routeData.argsAs<CountRouteArgs>();
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.CountPage(
          key: args.key,
          homeController: args.homeController,
        ),
      );
    },
    DetailsAttractions.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.DetailsAttractions(),
      );
    },
    Download.name: (routeData) {
      final args = routeData.argsAs<DownloadArgs>();
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.Download(
          key: args.key,
          homeController: args.homeController,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.HomePage(),
      );
    },
    ListAttractions.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.ListAttractions(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.LoginPage(),
      );
    },
    ProductsProvider.name: (routeData) {
      final args = routeData.argsAs<ProductsProviderArgs>();
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.ProductsProvider(
          key: args.key,
          codeProvider: args.codeProvider,
          codeClient: args.codeClient,
        ),
      );
    },
    Providers.name: (routeData) {
      final args = routeData.argsAs<ProvidersArgs>();
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.Providers(
          key: args.key,
          codeClient: args.codeClient,
          codeBuyer: args.codeBuyer,
          codeBranch: args.codeBranch,
        ),
      );
    },
    Reports.name: (routeData) {
      final args = routeData.argsAs<ReportsArgs>();
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.Reports(
          key: args.key,
          codeProvider: args.codeProvider,
          accessTargeting: args.accessTargeting,
        ),
      );
    },
    RequestClient.name: (routeData) {
      final args = routeData.argsAs<RequestClientArgs>();
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.RequestClient(
          key: args.key,
          codeBranch: args.codeBranch,
          codeProvider: args.codeProvider,
          valueTotal: args.valueTotal,
          nameClient: args.nameClient,
        ),
      );
    },
    RequestsStores.name: (routeData) {
      final args = routeData.argsAs<RequestsStoresArgs>();
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.RequestsStores(
          key: args.key,
          codeProvider: args.codeProvider,
          userCode: args.userCode,
        ),
      );
    },
    SelectNegotiation.name: (routeData) {
      final args = routeData.argsAs<SelectNegotiationArgs>();
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.SelectNegotiation(
          key: args.key,
          codeProvider: args.codeProvider,
          codeBranch: args.codeBranch,
          nameBranch: args.nameBranch,
          codeClient: args.codeClient,
        ),
      );
    },
    SelectStore.name: (routeData) {
      final args = routeData.argsAs<SelectStoreArgs>();
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.SelectStore(
          key: args.key,
          client: args.client,
          codeProvider: args.codeProvider,
        ),
      );
    },
    Settings.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.Settings(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.SplashPage(),
      );
    },
    Upload.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.Upload(),
      );
    },
    Users.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.Users(),
      );
    },
  };
}

/// generated route for
/// [_i1.App]
class App extends _i20.PageRouteInfo<void> {
  const App({List<_i20.PageRouteInfo>? children})
      : super(
          App.name,
          initialChildren: children,
        );

  static const String name = 'App';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i2.Clients]
class Clients extends _i20.PageRouteInfo<ClientsArgs> {
  Clients({
    _i21.Key? key,
    required int? codeProvider,
    int? accessTargenting,
    int? merchandise,
    int? trading,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          Clients.name,
          args: ClientsArgs(
            key: key,
            codeProvider: codeProvider,
            accessTargenting: accessTargenting,
            merchandise: merchandise,
            trading: trading,
          ),
          initialChildren: children,
        );

  static const String name = 'Clients';

  static const _i20.PageInfo<ClientsArgs> page =
      _i20.PageInfo<ClientsArgs>(name);
}

class ClientsArgs {
  const ClientsArgs({
    this.key,
    required this.codeProvider,
    this.accessTargenting,
    this.merchandise,
    this.trading,
  });

  final _i21.Key? key;

  final int? codeProvider;

  final int? accessTargenting;

  final int? merchandise;

  final int? trading;

  @override
  String toString() {
    return 'ClientsArgs{key: $key, codeProvider: $codeProvider, accessTargenting: $accessTargenting, merchandise: $merchandise, trading: $trading}';
  }
}

/// generated route for
/// [_i3.CountPage]
class CountRoute extends _i20.PageRouteInfo<CountRouteArgs> {
  CountRoute({
    _i21.Key? key,
    required _i22.HomeController homeController,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          CountRoute.name,
          args: CountRouteArgs(
            key: key,
            homeController: homeController,
          ),
          initialChildren: children,
        );

  static const String name = 'CountRoute';

  static const _i20.PageInfo<CountRouteArgs> page =
      _i20.PageInfo<CountRouteArgs>(name);
}

class CountRouteArgs {
  const CountRouteArgs({
    this.key,
    required this.homeController,
  });

  final _i21.Key? key;

  final _i22.HomeController homeController;

  @override
  String toString() {
    return 'CountRouteArgs{key: $key, homeController: $homeController}';
  }
}

/// generated route for
/// [_i4.DetailsAttractions]
class DetailsAttractions extends _i20.PageRouteInfo<void> {
  const DetailsAttractions({List<_i20.PageRouteInfo>? children})
      : super(
          DetailsAttractions.name,
          initialChildren: children,
        );

  static const String name = 'DetailsAttractions';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i5.Download]
class Download extends _i20.PageRouteInfo<DownloadArgs> {
  Download({
    _i21.Key? key,
    required _i22.HomeController homeController,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          Download.name,
          args: DownloadArgs(
            key: key,
            homeController: homeController,
          ),
          initialChildren: children,
        );

  static const String name = 'Download';

  static const _i20.PageInfo<DownloadArgs> page =
      _i20.PageInfo<DownloadArgs>(name);
}

class DownloadArgs {
  const DownloadArgs({
    this.key,
    required this.homeController,
  });

  final _i21.Key? key;

  final _i22.HomeController homeController;

  @override
  String toString() {
    return 'DownloadArgs{key: $key, homeController: $homeController}';
  }
}

/// generated route for
/// [_i6.HomePage]
class HomeRoute extends _i20.PageRouteInfo<void> {
  const HomeRoute({List<_i20.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i7.ListAttractions]
class ListAttractions extends _i20.PageRouteInfo<void> {
  const ListAttractions({List<_i20.PageRouteInfo>? children})
      : super(
          ListAttractions.name,
          initialChildren: children,
        );

  static const String name = 'ListAttractions';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i8.LoginPage]
class LoginRoute extends _i20.PageRouteInfo<void> {
  const LoginRoute({List<_i20.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i9.ProductsProvider]
class ProductsProvider extends _i20.PageRouteInfo<ProductsProviderArgs> {
  ProductsProvider({
    _i21.Key? key,
    required int? codeProvider,
    int? codeClient,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          ProductsProvider.name,
          args: ProductsProviderArgs(
            key: key,
            codeProvider: codeProvider,
            codeClient: codeClient,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductsProvider';

  static const _i20.PageInfo<ProductsProviderArgs> page =
      _i20.PageInfo<ProductsProviderArgs>(name);
}

class ProductsProviderArgs {
  const ProductsProviderArgs({
    this.key,
    required this.codeProvider,
    this.codeClient,
  });

  final _i21.Key? key;

  final int? codeProvider;

  final int? codeClient;

  @override
  String toString() {
    return 'ProductsProviderArgs{key: $key, codeProvider: $codeProvider, codeClient: $codeClient}';
  }
}

/// generated route for
/// [_i10.Providers]
class Providers extends _i20.PageRouteInfo<ProvidersArgs> {
  Providers({
    _i21.Key? key,
    required int? codeClient,
    int? codeBuyer,
    int? codeBranch,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          Providers.name,
          args: ProvidersArgs(
            key: key,
            codeClient: codeClient,
            codeBuyer: codeBuyer,
            codeBranch: codeBranch,
          ),
          initialChildren: children,
        );

  static const String name = 'Providers';

  static const _i20.PageInfo<ProvidersArgs> page =
      _i20.PageInfo<ProvidersArgs>(name);
}

class ProvidersArgs {
  const ProvidersArgs({
    this.key,
    required this.codeClient,
    this.codeBuyer,
    this.codeBranch,
  });

  final _i21.Key? key;

  final int? codeClient;

  final int? codeBuyer;

  final int? codeBranch;

  @override
  String toString() {
    return 'ProvidersArgs{key: $key, codeClient: $codeClient, codeBuyer: $codeBuyer, codeBranch: $codeBranch}';
  }
}

/// generated route for
/// [_i11.Reports]
class Reports extends _i20.PageRouteInfo<ReportsArgs> {
  Reports({
    _i21.Key? key,
    required int? codeProvider,
    required int? accessTargeting,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          Reports.name,
          args: ReportsArgs(
            key: key,
            codeProvider: codeProvider,
            accessTargeting: accessTargeting,
          ),
          initialChildren: children,
        );

  static const String name = 'Reports';

  static const _i20.PageInfo<ReportsArgs> page =
      _i20.PageInfo<ReportsArgs>(name);
}

class ReportsArgs {
  const ReportsArgs({
    this.key,
    required this.codeProvider,
    required this.accessTargeting,
  });

  final _i21.Key? key;

  final int? codeProvider;

  final int? accessTargeting;

  @override
  String toString() {
    return 'ReportsArgs{key: $key, codeProvider: $codeProvider, accessTargeting: $accessTargeting}';
  }
}

/// generated route for
/// [_i12.RequestClient]
class RequestClient extends _i20.PageRouteInfo<RequestClientArgs> {
  RequestClient({
    _i21.Key? key,
    required int codeBranch,
    required int codeProvider,
    required double? valueTotal,
    required String? nameClient,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          RequestClient.name,
          args: RequestClientArgs(
            key: key,
            codeBranch: codeBranch,
            codeProvider: codeProvider,
            valueTotal: valueTotal,
            nameClient: nameClient,
          ),
          initialChildren: children,
        );

  static const String name = 'RequestClient';

  static const _i20.PageInfo<RequestClientArgs> page =
      _i20.PageInfo<RequestClientArgs>(name);
}

class RequestClientArgs {
  const RequestClientArgs({
    this.key,
    required this.codeBranch,
    required this.codeProvider,
    required this.valueTotal,
    required this.nameClient,
  });

  final _i21.Key? key;

  final int codeBranch;

  final int codeProvider;

  final double? valueTotal;

  final String? nameClient;

  @override
  String toString() {
    return 'RequestClientArgs{key: $key, codeBranch: $codeBranch, codeProvider: $codeProvider, valueTotal: $valueTotal, nameClient: $nameClient}';
  }
}

/// generated route for
/// [_i13.RequestsStores]
class RequestsStores extends _i20.PageRouteInfo<RequestsStoresArgs> {
  RequestsStores({
    _i21.Key? key,
    required int? codeProvider,
    required int? userCode,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          RequestsStores.name,
          args: RequestsStoresArgs(
            key: key,
            codeProvider: codeProvider,
            userCode: userCode,
          ),
          initialChildren: children,
        );

  static const String name = 'RequestsStores';

  static const _i20.PageInfo<RequestsStoresArgs> page =
      _i20.PageInfo<RequestsStoresArgs>(name);
}

class RequestsStoresArgs {
  const RequestsStoresArgs({
    this.key,
    required this.codeProvider,
    required this.userCode,
  });

  final _i21.Key? key;

  final int? codeProvider;

  final int? userCode;

  @override
  String toString() {
    return 'RequestsStoresArgs{key: $key, codeProvider: $codeProvider, userCode: $userCode}';
  }
}

/// generated route for
/// [_i14.SelectNegotiation]
class SelectNegotiation extends _i20.PageRouteInfo<SelectNegotiationArgs> {
  SelectNegotiation({
    _i21.Key? key,
    required int? codeProvider,
    required int? codeBranch,
    String? nameBranch,
    required int? codeClient,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          SelectNegotiation.name,
          args: SelectNegotiationArgs(
            key: key,
            codeProvider: codeProvider,
            codeBranch: codeBranch,
            nameBranch: nameBranch,
            codeClient: codeClient,
          ),
          initialChildren: children,
        );

  static const String name = 'SelectNegotiation';

  static const _i20.PageInfo<SelectNegotiationArgs> page =
      _i20.PageInfo<SelectNegotiationArgs>(name);
}

class SelectNegotiationArgs {
  const SelectNegotiationArgs({
    this.key,
    required this.codeProvider,
    required this.codeBranch,
    this.nameBranch,
    required this.codeClient,
  });

  final _i21.Key? key;

  final int? codeProvider;

  final int? codeBranch;

  final String? nameBranch;

  final int? codeClient;

  @override
  String toString() {
    return 'SelectNegotiationArgs{key: $key, codeProvider: $codeProvider, codeBranch: $codeBranch, nameBranch: $nameBranch, codeClient: $codeClient}';
  }
}

/// generated route for
/// [_i15.SelectStore]
class SelectStore extends _i20.PageRouteInfo<SelectStoreArgs> {
  SelectStore({
    _i21.Key? key,
    required _i23.LoginModel? client,
    required int? codeProvider,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          SelectStore.name,
          args: SelectStoreArgs(
            key: key,
            client: client,
            codeProvider: codeProvider,
          ),
          initialChildren: children,
        );

  static const String name = 'SelectStore';

  static const _i20.PageInfo<SelectStoreArgs> page =
      _i20.PageInfo<SelectStoreArgs>(name);
}

class SelectStoreArgs {
  const SelectStoreArgs({
    this.key,
    required this.client,
    required this.codeProvider,
  });

  final _i21.Key? key;

  final _i23.LoginModel? client;

  final int? codeProvider;

  @override
  String toString() {
    return 'SelectStoreArgs{key: $key, client: $client, codeProvider: $codeProvider}';
  }
}

/// generated route for
/// [_i16.Settings]
class Settings extends _i20.PageRouteInfo<void> {
  const Settings({List<_i20.PageRouteInfo>? children})
      : super(
          Settings.name,
          initialChildren: children,
        );

  static const String name = 'Settings';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i17.SplashPage]
class SplashRoute extends _i20.PageRouteInfo<void> {
  const SplashRoute({List<_i20.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i18.Upload]
class Upload extends _i20.PageRouteInfo<void> {
  const Upload({List<_i20.PageRouteInfo>? children})
      : super(
          Upload.name,
          initialChildren: children,
        );

  static const String name = 'Upload';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i19.Users]
class Users extends _i20.PageRouteInfo<void> {
  const Users({List<_i20.PageRouteInfo>? children})
      : super(
          Users.name,
          initialChildren: children,
        );

  static const String name = 'Users';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;
import 'package:profair/src/models/active_model.dart' as _i8;
import 'package:profair/src/views/action/action.dart' as _i1;
import 'package:profair/src/views/app.dart' as _i2;
import 'package:profair/src/views/home/home.dart' as _i3;
import 'package:profair/src/views/operation/operation.dart' as _i4;
import 'package:profair/src/views/wallet/wallet.dart' as _i5;

abstract class $AppRouter extends _i6.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    ActionRoute.name: (routeData) {
      final args = routeData.argsAs<ActionRouteArgs>(
          orElse: () => const ActionRouteArgs());
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.ActionPage(
          key: args.key,
          action: args.action,
        ),
      );
    },
    App.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.App(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.HomePage(),
      );
    },
    Operation.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.Operation(),
      );
    },
    Wallet.name: (routeData) {
      final args =
          routeData.argsAs<WalletArgs>(orElse: () => const WalletArgs());
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.Wallet(
          key: args.key,
          active: args.active,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.ActionPage]
class ActionRoute extends _i6.PageRouteInfo<ActionRouteArgs> {
  ActionRoute({
    _i7.Key? key,
    _i8.ActiveModel? action,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          ActionRoute.name,
          args: ActionRouteArgs(
            key: key,
            action: action,
          ),
          initialChildren: children,
        );

  static const String name = 'ActionRoute';

  static const _i6.PageInfo<ActionRouteArgs> page =
      _i6.PageInfo<ActionRouteArgs>(name);
}

class ActionRouteArgs {
  const ActionRouteArgs({
    this.key,
    this.action,
  });

  final _i7.Key? key;

  final _i8.ActiveModel? action;

  @override
  String toString() {
    return 'ActionRouteArgs{key: $key, action: $action}';
  }
}

/// generated route for
/// [_i2.App]
class App extends _i6.PageRouteInfo<void> {
  const App({List<_i6.PageRouteInfo>? children})
      : super(
          App.name,
          initialChildren: children,
        );

  static const String name = 'App';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute({List<_i6.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i4.Operation]
class Operation extends _i6.PageRouteInfo<void> {
  const Operation({List<_i6.PageRouteInfo>? children})
      : super(
          Operation.name,
          initialChildren: children,
        );

  static const String name = 'Operation';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i5.Wallet]
class Wallet extends _i6.PageRouteInfo<WalletArgs> {
  Wallet({
    _i7.Key? key,
    bool? active,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          Wallet.name,
          args: WalletArgs(
            key: key,
            active: active,
          ),
          initialChildren: children,
        );

  static const String name = 'Wallet';

  static const _i6.PageInfo<WalletArgs> page = _i6.PageInfo<WalletArgs>(name);
}

class WalletArgs {
  const WalletArgs({
    this.key,
    this.active,
  });

  final _i7.Key? key;

  final bool? active;

  @override
  String toString() {
    return 'WalletArgs{key: $key, active: $active}';
  }
}

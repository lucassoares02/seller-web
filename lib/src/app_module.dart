import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:profair/src/views/app.dart';

class AppModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute('/app', child: (context, args) => const App()),
      ];

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}

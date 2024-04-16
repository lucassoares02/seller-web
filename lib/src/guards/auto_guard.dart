import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthGuard extends AutoRouteGuard {
  SharedPreferences? _sharedPreferences;
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    String? codeAcesso = _sharedPreferences?.getString('codacesso');
    String? accessTargeting = _sharedPreferences?.getString('accessTargeting');

    // resolver.next();
    // print("Passando por aqui");
    // print(codeAcesso);
    if (codeAcesso != null) {
      print("autorouter");
      print(accessTargeting);
      print(router.navigatorKey.currentState);
      // if (accessTargeting == "2") {
      //   print("passando por aqui");
      //   router.replaceNamed('/app/download');
      // } else {
      // }
      resolver.next();
    } else {
      // router.replaceNamed('/login');
      resolver.next();
    }
  }
}

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:profair/src/components/progress_indicator.dart';
import 'package:profair/src/controllers/splash_controller.dart';
import 'package:profair/src/repositories/login_repository.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SplashController splashController = SplashController(StateApp.start, LoginRepository());

  @override
  void initState() {
    super.initState();
    initApp();
  }

  initApp() async {
    bool response = await splashController.initApplication();
    navigatorRoute(response);
  }

  navigatorRoute(response) {
    if (response) {
      AutoRouter.of(context).pushNamed("/app");
    } else {
      AutoRouter.of(context).pushNamed("/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorSecondary,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/images/iconwhite.png',
                height: 60,
              ),
              AppProgressIndicator(colorItem: colorWhite),
            ],
          ),
        ),
      ),
    );
  }
}

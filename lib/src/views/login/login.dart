import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:profair/provider/appwriter.dart';
import 'package:profair/src/controllers/login_controller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:profair/src/components/spacing.dart';
import 'package:profair/src/components/button.dart';
import 'package:profair/src/utils/spacing.dart';
import 'package:profair/src/utils/colors.dart';
import 'package:profair/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:profair/src/views/home/home_controller.dart';
import 'package:profair/src/views/login/components/input_login.dart';
import 'package:provider/provider.dart';

import '../../state/state_app.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController? loginController;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  @override
  void initState() {
    loginController = LoginController(StateApp.start, Provider.of<AppWrite>(context, listen: false));
    super.initState();
  }

  String codes = "";

  loginCode() async {
    if (codeController.text.length > 5) {
      final data = {"codacesso": codeController.text};
      try {
        bool response = await loginController!.requestLogin(data);

        if (loginController!.stateLoginCode.value == StateApp.success && response) {
          navigatorRoutes();
        } else {
          Fluttertoast.showToast(
              msg: "Não foi possível realizar login!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } catch (e) {
        debugPrint('$e');
      }
    } else {
      Fluttertoast.showToast(
          msg: "Código informado inválido!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  // scannerQrCode() async {
  //   dynamic permission = await accessCamPermission();
  //   if (permission == PermissionStatus.granted) {
  //     String code = await FlutterBarcodeScanner.scanBarcode(
  //       "#ff6666",
  //       "Cancelar",
  //       false,
  //       ScanMode.DEFAULT,
  //     );

  //     if (code != "-1") {
  //       final data = {"codacesso": code};
  //       try {
  //         bool response = await loginController.requestLogin(data);

  //         navigatorRoutes(response);
  //       } catch (e) {
  //         debugPrint('$e');
  //       }
  //     }
  //   }
  // }

  loginFunc() async {
    bool response = await loginController!.auth("lucas.soares@profair.com", "12345678");
    if (loginController!.stateLogin.value == StateApp.success) {
      // navigatorRoutes(response);
    }
  }

  // testteInter() async {
  //   final data = {"codacesso": "1000000024212"};
  //   // final data = {"codacesso": "1000000063011"};
  //   // final data = {"codacesso": "1000000059091"};
  //   try {
  //     bool response = await loginController.requestLogin(data);

  //     navigatorRoutes(response);
  //   } catch (e) {
  //     debugPrint('$e');
  //   }
  // }

  navigatorRoutes() {
    if (loginController!.dataUser!.accessTargeting == 2) {
      AutoRouter.of(context).pushNamed('/app/download');
    } else {
      AutoRouter.of(context).pushNamed('/app/home');
    }
  }

  accessCamPermission() async {
    final PermissionStatus status = await Permission.camera.request();
    return status;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              width: double.maxFinite,
              decoration: const BoxDecoration(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Parceiro:", style: TextStyle(color: colorGrey, fontSize: 20)),
                  const AppSpacing(),
                  const AppSpacing(),
                  Image.asset(
                    "assets/images/logo-client.png",
                    height: 120,
                  ),
                  const AppSpacing(),
                  const AppSpacing(),
                  const Text("Muito mais pra você!", style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Center(
              child: Container(
                width: 600,
                padding: const EdgeInsets.all(appPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppSpacing(),
                    Image.asset(
                      'assets/images/logo.png',
                      height: 60,
                    ),

                    const AppSpacing(),
                    const AppSpacing(),
                    const Text("Insira o código de acesso."),
                    const AppSpacing(),
                    const AppSpacing(),
                    const AppSpacing(),
                    InputLogin(
                      title: "Código",
                      icon: Icons.numbers,
                      controller: codeController,
                      maxLenght: 50,
                      maxLines: 1,
                    ),
                    const AppSpacing(),
                    const AppSpacing(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ValueListenableBuilder(
                          valueListenable: loginController!.stateLoginCode,
                          builder: (context, value, child) {
                            return AppButton(
                              onPressButton: () {
                                loginCode();
                                // scannerQrCode();
                                // testteInter();
                              },
                              label: "Acessar",
                              colorButton: colorSecondary,
                              iconButton: Icons.numbers,
                              loading: value == StateApp.loading,
                            );
                          },
                        ),
                      ],
                    ),
                    const AppSpacing(),
                    const AppSpacing(),
                    const Divider(color: colorGrey),
                    const AppSpacing(),
                    const AppSpacing(),
                    const AppSpacing(),
                    // const Text("ou", style: TextStyle(color: colorGrey, fontSize: 16)),
                    // const AppSpacing(),
                    // const AppSpacing(),
                    // const AppSpacing(),
                    // InputLogin(
                    //   title: "E-mail",
                    //   icon: Icons.email_outlined,
                    //   controller: emailController,
                    //   maxLenght: 50,
                    //   maxLines: 1,
                    // ),
                    // const AppSpacing(),
                    // const AppSpacing(),
                    // InputLogin(
                    //   title: "Senha",
                    //   icon: Icons.password_rounded,
                    //   controller: passwordController,
                    //   maxLenght: 30,
                    //   maxLines: 1,
                    // ),
                    // const AppSpacing(),
                    // const AppSpacing(),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     ValueListenableBuilder(
                    //       valueListenable: loginController!.stateLoginEmail,
                    //       builder: (context, value, child) {
                    //         return AppButton(
                    //           onPressButton: () {
                    //             // loginFunc();
                    //             // scannerQrCode();
                    //             // testteInter();
                    //           },
                    //           label: "Login",
                    //           colorButton: colorSecondary,
                    //           iconButton: Icons.keyboard_arrow_right_rounded,
                    //           loading: value == StateApp.loading,
                    //         );
                    //       },
                    //     ),
                    //   ],
                    // ),
                    // const AppSpacing(),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}

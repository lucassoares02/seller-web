// ignore_for_file: depend_on_referenced_packages

import 'package:profair/provider/appwriter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:profair/src/notification/notification_service.dart';
import 'package:profair/src/router/router.dart';
import 'package:profair/src/shared/themes/themes.dart';
import 'package:profair/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:profair/src/state/state_app.dart';
import 'package:profair/src/views/home/home_controller.dart';
import 'package:profair/src/views/home/home_repository.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  runApp(
    MultiProvider(
      providers: [
        Provider<NotificationService>(
          create: (context) => NotificationService(),
        ),
        Provider<HomeController>(create: (context) => HomeController(StateApp.start, HomeRepository())),
        Provider<AppWrite>(create: (context) => AppWrite())
      ],
      child: MyApp(),
    ),
  );
  // child: ModularApp(
  //   module: AppModule(),
  //   child: MyApp(),
  // )));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    AppWrite appWrite = Provider.of<AppWrite>(context, listen: false);

    appWrite.initAppWrite();
    // Modular.setInitialRoute('/splash');

    return MaterialApp.router(
      scrollBehavior: MyCustomScrollBehavior(),
      title: "profair",
      routerConfig: _appRouter.config(),
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        S.delegate,
      ],
      debugShowCheckedModeBanner: false,
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(fontFamily: 'Sf'),
      darkTheme: darkTheme,
      // routerDelegate: Modular.routerDelegate,
      // routeInformationParser: Modular.routeInformationParser,
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:profair/src/notification/notification_model.dart';
// import 'package:profair/src/notification/notification_service.dart';
// import 'package:provider/provider.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MultiProvider(providers: [
//     Provider<NotificationService>(
//       create: (context) => NotificationService(),
//     )
//   ], child: MyApp()));
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

//   @override
//   void initState() {
//     super.initState();
//     _firebaseMessaging.requestPermission();
//     _firebaseMessaging.getToken().then((token) {
//       print("FCM Token: $token");
//     });

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print("onMessage: ${message.notification?.body}");
//       showNotification(message.notification?.title, message.notification?.body);
//       inspect(message.notification?.android);
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print("onMessageOpenedApp: ${message.notification?.body}");
//       showNotification(message.notification?.title, message.notification?.body);
//     });
//   }

//   showNotification(String? title, String? body) async {
//     try {
//       Provider.of<NotificationService>(context, listen: false).showNotification(
//         CustomNotification(
//           id: 1,
//           title: title,
//           body: body,
//           payload: "/home",
//         ),
//       );
//     } catch (e) {
//       print("Error Show Notification: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('FCM Example'),
//         ),
//         body: Center(
//           child: Text('Flutter with FCM'),
//         ),
//       ),
//     );
//   }
// }

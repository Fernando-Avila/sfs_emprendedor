import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:sfs_emprendedor/src/controll/main_Controller.dart';
import 'package:sfs_emprendedor/src/controll/notification.dart';
import 'package:sfs_emprendedor/src/controll/notification_controller.dart';
import 'package:sfs_emprendedor/src/global/routes.dart';
import 'package:sfs_emprendedor/src/pages/form/home.dart';
import 'package:sfs_emprendedor/src/providers/ProviderSolicitud.dart';
import 'package:sfs_emprendedor/src/providers/ProviderUser.dart';
import 'package:sfs_emprendedor/src/styles/custom_styles.dart';
import 'package:sfs_emprendedor/src/widgets/widgettext.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? device = await messaging.getToken();
  print(device);
  await PushNotificationController.initializaApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {});
  /*FirebaseMessaging.onMessage.listen((event) async {
    await notifycation(event.notification!);
  });*/
  await NotificationService().init();
  scheduleMicrotask() {
    print('Construido');
    PushNotificationController.MessageStream.listen((Message) {
      print('Schedule ${Message.body}');
    });
  }

  ;
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends StateMVC<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  MainController _con = MainController();
  @override
  void initState() {
    super.initState();
    PushNotificationController.MessageStream.listen((Message) {
      print('InitsSate ${Message.body}');
      _con.Notify(Message, navigatorKey.currentState!.context);

      //navigatorKey.currentState!.pushNamed('/calculadora');
    });
  }

  @override
  Widget build(BuildContext context) {
    PageRoutes().context = context;
    _con.context = context;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderUser()),
        ChangeNotifierProvider(create: (_) => ProviderSolicitud()),
      ],
      child: GetMaterialApp(
        navigatorKey: navigatorKey,
        scrollBehavior: MyCustomScrollBehavior(),
        title: 'SFS',
        theme: ThemeData(
            radioTheme: RadioThemeData(
                fillColor: MaterialStateColor.resolveWith(
                    (states) => EstiloApp.colorwhite)),
            primaryColor: EstiloApp.primaryblue,
            fontFamily: 'Montserrat'),
        initialRoute: Home.id,
        // routes: PageRoutes().routes(),
        // onGenerateRoute: RouteGenerator.generateRoute,
        getPages: PageRoutes().routess,
        supportedLocales: [Locale('es', 'LA'), Locale('en', '')],
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}

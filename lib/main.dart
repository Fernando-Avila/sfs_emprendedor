import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sfs_emprendedor/src/controll/notification.dart';
import 'package:sfs_emprendedor/src/global/routes.dart';
import 'package:sfs_emprendedor/src/pages/auth/login.dart';
import 'package:sfs_emprendedor/src/pages/auth/register.dart';
import 'package:sfs_emprendedor/src/pages/emprendimientos/addgalery.dart';
import 'package:sfs_emprendedor/src/pages/emprendimientos/addsolicitud.dart';
import 'package:sfs_emprendedor/src/pages/emprendimientos/galeria.dart';
import 'package:sfs_emprendedor/src/pages/emprendimientos/mysolicitud.dart';
import 'package:sfs_emprendedor/src/pages/form/home.dart';
import 'package:sfs_emprendedor/src/pages/perfil/account.dart';
import 'package:sfs_emprendedor/src/pages/perfil/autorizacion.dart';
import 'package:sfs_emprendedor/src/pages/perfil/editperfil.dart';
import 'package:sfs_emprendedor/src/providers/ProviderSolicitud.dart';
import 'package:sfs_emprendedor/src/providers/ProviderUser.dart';
import 'package:sfs_emprendedor/src/styles/custom_styles.dart';
import 'package:sfs_emprendedor/src/widgets/calculadora.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {});
  FirebaseMessaging.onMessage.listen((event) {
    notifycation(event.notification!);
  });
  await NotificationService().init();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageRoutes().context = context;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderUser()),
        ChangeNotifierProvider(create: (_) => ProviderSolicitud()),
      ],
      child: MaterialApp(
          scrollBehavior: MyCustomScrollBehavior(),
          title: 'SFS',
          theme: ThemeData(
              radioTheme: RadioThemeData(
                  fillColor: MaterialStateColor.resolveWith(
                      (states) => EstiloApp.colorwhite)),
              primaryColor: EstiloApp.primaryblue,
              fontFamily: 'Montserrat'),
          initialRoute: Home.id,
          routes: PageRoutes().routes()),
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

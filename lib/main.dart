import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sfs_emprendedor/src/pages/auth/login.dart';
import 'package:sfs_emprendedor/src/pages/auth/register.dart';
import 'package:sfs_emprendedor/src/pages/form/home.dart';
import 'package:sfs_emprendedor/src/providers/ProviderUser.dart';
import 'package:sfs_emprendedor/src/styles/custom_styles.dart';
import 'package:sfs_emprendedor/src/widgets/calculadora.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {});
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderUser()),
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
        routes: {
          Home.id: (context) => Home(),
          '/login': (context) => Login(),
          '/calculadora': (context) => Calculadora(),
          '/register': (context) => Register(),
        },
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

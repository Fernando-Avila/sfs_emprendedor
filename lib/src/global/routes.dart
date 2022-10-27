import 'package:flutter/material.dart';
import 'package:sfs_emprendedor/src/pages/auth/login.dart';
import 'package:sfs_emprendedor/src/pages/auth/register.dart';
import 'package:sfs_emprendedor/src/pages/emprendimientos/addPoint.dart';
import 'package:sfs_emprendedor/src/pages/emprendimientos/addgalery.dart';
import 'package:sfs_emprendedor/src/pages/emprendimientos/addnetwork.dart';
import 'package:sfs_emprendedor/src/pages/emprendimientos/addsolicitud.dart';
import 'package:sfs_emprendedor/src/pages/emprendimientos/detailmysolicitud.dart';
import 'package:sfs_emprendedor/src/pages/emprendimientos/galeria.dart';
import 'package:sfs_emprendedor/src/pages/emprendimientos/mysolicitud.dart';
import 'package:sfs_emprendedor/src/pages/form/home.dart';
import 'package:sfs_emprendedor/src/pages/perfil/account.dart';
import 'package:sfs_emprendedor/src/pages/perfil/autorizacion.dart';
import 'package:sfs_emprendedor/src/pages/perfil/editperfil.dart';
import 'package:sfs_emprendedor/src/styles/custom_styles.dart';
import 'package:sfs_emprendedor/src/widgets/appbar.dart';
import 'package:sfs_emprendedor/src/widgets/calculadora.dart';
import 'package:sfs_emprendedor/src/widgets/widgettext.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:get/get.dart';

class PageRoutes {
  late BuildContext context;
  String login = '/login';
  String addpointmysolicitud = '/mysolicitud/detail/addpoint';
  String detailmysolicitud = '/mysolicitud/detail';
  String addnetworkmysolicitud = '/mysolicitud/detail/addnetwork';

  Map<String, WidgetBuilder> routes() {
    return {
      Home.id: (context) => Home(),
      login: (context) => Login(),
      '/calculadora': (context) => Calculadora(),
      '/register': (context) => Register(),
      '/account': (context) => AccountEmp(),
      '/addsolicitud': (context) => Addsolicitud(),
      '/editperfil': (context) => Editperfil(),
      '/mysolicitud': (context) => Mysolicitud(),
      '/galeriasolicitud': (context) => Galeria(),
      '/addphoto': (context) => Addgalery(),
      '/burocredit': (context) => Autorizacion(),
      detailmysolicitud: (context) => Detailmysolicitud(),
      addnetworkmysolicitud: (context) => Addnetwork(),
    };
  }

  List<GetPage<dynamic>> routess = [
    GetPage(
        name: '/calculadora',
        page: () => Calculadora(),
        transition: Transition.rightToLeft),
    GetPage(
        name: '/register',
        page: () => Register(),
        transition: Transition.rightToLeft),
    GetPage(
        name: '/account',
        page: () => AccountEmp(),
        transition: Transition.upToDown),
    GetPage(
        name: '/addsolicitud',
        page: () => Addsolicitud(),
        transition: Transition.rightToLeft),
    GetPage(
        name: '/editperfil',
        page: () => Editperfil(),
        transition: Transition.size),
    GetPage(
        name: '/mysolicitud',
        page: () => Mysolicitud(),
        transition: Transition.rightToLeft),
    GetPage(
        name: '/burocredit',
        page: () => Autorizacion(),
        transition: Transition.zoom),
    GetPage(
        name: '/galeriasolicitud',
        page: () => Galeria(),
        transition: Transition.zoom),
    GetPage(
        name: '/addphoto',
        page: () => Addgalery(),
        transition: Transition.zoom),
    GetPage(
      name: '/home_page',
      page: () => Home(),
    ),
    GetPage(
        name: '/login',
        page: () => Login(),
        transition: Transition.leftToRightWithFade),
    GetPage(
        name: '/mysolicitud/detail',
        page: () => Detailmysolicitud(),
        transition: Transition.zoom),
    GetPage(
        name: '/mysolicitud/detail/addnetwork',
        page: () => Addnetwork(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: '/mysolicitud/detail/addpoint',
        page: () => AddPoint(),
        transition: Transition.rightToLeftWithFade),
  ];
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/calculadora2':
        return MaterialPageRoute(builder: (context) => Calculadora());
      case '/burocredit':
        return MaterialPageRoute(builder: (context) => Autorizacion());
      case '/addphoto':
        return MaterialPageRoute(builder: (context) => Addgalery());
      case '/calculadora':
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              Calculadora(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      case '/mysolicitud':
        return MaterialPageRoute(builder: (context) => Mysolicitud());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _Router(mysolicitud) {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 1000),
      pageBuilder: (context, animation, secondaryAnimation) => mysolicitud,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.slowMiddle;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static Route<dynamic> _FadeTransition(mysolicitud) {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 2000),
      pageBuilder: (context, animation, secondaryAnimation) => mysolicitud,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.slowMiddle;
        const end = Offset(0.0, 1.0);
        const begin = Offset.zero;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  static Route<dynamic> _ScaleTransition(mysolicitud) {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 1000),
      pageBuilder: (context, animation, secondaryAnimation) => mysolicitud,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.slowMiddle;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
    );
  }

  static AnimatedSplashScreen _SlideUpTransition(mysolicitud) {
    return AnimatedSplashScreen(
        duration: 3000,
        splash: Icons.home,
        nextScreen: mysolicitud,
        splashTransition: SplashTransition.fadeTransition,
        // pageTransitionType: PageTransitionType.scale,
        backgroundColor: Colors.blue);
  }

  /* static Route<dynamic> _SlideUpTransition(mysolicitud) {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 1000),
      pageBuilder: (context, animation, secondaryAnimation) => mysolicitud,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset.zero;
        const end = Offset(0.0, 1.0);
        const curve = Curves.easeIn;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }*/

  static Route<dynamic> _RotationTransition(mysolicitud) {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) => mysolicitud,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.slowMiddle;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return RotationTransition(
          turns: animation,
          child: child,
        );
      },
    );
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: EstiloApp.primaryblue,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back_ios)),
                SizedBox()
              ],
            ),
            leading: Builder(builder: (context) {
              return leading(context);
            }),
          ),
          body: Center(
            child: H1(
                'Pagina no encontrada',
                EstiloApp.primarypurple,
                TextAlign.left,
                'Montserrat',
                FontWeight.w400,
                FontStyle.normal),
          ),
        );
      },
    );
  }
}

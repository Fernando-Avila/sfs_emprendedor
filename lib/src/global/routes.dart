import 'package:flutter/material.dart';
import 'package:sfs_emprendedor/src/pages/auth/login.dart';
import 'package:sfs_emprendedor/src/pages/auth/register.dart';
import 'package:sfs_emprendedor/src/pages/emprendimientos/addgalery.dart';
import 'package:sfs_emprendedor/src/pages/emprendimientos/addsolicitud.dart';
import 'package:sfs_emprendedor/src/pages/emprendimientos/detailmysolicitud.dart';
import 'package:sfs_emprendedor/src/pages/emprendimientos/galeria.dart';
import 'package:sfs_emprendedor/src/pages/emprendimientos/mysolicitud.dart';
import 'package:sfs_emprendedor/src/pages/form/home.dart';
import 'package:sfs_emprendedor/src/pages/perfil/account.dart';
import 'package:sfs_emprendedor/src/pages/perfil/autorizacion.dart';
import 'package:sfs_emprendedor/src/pages/perfil/editperfil.dart';
import 'package:sfs_emprendedor/src/widgets/calculadora.dart';

class PageRoutes {
  late BuildContext context;
  String login = '/login';
  String detailmysolicitud = '/mysolicitud/detail';

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
    };
  }
}

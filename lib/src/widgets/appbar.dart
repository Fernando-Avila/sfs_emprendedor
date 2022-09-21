import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfs_emprendedor/src/controll/user_c.dart';
import 'package:sfs_emprendedor/src/models/user.dart';
import 'package:sfs_emprendedor/src/styles/custom_styles.dart';
import 'package:sfs_emprendedor/src/widgets/widgettext.dart';

import '../providers/ProviderUser.dart';

appbar() {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    backgroundColor: EstiloApp.primaryblue,
    //title: textH3('COMO FUNCIONA', EstiloApp.colorwhite, FontWeight.w100),
    leading: Builder(builder: (context) {
      return leading(context);
    }),
    actions: [
      IconButton(onPressed: () => print(''), icon: const Icon(Icons.login))
    ],
  );
}

Padding drawer(context) {
  final ProviderUser prov = Provider.of<ProviderUser>(context, listen: false);
  var us = prov.us;
  return Padding(
    padding: EdgeInsets.only(
        top: 30, right: MediaQuery.of(context).size.width * 0.40),
    child: Container(
        color: EstiloApp.colorwhite,
        child: prov.logged
            ? ListView(
                children: [
                  userinfo(MediaQuery.of(context).size.height * 0.25, us),
                  btn(1, 'asset/icons/degradado/iconlogo.png', 'Cuenta',
                      context),
                  btn(6, 'asset/icons/degradado/iconsocio.png',
                      'Tus Solicitudes', context),
                  btn(7, 'asset/icons/degradado/iconsolicitud.png',
                      'Crear solicitud', context),
                  btn(4, 'asset/icons/degradado/iconcalc.png', 'Calculadora',
                      context),
                  btn(5, 'asset/icons/degradado/iconhand.png', 'Cerrar sesion',
                      context)
                ],
              )
            : ListView(
                children: [
                  userinfo(MediaQuery.of(context).size.height * 0.25, us),
                  btn(1, 'asset/icons/degradado/iconlogo.png', 'Cuenta',
                      context),
                  btn(3, 'asset/icons/degradado/iconsolicitud.png',
                      'Oportunidades', context),
                  btn(4, 'asset/icons/degradado/iconcalc.png', 'Calculadora',
                      context),
                ],
              )),
  );
}

Widget btn(int op, String image, String title, context) {
  return InkWell(
      onTap: () => onTabTapped(op, context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  image,
                  height: 35,
                ),
                const SizedBox(width: 10),
                H3('¿No tienes cuenta?', EstiloApp.primaryblue, TextAlign.center, 'Montserrat', FontWeight.w500, FontStyle.normal),
              ],
            ),
            const Divider(
              height: 10,
              thickness: 2,
              indent: 20,
              endIndent: 20,
              color: EstiloApp.primarypink,
            ),
          ],
        ),
      ));
}

void onTabTapped(int Index, context) {
  final ProviderUser prov = Provider.of<ProviderUser>(context, listen: false);
  switch (Index) {
    case 1:
      prov.logged
          ? Navigator.pushNamed(context, '/account')
          : Navigator.pushNamed(context, '/login');
      break;
    case 2:
      Navigator.pushNamed(context, '/myinversions');
      break;
    case 3:
      Navigator.pushNamed(context, '/oportunidades_page');
      break;
    case 4:
      Navigator.pushNamed(context, '/calculadora');
      break;
    case 5:
      logout(context);
      Navigator.pushNamedAndRemoveUntil(
          context, '/home_page', (route) => false);
      break;
    case 6:
      Navigator.pushNamed(context, '/mysolicitud');
      break;
    case 7:
      Navigator.pushNamed(context, '/addsolicitud');
      break;
    default:
  }
}

Widget userinfo(double d, User us) {
  String userimage = '';
  return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.2), BlendMode.dstATop),
              image: const AssetImage('asset/icons/degradado/iconlogo.png'))),
      height: d,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipOval(
                child: Icon(
              Icons.person,
              size: 70,
            )),
            H3(us.nombre, EstiloApp.primaryblue, TextAlign.center, 'Montserrat', FontWeight.w500, FontStyle.normal),
          ],
        ),
      ));
}

Widget leading(context) {
  return IconButton(
    icon: const Icon(
      Icons.menu,
      color: Colors.white,
      size: 30,
    ),
    onPressed: () => Scaffold.of(context).openDrawer(),
  );
}

/*Widget title() {
  return Image.asset(
    'asset/img/logos/logo-h.png',
    height: 50,
  );
}*/

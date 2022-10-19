import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:sfs_emprendedor/src/controll/user_controller.dart';
import 'package:sfs_emprendedor/src/providers/ProviderUser.dart';
import 'package:sfs_emprendedor/src/styles/custom_styles.dart';
import 'package:sfs_emprendedor/src/widgets/WidgetsFuncionaly.dart';
import 'package:sfs_emprendedor/src/widgets/Widgetsdesign.dart';
import 'package:sfs_emprendedor/src/widgets/appbar.dart';
import 'package:sfs_emprendedor/src/widgets/widgettext.dart';

class AccountEmp extends StatefulWidget {
  const AccountEmp({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends StateMVC<AccountEmp> {
  UserController _con = UserController();

  @override
  Widget build(BuildContext context) {
    final ProviderUser prov = Provider.of<ProviderUser>(context, listen: false);
    _con.context = context;
    _con.user = prov.user!;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // centerTitle: true,
        backgroundColor: EstiloApp.primaryblue,
        title: Row(
          children: [
            IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios)),
            Expanded(
              child: p2(
                  'Tu perfil Emprendedor',
                  EstiloApp.colorwhite,
                  TextAlign.center,
                  'Montserrat',
                  FontWeight.w400,
                  FontStyle.normal),
            ),
            SizedBox()
          ],
        ),
        leading: Builder(builder: (context) {
          return leading(context);
        }),
      ),
      body: body(),
      drawer: drawer(context),
    );
  }

  Widget body() {
    final ProviderUser prov = Provider.of<ProviderUser>(context, listen: false);
    var us = prov.user;
    return ListView(
      children: [
        Stack(
          children: [
            Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.45,
              ),
              padding: EdgeInsets.only(bottom: 22),
              width: MediaQuery.of(context).size.width,
              color: EstiloApp.primaryblue,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: <Widget>[
                          Container(
                            width: 120,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: EstiloApp.colorwhite,
                            ),
                            child: FotoPerfil(image: us!.photoPerfil, size: 80),
                          ),
                          const SizedBox(height: 15),
                          data('Nombre', '${us.nombres} ${us.apellidos}'),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          data('Contacto:', us.phone),
                          data('CI:', us.ci),
                          data('Ciudad:', us.type),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      data('Correo:', us.email),
                      data('Nacimiento:', us.birthDate),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          p1(
                              'Datos Perfil',
                              EstiloApp.colorwhite,
                              TextAlign.center,
                              'Montserrat',
                              FontWeight.w400,
                              FontStyle.normal),
                          _con.datosperfil(0.5)
                        ],
                      ),
                      BtnDegraded(
                          metod: () {
                            Navigator.pushNamed(context, '/editperfil',
                                arguments: prov.user);
                          },
                          widget: p2(
                              'Detalles',
                              EstiloApp.colorwhite,
                              TextAlign.center,
                              'Montserrat',
                              FontWeight.w400,
                              FontStyle.normal),
                          width: 0.3,
                          height: 40),
                    ],
                  ),
                  BtnDegraded(
                      metod: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/home_page', (route) => false);
                      },
                      widget: p2(
                          'Cerrar Sesion',
                          EstiloApp.colorwhite,
                          TextAlign.center,
                          'Montserrat',
                          FontWeight.w400,
                          FontStyle.normal),
                      width: 0.4,
                      height: 40),
                ],
              ),
            ),
          ],
        ),
        /* Padding(
          padding: EdgeInsets.only(top: 10),
          child: textH3(
              'Proximos Pagos', EstiloApp.primarypurple, FontWeight.bold),
        ),
        Padding(padding: EdgeInsets.all(10), child: listpays())*/
      ],
    );
  }

  Widget data(String title, text) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: text != null
            ? Column(
                children: [
                  p1(title, EstiloApp.colorwhite, TextAlign.center,
                      'Montserrat', FontWeight.w400, FontStyle.normal),
                  SizedBox(height: 5),
                  p2(text, EstiloApp.colorwhite, TextAlign.center, 'Montserrat',
                      FontWeight.w400, FontStyle.normal),
                ],
              )
            : SizedBox());
  }

  Widget fotoperfil() {
    return Container();
  }
}

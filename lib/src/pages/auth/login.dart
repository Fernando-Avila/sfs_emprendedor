import 'package:flutter/material.dart';
import 'package:sfs_emprendedor/src/controll/user_c.dart' as control;
import 'package:sfs_emprendedor/src/styles/custom_styles.dart';
import 'package:sfs_emprendedor/src/widgets/Widgetsdialogs.dart';
import 'package:sfs_emprendedor/src/widgets/buttonaccion.dart';
import 'package:sfs_emprendedor/src/widgets/widgettext.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _clave = new TextEditingController();
  TextEditingController _correo = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
    );
  }

  Widget body() {
    return ListView(
      children: <Widget>[
        Container(
          
          height: MediaQuery.of(context).size.height / 2,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: <Color>[
              EstiloApp.primarypurple,
              EstiloApp.primarypink,
            ],
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              H4('Bienvenido', EstiloApp.colorwhite, TextAlign.center,
                  'Montserrat', FontWeight.w400, FontStyle.normal),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'asset/img/iconlogo.png',
                    width: 130,
                  ),
                  const Text(
                    'SFS',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 72,
                        fontWeight: FontWeight.bold,
                        color: EstiloApp.colorwhite,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  TextField(
                    controller: _correo,
                    autofocus: false,
                    cursorHeight: 15,
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide:
                            BorderSide(width: 1, color: EstiloApp.primarypink),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide:
                            BorderSide(width: 1, color: EstiloApp.primarypink),
                      ),
                      labelStyle: new TextStyle(
                          color: EstiloApp.primaryblue, fontSize: 22),
                      labelText: 'Usuario',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _clave,
                    autofocus: false,
                    cursorHeight: 15,
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide:
                            BorderSide(width: 1, color: EstiloApp.primarypink),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide:
                            BorderSide(width: 1, color: EstiloApp.primarypink),
                      ),
                      labelStyle: new TextStyle(
                          color: EstiloApp.primaryblue, fontSize: 22),
                      labelText: 'Contraseña',
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: button(() {
                  login();
                },
                    H5('INGRESAR', EstiloApp.colorwhite, TextAlign.center,
                        'Montserrat', FontWeight.w400, FontStyle.normal),
                    MediaQuery.of(context).size.width * 0.4,
                    50,
                    EstiloApp.horizontalgradientblue),
              ),
              Column(
                children: [
                  TextButton(
                      onPressed: () => chargescreen(context),
                      child: const Text(
                        '¿Olvidó su Contraseña?',
                        style: TextStyle(
                            fontSize: 18,
                            decoration: TextDecoration.underline,
                            color: EstiloApp.primaryblue,
                            fontWeight: FontWeight.w500),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      p1(
                          '¿No tienes cuenta?',
                          EstiloApp.colorblack,
                          TextAlign.center,
                          'Montserrat',
                          FontWeight.w400,
                          FontStyle.normal),
                      TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/register'),
                          child: const Text(
                            'Registrate',
                            style: TextStyle(
                                fontSize: 18,
                                decoration: TextDecoration.underline,
                                color: EstiloApp.primaryblue,
                                fontWeight: FontWeight.w500),
                          )),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<Function()> login() async {
    if (await control.login(_correo.text, _clave.text, context)) {
      Succes(context, 'Inicio de sesion exitoso', 1);
    } else {
      Errordialog(context, 'Error al iniciar Sesion, Reintente');
    }
    return () {};
  }
}

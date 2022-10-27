import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:sfs_emprendedor/src/controll/user_controller.dart';
import 'package:sfs_emprendedor/src/styles/custom_styles.dart';
import 'package:sfs_emprendedor/src/widgets/Widgetsdialogs.dart';
import 'package:sfs_emprendedor/src/widgets/buttonaccion.dart';
import 'package:sfs_emprendedor/src/widgets/widgettext.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends StateMVC<Login> {
  TextEditingController _claveacces = new TextEditingController();
  TextEditingController _correoacces = new TextEditingController();
  UserController _con = UserController();
  @override
  Widget build(BuildContext context) {
    _con.context = context;
    return Scaffold(
      body: body(),
    );
  }

  Widget body() {
    return ListView(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 2,
          decoration: BoxDecoration(
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
                  Text(
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
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Form(
            key: _con.loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    TextFormField(
                        validator: (value) => _con.validator(value!),
                        controller: _con.correo,
                        autofocus: false,
                        cursorHeight: 15,
                        cursorColor: EstiloApp.primarypink,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: EstiloApp.inputdecoration(H3(
                            'Correo',
                            EstiloApp.primaryblue,
                            TextAlign.center,
                            'Montserrat',
                            FontWeight.w400,
                            FontStyle.normal))),
                    SizedBox(height: 20),
                    TextFormField(
                        validator: (value) => _con.validator(value!),
                        controller: _con.clave,
                        autofocus: false,
                        cursorHeight: 15,
                        obscureText: true,
                        cursorColor: EstiloApp.primarypink,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: EstiloApp.inputdecoration(H3(
                            'Contraseña',
                            EstiloApp.primaryblue,
                            TextAlign.center,
                            'Montserrat',
                            FontWeight.w400,
                            FontStyle.normal))),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: button(() async {
                    await _con.login();
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
                        child: Text(
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
                            child: Text(
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
        ),
      ],
    );
  }
}

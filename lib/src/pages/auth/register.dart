import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:sfs_emprendedor/src/controll/user_c.dart';
import 'package:sfs_emprendedor/src/controll/user_controller.dart';
import 'package:sfs_emprendedor/src/styles/custom_styles.dart';
import 'package:sfs_emprendedor/src/widgets/buttonaccion.dart';
import 'package:sfs_emprendedor/src/widgets/widgettext.dart';
import 'dart:async';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends StateMVC<Register> {
  bool newemail = false;

  bool conditions = false;
  UserController _con = UserController();
  int caso = 0;
  @override
  void initState() {
    super.initState();
    _con.emailstatus();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _con.context = context;
    return Scaffold(
      key: _con.scaffoldKey,
      appBar: AppBar(
        backgroundColor: EstiloApp.primaryblue,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'asset/img/iconlogo.png',
              width: 70,
            ),
            Text(
              'SFS',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: EstiloApp.colorwhite,
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
      body: body(),
    );
  }

  Widget form() {
    return Form(
      key: _con.registerKey,
      child: Column(
        children: <Widget>[
          textfield('Nombres', _con.nombre, false),
          textfield('Apellidos', _con.apellido, false),
          textfield('Correo Electronico', _con.correo, false),
          textphonefield('Contacto', _con.contacto, false),
          textpassfield('Contraseña', _con.clave, _con.hidePassword),
          textpassfield(
              'Confirmar Contraseña', _con.confirmclave, _con.hidePassword),
        ],
      ),
    );
  }

  Widget body() {
    caso = _con.caso;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: ListView(
        children: [
          H4('REGISTRO', EstiloApp.primaryblue, TextAlign.center, 'Montserrat',
              FontWeight.w400, FontStyle.normal),
          Container(
              padding: EdgeInsets.all(30),
              decoration: EstiloApp.decorationBoxwhite,
              child: caso == 3 || caso == 1
                  ? form()
                  : Wrap(
                      spacing: 20,
                      runSpacing: 15,
                      runAlignment: WrapAlignment.center,
                      alignment: WrapAlignment.center,
                      children: <Widget>[
                        SpinKitThreeBounce(
                          color: EstiloApp.primaryblue,
                          size: 80,
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.7),
                          child: Column(
                            children: <Widget>[
                              H4(
                                  'Esperando confirmacion enviada a ${_con.mail} ',
                                  EstiloApp.primaryblue,
                                  TextAlign.center,
                                  'Montserrat',
                                  FontWeight.w400,
                                  FontStyle.normal),
                              H4(
                                  'Revisa tu bandeja de entrada',
                                  EstiloApp.primaryblue,
                                  TextAlign.center,
                                  'Montserrat',
                                  FontWeight.w400,
                                  FontStyle.normal),
                            ],
                          ),
                        ),
                        Wrap(
                          spacing: 20,
                          runSpacing: 20,
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(60),
                              splashColor: Colors.grey,
                              onTap: () {
                                reseendemail(context);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                decoration: BoxDecoration(
                                    gradient: EstiloApp.horizontalgradientblue,
                                    borderRadius: BorderRadius.circular(60)),
                                child: p1(
                                    'Reenviar',
                                    EstiloApp.colorwhite,
                                    TextAlign.center,
                                    'Montserrat',
                                    FontWeight.w400,
                                    FontStyle.normal),
                              ),
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(60),
                              splashColor: Colors.grey,
                              onTap: () async {
                                await _con.deleteuser();
                                setState(() {});
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                decoration: BoxDecoration(
                                    gradient:
                                        EstiloApp.horizontalgradientpurplepink,
                                    borderRadius: BorderRadius.circular(60)),
                                child: p1(
                                    'CANCELAR',
                                    EstiloApp.colorwhite,
                                    TextAlign.center,
                                    'Montserrat',
                                    FontWeight.w400,
                                    FontStyle.normal),
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
          Visibility(
              visible: caso == 3 || caso == 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Checkbox(
                            activeColor: EstiloApp.primarypink,
                            value: conditions,
                            onChanged: (value) => setState(() {
                                  conditions = value!;
                                })),
                        Expanded(
                            child: p3(
                                'Al registrarse acepta los terminos y condiciones',
                                EstiloApp.colorblack,
                                TextAlign.justify,
                                'Montserrat',
                                FontWeight.w400))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Stack(
                          children: [
                            button(
                                val,
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: H4(
                                      'REGISTRARSE',
                                      EstiloApp.colorwhite,
                                      TextAlign.center,
                                      'Montserrat',
                                      FontWeight.w500,
                                      FontStyle.normal),
                                ),
                                MediaQuery.of(context).size.width * 0.35,
                                40,
                                EstiloApp.horizontalgradientpurplepink),
                            Visibility(
                              visible: !conditions,
                              child: AnimatedOpacity(
                                opacity: conditions ? 0.0 : 1.0,
                                duration: Duration(microseconds: 500),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      boxShadow: kElevationToShadow[3],
                                      color: Color.fromARGB(48, 255, 255, 255),
                                      borderRadius: BorderRadius.circular(60)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        H3('O', EstiloApp.primaryblue, TextAlign.center,
                            'Montserrat', FontWeight.w400, FontStyle.normal),
                        InkWell(
                          borderRadius: BorderRadius.circular(60),
                          splashColor: Colors.grey,
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 15),
                            decoration: BoxDecoration(
                                color: EstiloApp.colorwhite,
                                border: Border.all(
                                    width: 2, color: EstiloApp.primaryblue),
                                borderRadius: BorderRadius.circular(60)),
                            child: p2(
                                'CANCELAR',
                                EstiloApp.primaryblue,
                                TextAlign.center,
                                'Montserrat',
                                FontWeight.w500,
                                FontStyle.normal),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        p1(
                            '¿Ya estas registrado?',
                            EstiloApp.colorblack,
                            TextAlign.center,
                            'Montserrat',
                            FontWeight.w400,
                            FontStyle.normal),
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'Inicia Sesión',
                              style: TextStyle(
                                  fontSize: 18,
                                  decoration: TextDecoration.underline,
                                  color: EstiloApp.primarypink,
                                  fontWeight: FontWeight.w500),
                            )),
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  Future<Function?> val() async {
    if (_con.registerKey.currentState!.validate()) {
      if (await _con.register2()) {
        setState(() {});
      }
    }
    return null;
  }

  Widget textphonefield(
      String title, TextEditingController control, bool obscure) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      height: 40,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) => _con.validator(value!),
        autofocus: false,
        controller: control,
        autocorrect: true,
        obscureText: obscure,
        keyboardType: TextInputType.phone,
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.next,
        cursorColor: EstiloApp.primarypink,
        cursorWidth: 1,
        decoration: InputDecoration(
          errorStyle:
              TextStyle(color: EstiloApp.colorblack, fontSize: 8, height: 0.1),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: EstiloApp.primarypink),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: EstiloApp.primarypink),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: EstiloApp.primarypurple),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: EstiloApp.primarypink),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: EstiloApp.primarypurple),
          ),
          label: p1(title, EstiloApp.colorblack, TextAlign.center, 'Montserrat',
              FontWeight.w400, FontStyle.normal),
        ),
      ),
    );
  }

  Widget textpassfield(
      String title, TextEditingController control, bool obscure) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      height: 40,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Campo requerido';
          } else if (_con.clave.text != _con.confirmclave.text) {
            return 'Clave no coincide';
          } else {
            return null;
          }
        },
        autofocus: false,
        controller: control,
        autocorrect: true,
        obscureText: obscure,
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.next,
        cursorColor: EstiloApp.primarypink,
        cursorWidth: 1,
        decoration: InputDecoration(
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _con.hidePassword = !_con.hidePassword;
                });
              },
              icon: _con.hidePassword
                  ? Icon(Icons.visibility_off, color: EstiloApp.primarypink)
                  : Icon(Icons.visibility, color: EstiloApp.primarypink)),
          errorStyle:
              TextStyle(color: EstiloApp.colorblack, fontSize: 8, height: 0.1),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: EstiloApp.primarypink),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: EstiloApp.primarypink),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: EstiloApp.primarypurple),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: EstiloApp.primarypink),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: EstiloApp.primarypurple),
          ),
          label: p1(title, EstiloApp.colorblack, TextAlign.center, 'Montserrat',
              FontWeight.w400, FontStyle.normal),
        ),
      ),
    );
  }

  Widget textfield(String title, TextEditingController control, bool obscure) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      height: 40,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) => _con.validator(value!),
        autofocus: false,
        controller: control,
        autocorrect: true,
        obscureText: obscure,
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.next,
        cursorColor: EstiloApp.primarypink,
        cursorWidth: 1,
        decoration: InputDecoration(
          errorStyle:
              TextStyle(color: EstiloApp.colorblack, fontSize: 8, height: 0.1),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: EstiloApp.primarypink),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: EstiloApp.primarypink),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: EstiloApp.primarypurple),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: EstiloApp.primarypink),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: EstiloApp.primarypurple),
          ),
          label: p1(title, EstiloApp.colorblack, TextAlign.center, 'Montserrat',
              FontWeight.w400, FontStyle.normal),
        ),
      ),
    );
  }

  register() async {
    _con.apellido.clear();
    print(_con.context);
    /* var us = User(1, _nombre.text, _apellido.text, "null", "null", _correo.text,
        _clave.text, "null", "emprendedor", "null", "emprendedor");
    if (await registrar(us)) {
      setState(() {
        mail = _correo.text;
        caso = 2;
        timer =
            Timer.periodic(Duration(seconds: 3), (Timer t) => emailverify());
      });
    }*/
  }
}

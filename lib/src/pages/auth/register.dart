import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sfs_emprendedor/src/controll/user_c.dart';
import 'package:sfs_emprendedor/src/models/user.dart';
import 'package:sfs_emprendedor/src/styles/custom_styles.dart';
import 'package:sfs_emprendedor/src/widgets/buttonaccion.dart';
import 'package:sfs_emprendedor/src/widgets/widgettext.dart';
import 'dart:async';
import '../../widgets/Widgetsdialogs.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _nombre = TextEditingController();
  final _apellido = TextEditingController();
  final _correo = TextEditingController();
  final _clave = TextEditingController();
  final _confirmclave = TextEditingController();
  String mail = "";
  int caso = 0;
  bool newemail = false;
  Timer? timer;
  bool conditions = false;
  @override
  void initState() {
    super.initState();
    emailstatus();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const Text(
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
      key: _formKey,
      child: Column(
        children: <Widget>[
          textfield('Nombres', _nombre, false),
          textfield('Apellidos', _apellido, false),
          textfield('Correo Electronico', _correo, true),
          textfield('Contraseña', _clave, true),
          textfield('Confirmar Contraseña', _confirmclave, true),
        ],
      ),
    );
  }

  Widget body() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: ListView(
        children: [
          H4('REGISTRO', EstiloApp.primaryblue, TextAlign.center, 'Montserrat',
              FontWeight.w400, FontStyle.normal),
          Container(
              padding: const EdgeInsets.all(30),
              decoration: EstiloApp.decorationBoxwhite,
              child: caso == 3 || caso == 1
                  ? form()
                  : Wrap(
                      spacing: 20,
                      runSpacing: 15,
                      runAlignment: WrapAlignment.center,
                      alignment: WrapAlignment.center,
                      children: <Widget>[
                        const SpinKitThreeBounce(
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
                                  'Esperando confirmacion enviada a $mail ',
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
                                padding: const EdgeInsets.symmetric(
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
                              onTap: () {
                                deleteuser();
                                setState(() {
                                  caso = 3;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
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
                padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
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
                                duration: const Duration(microseconds: 500),
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
                            padding: const EdgeInsets.symmetric(
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
                            child: const Text(
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

  Function? val() {
    if (_formKey.currentState!.validate()) {
      register();
    }
    return null;
  }

  String? validator(String value) {
    if (value == null || value.isEmpty) {
      return 'Campo obligatorio';
    }
    return null;
  }

  Widget textfield(String title, TextEditingController control, bool obscure) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      height: 40,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          validator(value!);
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
          errorStyle: const TextStyle(
              color: EstiloApp.colorblack, fontSize: 8, height: 0.1),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: EstiloApp.primarypink),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: EstiloApp.primarypink),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: EstiloApp.primarypurple),
          ),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: EstiloApp.primarypink),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: EstiloApp.primarypurple),
          ),
          label: p2(title, EstiloApp.colorblack, TextAlign.center, 'Montserrat',
              FontWeight.w400, FontStyle.normal),
        ),
      ),
    );
  }

  deleteuser() {
    final user = auth.FirebaseAuth.instance.currentUser;
    user!.delete();
    timer?.cancel();
  }

  register() async {
    var us = User(1, _nombre.text, _apellido.text, "null", "null", _correo.text,
        _clave.text, "null", "emprendedor", "null", "emprendedor");
    if (await registrar(us)) {
      setState(() {
        mail = _correo.text;
        caso = 2;
        timer =
            Timer.periodic(Duration(seconds: 3), (Timer t) => emailverify());
      });
    }
  }

  void emailstatus() {
    final user = auth.FirebaseAuth.instance.currentUser;
    if (user == null) {
      caso = 1;
    } else if (!user.emailVerified) {
      caso = 2;
      mail = user.email!;
      timer = Timer.periodic(Duration(seconds: 3), (Timer t) => emailverify());
    } else {
      caso = 3;
    }
  }

  emailverify() async {
    await auth.FirebaseAuth.instance.currentUser!.reload();
    final user = auth.FirebaseAuth.instance.currentUser;
    if (user!.emailVerified) {
      timer!.cancel();
      Succes(context, 'Registro completado', 2);
    } else {
      print('Aun no verifica');
    }
  }
}

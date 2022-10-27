import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:sfs_emprendedor/src/controll/user_controller.dart';
import 'package:sfs_emprendedor/src/models/user_model.dart';
import 'package:sfs_emprendedor/src/providers/ProviderUser.dart';
import 'package:sfs_emprendedor/src/styles/custom_styles.dart';
import 'package:sfs_emprendedor/src/widgets/WidgetsFuncionaly.dart';
import 'package:sfs_emprendedor/src/widgets/appbar.dart';
import 'package:sfs_emprendedor/src/widgets/widgettext.dart';

class Editperfil extends StatefulWidget {
  const Editperfil({Key? key}) : super(key: key);

  @override
  _EditperfilState createState() => _EditperfilState();
}

class _EditperfilState extends StateMVC<Editperfil> {
  UserController _con = UserController();
  bool init = false;
  @override
  void initState() {
    super.initState();
    _con.apellido.text = 's';
  }

  @override
  Widget build(BuildContext context) {
    var us = ModalRoute.of(context)!.settings.arguments;
    final ProviderUser prov = Provider.of<ProviderUser>(context, listen: false);
    _con.context = context;
    _con.user = prov.user!;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
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
    User? us = ModalRoute.of(context)!.settings.arguments as User?;
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              H3(
                  'Verificacion del perfil',
                  EstiloApp.primarypurple,
                  TextAlign.center,
                  'Montserrat',
                  FontWeight.w600,
                  FontStyle.normal),
              _con.datosperfil(1)
            ],
          ),
          BtnBlue(
              metod: () async {
                Navigator.pushNamed(context, '/burocredit');
              },
              widget: H4(
                  'Buro de Crédito',
                  EstiloApp.colorwhite,
                  TextAlign.center,
                  'Montserrat',
                  FontWeight.w600,
                  FontStyle.normal),
              width: 0.4,
              height: 40),
          Container(
              decoration: EstiloApp.decorationBoxwhite,
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [],
              )),
        ],
      ),
    );
  }

  Widget textfield(
      String placeholder,
      TextInputType tipoTexto,
      TextEditingController controlador,
      TextCapitalization textCapitalization,
      bool readonly,
      Null Function() metodo,
      Widget widget,
      Null Function(dynamic value) validator) {
    controlador.text = 'Esto es una prueba X';
    return Textfield(placeholder, tipoTexto, controlador, textCapitalization,
        readonly, metodo, widget, validator);
  }
}

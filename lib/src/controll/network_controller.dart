import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:sfs_emprendedor/src/models/network_model.dart';
import 'package:sfs_emprendedor/src/models/solicitud_model.dart';
import 'package:sfs_emprendedor/src/providers/ProviderUser.dart';
import 'package:sfs_emprendedor/src/styles/custom_styles.dart';
import 'package:sfs_emprendedor/src/widgets/WidgetsFuncionaly.dart';
import 'package:sfs_emprendedor/src/widgets/WidgetsSnack.dart';
import 'package:sfs_emprendedor/src/widgets/widgettext.dart';
import 'package:url_launcher/url_launcher.dart';

class NetworkController extends ControllerMVC {
  late BuildContext context;
  late Solicitud solicitud;
  late bool confirmsave = false;
  Network networkpost = Network();
  GlobalKey<FormState> NetworkFormKey = GlobalKey();
  GlobalKey<ScaffoldState> Scaffoldkey = new GlobalKey<ScaffoldState>();

  final perfil = TextEditingController();
  final enlace = TextEditingController();
  final networkmemoizer = AsyncMemoizer();
  List networks = [];
  Future<List?> GetNetworkSolicitud() async {
    final userprov = Provider.of<ProviderUser>(context, listen: false);
    var value = await httpGetNetworkSolicitud(solicitud.id, userprov.token);
    if (value.statusCode == 200) {
      var _data;
      var jsonData = jsonDecode(value.body);

      if (jsonData['consulta'].isEmpty) {
        return [];
      } else {
        _data = List<dynamic>.from(jsonData['consulta'].map<dynamic>(
          (dynamic item) => item,
        ));
        var Networks = Networklist.fromJson(_data).Networks;
        print(Networks);
        return Networks;
      }
    } else {
      //ScaffoldMessenger.of(context).showSnackBar(Snackbarespecial('s'));
      ScaffoldMessenger.of(context).showSnackBar(snackBarerror);
      return [];
    }
  }

  AlertAddnetwork(String title, Network? networkedit, int? pos) {
    perfil.clear();
    enlace.clear();
    bool enlaceurl = false;
    Network network = Network();
    if (networkedit != null) {
      perfil.text = networkedit.name;
      enlace.text = networkedit.enlace;
      network = networkedit;
    } else {}
    return AlertDialog(
      title: SizedBox(
        width: 400,
        height: 30,
        child: p1(title, EstiloApp.primaryblue, TextAlign.left, 'Montserrat',
            FontWeight.w400, FontStyle.normal),
      ),
      content: Form(
        key: NetworkFormKey,
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            p2(
                'Ingresa informacion sobre la red social',
                EstiloApp.primaryblue,
                TextAlign.left,
                'Montserrat',
                FontWeight.w400,
                FontStyle.normal),
            Textfield('Usuario:', TextInputType.text, perfil,
                TextCapitalization.sentences, false, () {}, null, (value) {
              return validator(value!);
            }),
            tfield('Enlace:', enlace, null, (value) {
              if (enlaceurl && value.isNotEmpty) {
                return null;
              } else {
                return 'Enlace no valído';
              }
            }),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: p2('Cancelar', EstiloApp.primaryblue, TextAlign.left,
              'Montserrat', FontWeight.w600, FontStyle.normal),
        ),
        TextButton(
          onPressed: () async {
            if (await canLaunchUrl(Uri.parse(enlace.text))) {
              enlaceurl = true;
            } else {
              enlaceurl = false;
            }
            if (NetworkFormKey.currentState!.validate()) {
              network.enlace = enlace.text;
              network.network = title;
              network.name = perfil.text;
              if (pos != null) {
                networks[pos] = network;
              } else {
                networks.add(network);
              }

              Navigator.of(context).pop();
            }
          },
          child: p2('Aceptar', EstiloApp.primarypurple, TextAlign.left,
              'Montserrat', FontWeight.w600, FontStyle.normal),
        ),
      ],
    );
  }

  Widget tfield(placeholder, controlador, widget, validator) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: TextFormField(
          textInputAction: TextInputAction.next,
          validator: validator,
          keyboardType: TextInputType.text,
          controller: controlador,
          autofocus: false,
          cursorColor: EstiloApp.primaryblue,
          decoration: InputDecoration(
              prefixIcon: widget ?? null,
              errorStyle: TextStyle(
                  color: EstiloApp.colorblack, fontSize: 10, height: 0.3),
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
                borderSide:
                    BorderSide(width: 1, color: EstiloApp.primarypurple),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(width: 1, color: EstiloApp.primarypink),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide:
                    BorderSide(width: 1, color: EstiloApp.primarypurple),
              ),
              label: p1(placeholder, EstiloApp.colorblack, TextAlign.center,
                  'Montserrat', FontWeight.w400, FontStyle.normal)),
        ));
  }

  removenetwork(Network network) {
    //Scaffoldkey.currentState!.setState(() {});
    networks.remove(network);
  }

  Future<bool> SaveNetwork(Network network) async {
    network.undertakingId = solicitud.id;
    networkpost = network;
    setState(() {});
    var value = await httpRegisterNetworkPost(network, 'token');
    if (value.statusCode == 200) {
      networks.remove(network);      
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(snackBarerror);
    }
    return false;
  }

  succesSave() async {
    await Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      margin: EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(15),
      forwardAnimationCurve: Curves.easeInOutBack,
      backgroundGradient: EstiloApp.horizontalgradientpurplepink,
      blockBackgroundInteraction: true,
      onStatusChanged: (status) {
        print(status.toString());
      },
      messageText: p1(
          'Redes sociales guardadas correctamente',
          EstiloApp.colorwhite,
          TextAlign.left,
          'Montserrat',
          FontWeight.w500,
          FontStyle.normal),
      titleText: H4('Correcto', EstiloApp.colorwhite, TextAlign.left,
          'Montserrat', FontWeight.w500, FontStyle.normal),
      duration: Duration(seconds: 3),
    ).show(context);
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, '/mysolicitud');
  }

  ConfirmSave() async {
    await showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: AlertConfirmnetwork(),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  AlertConfirmnetwork() {
    return AlertDialog(
      title: SizedBox(
        width: 400,
        height: 30,
        child: H4('Confirmar registro', EstiloApp.primaryblue, TextAlign.left,
            'Montserrat', FontWeight.w400, FontStyle.normal),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: p1(
            networks.length > 1
                ? 'Se registrarán todas las redes sociales ingresadas'
                : 'Se registrará la red social ingresada',
            EstiloApp.primaryblue,
            TextAlign.left,
            'Montserrat',
            FontWeight.w400,
            FontStyle.normal),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            confirmsave = false;
            Navigator.of(context).pop();
          },
          child: p2('Cancelar', EstiloApp.primaryblue, TextAlign.left,
              'Montserrat', FontWeight.w600, FontStyle.normal),
        ),
        TextButton(
          onPressed: () {
            confirmsave = true;
            Navigator.pop(context);
          },
          child: p2('Aceptar', EstiloApp.primarypurple, TextAlign.left,
              'Montserrat', FontWeight.w600, FontStyle.normal),
        ),
      ],
    );
  }
}

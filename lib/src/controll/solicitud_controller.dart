import 'dart:convert';
import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:sfs_emprendedor/src/models/network_model.dart';
import 'package:sfs_emprendedor/src/models/point_model.dart';
import 'package:sfs_emprendedor/src/providers/ProviderUser.dart';
import 'package:sfs_emprendedor/src/styles/custom_styles.dart';
import 'package:sfs_emprendedor/src/widgets/WidgetsSnack.dart';
import 'package:sfs_emprendedor/src/widgets/Widgetsdialogs.dart';
import 'package:sfs_emprendedor/src/models/solicitud_model.dart';
import 'package:http/http.dart' as http;
import 'package:sfs_emprendedor/src/widgets/widgettext.dart';

class SolicitudController extends ControllerMVC {
  late BuildContext context;
  GlobalKey<FormState> addsolicitudkeyform = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  PageController pageController = PageController();
  late Solicitud solicitud;
  bool confirmsave = false;
  // final  AsyncMemoizer _memoizer = AsyncMemoizer();
  final memoizer = AsyncMemoizer();
  final pointmemoizer = AsyncMemoizer();
  final networkmemoizer = AsyncMemoizer();
  final PageController mypageController = PageController();
  List<String> categoria_list = [
    'Medio ambiente',
    'Manufactura',
    'Construcción',
    'Tecnología',
    'Comidas y bebidas',
    'Cine',
    'Educación',
    'Emprendimiento',
    'Cuidado de la salud',
    'Finanzas',
    'Moda',
    'Marketing digital',
    'Automóviles',
    'Comercio'
  ];
  List<String> categorianegocio_list = ['Sector público', 'Sector privado'];
  List<String> frecuencia_list = ['Mensual', 'Trimestral', 'Anual'];
  late double capital = 0;
  late double plazo = 3;
  late double tir = 14;
  late double total = 0;
  late bool futureactive = true;
  final descripcion = TextEditingController();
  final frecuencia = TextEditingController();
  final tipo_financiamiento = TextEditingController();
  final categoria_financiamiento = TextEditingController();
  final categoria_negocio = TextEditingController();
  final nombre = TextEditingController();
  File? foto_emprendimiento;
  final ImagePicker _picker = ImagePicker();
  Future getImage(ImageSource image) async {
    //final pickedFile = await picker.getImage(source: image);
    final pickedFile = await _picker.pickImage(source: image);
    return File(pickedFile!.path);
  }

  Future<List?> GetSolicitudAplicant() async {
    final userprov = Provider.of<ProviderUser>(context, listen: false);
    var value =
        await httpGetSolicitudAplicant(userprov.user!.id, userprov.token);
    if (value.statusCode == 200) {
      var _data;
      var jsonData = jsonDecode(value.body);

      if (jsonData['consulta'].isEmpty) {
        return [];
      } else {
        _data = List<dynamic>.from(jsonData['consulta'].map<dynamic>(
          (dynamic item) => item,
        ));
        var solicitudes = Solicitudlist.fromJson(_data).solicitudes;
        return solicitudes;
      }
    } else {
      //ScaffoldMessenger.of(context).showSnackBar(Snackbarespecial('s'));
      ScaffoldMessenger.of(context).showSnackBar(snackBarerror);
      return [];
    }
  }

  Future register1() async {
    /* SharedPreferences prefs = await SharedPreferences.getInstance();
      us = await prefs.getStringList(mail);
      var user = User(
          nombres: us![0],
          apellidos: us[1],
          email: us[2],
          password: us[3],
          phone: us[4]);
      httpRegisterUserPost(user).then((value) {
        if (value.statusCode == 200) {
          Succes(context, 'Registro completado', 2);
        }
      });*/
    final userprov = Provider.of<ProviderUser>(context, listen: false);
    if (addsolicitudkeyform.currentState!.validate()) {
      if (foto_emprendimiento != null) {
        await ConfirmSave(AlertConfirm());
        if (confirmsave) {
          Solicitud solicitud = Solicitud(
              applicantId: userprov.user!.id,
              categoriaNegocio: categoria_negocio.text,
              descripcionEmprendimiento: descripcion.text,
              frecuenciaPago: frecuencia.text,
              montoSolicitado: capital,
              categoriaEmprendimiento: categoria_financiamiento.text,
              plazo: plazo,
              photoEmprendimiento: foto_emprendimiento,
              tir: tir,
              tipoFinanciamiento: tipo_financiamiento.text,
              nameUndertaking: nombre.text);
          print(solicitud.applicantId);

          ConfirmSave(
              ChargueDialog(context, 'Cargando', 'Ingresando tus datos'));
          httpRegistersolicitudPost(solicitud, userprov.token)
              .then((value) async {
            //  Navigator.pop(context);
            await Future.delayed(Duration(seconds: 1));
            Navigator.pop(context);
            if (value.statusCode == 200) {
              await Flushbar(
                flushbarPosition: FlushbarPosition.TOP,
                margin: EdgeInsets.all(10),
                borderRadius: BorderRadius.circular(15),
                forwardAnimationCurve: Curves.easeInOutBack,
                backgroundGradient:
                    EstiloApp.horizontalgradientpurplepinknotify,
                blockBackgroundInteraction: true,
                onStatusChanged: (status) {
                  print(status.toString());
                },
                messageText: p1(
                    'Solicitud creada con éxito',
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
              Navigator.pushReplacementNamed(context, '/mysolicitud');
            } else {
              print(value.statusCode);

              //ScaffoldMessenger.of(context).showSnackBar(Snackbarespecial('s'));
              ScaffoldMessenger.of(context).showSnackBar(snackBarerror);
            }
          });
        }
      } else {
        ErrordialogDato(context, 'Error',
            'Debes subir una foto para la portada de tu emprendimiento');
      }
    }
    return false;
  }

  ConfirmSave(Widget alert) async {
    await showGeneralDialog(
      context: context,
      barrierDismissible: false,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: alert,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  AlertConfirm() {
    return AlertDialog(
      title: SizedBox(
        width: 400,
        height: 30,
        child: H4('Confirmar registro', EstiloApp.primaryblue, TextAlign.left,
            'Montserrat', FontWeight.w500, FontStyle.normal),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: p1(
            '¿Estás seguro de crear esta solicitud?\n Puedes revisar los datos ingresados de manera detallada.',
            EstiloApp.primaryblue,
            TextAlign.left,
            'Montserrat',
            FontWeight.w500,
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

  Future<List?> GetPointSolicitud() async {
    final userprov = Provider.of<ProviderUser>(context, listen: false);
    var value = await httpGetPointSolicitud(solicitud.id, userprov.token);
    if (value.statusCode == 200) {
      var _data;
      var jsonData = jsonDecode(value.body);

      if (jsonData['consulta'].isEmpty) {
        return [];
      } else {
        _data = List<dynamic>.from(jsonData['consulta'].map<dynamic>(
          (dynamic item) => item,
        ));
        var Points = Pointlist.fromJson(_data).Points;
        print(Points);
        return Points;
      }
    } else {
      //ScaffoldMessenger.of(context).showSnackBar(Snackbarespecial('s'));
      ScaffoldMessenger.of(context).showSnackBar(snackBarerror);
      return [];
    }
  }

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
}

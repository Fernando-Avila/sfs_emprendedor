import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:sfs_emprendedor/src/providers/ProviderUser.dart';
import 'package:sfs_emprendedor/src/widgets/WidgetsSnack.dart';
import 'package:sfs_emprendedor/src/widgets/Widgetsdialogs.dart';
import 'package:sfs_emprendedor/src/models/solicitud_model.dart';

class SolicitudController extends ControllerMVC {
  late BuildContext context;
  GlobalKey<FormState> addsolicitudkeyform = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  PageController pageController = PageController();
  late Solicitud solicitud;
  // final  AsyncMemoizer _memoizer = AsyncMemoizer();
  final memoizer = AsyncMemoizer();
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
        // chargedialog(context, 'Cargando', 'Registrando Emprendedor');
        httpRegistersolicitudPost(solicitud, userprov.token).then((value) {
          //  Navigator.pop(context);
          if (value.statusCode == 200) {
            // Succes(context, 'Registro completado', 2);
          } else {
            //ScaffoldMessenger.of(context).showSnackBar(Snackbarespecial('s'));
            ScaffoldMessenger.of(context).showSnackBar(snackBarerror);
          }
        });
      } else {
        ErrordialogDato(context, 'Error',
            'Debes subir una foto para la portada de tu emprendimiento');
      }
    }
    return false;
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:another_flushbar/flushbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sfs_emprendedor/src/models/user_model.dart';
import 'package:sfs_emprendedor/src/providers/ProviderUser.dart';
import 'package:sfs_emprendedor/src/styles/custom_styles.dart';
import 'package:sfs_emprendedor/src/widgets/WidgetsSnack.dart';
import 'package:sfs_emprendedor/src/widgets/widgettext.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../widgets/Widgetsdialogs.dart';
import 'package:http/http.dart' as http;

class UserController extends ControllerMVC {
  bool hidePassword = true;
  bool loading = false;
  bool confirmsave = false;
  int caso = 0;
  User user = User();
  GlobalKey<FormState> loginFormKey = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  GlobalKey<FormState> registerKey = GlobalKey();
  GlobalKey<FormState> pdfFormKey = GlobalKey();
  final nombre = TextEditingController();
  final apellido = TextEditingController();
  final correo = TextEditingController();
  final clave = TextEditingController();
  final contacto = TextEditingController();
  final confirmclave = TextEditingController();
  File? buro;
  final burotext = TextEditingController();
  Timer? timer;
  String mail = "";
  late BuildContext context;

  String? validator(String value) {
    if (value == null || value.isEmpty) {
      return 'Campo obligatorio';
    }
    return null;
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

  deleteuser() async {
    final user = auth.FirebaseAuth.instance.currentUser;
    user!.delete();
    timer?.cancel();
    caso = 3;
  }

  emailverify() async {
    await auth.FirebaseAuth.instance.currentUser!.reload();
    final user = auth.FirebaseAuth.instance.currentUser;
    if (user!.emailVerified) {
      timer!.cancel();
      //firstregisteruser();
    } else {}
  }

  Future<bool> register2() async {
    List<String>? us;
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
    var user = User(
        nombres: nombre.text,
        apellidos: apellido.text,
        email: correo.text,
        password: clave.text,
        phone: contacto.text);
    // chargedialog(context, 'Cargando', 'Registrando Emprendedor');
    httpRegisterUserPost(user).then((value) {
      //  Navigator.pop(context);
      if (value.statusCode == 200) {
        Succes(context, 'Registro completado', 2);
      } else {
        //ScaffoldMessenger.of(context).showSnackBar(Snackbarespecial('s'));
        ScaffoldMessenger.of(context).showSnackBar(snackBarerror);
      }
    });
    return false;
  }

  Future<bool> register() async {
    try {
      await auth.FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: correo.text.trim(), password: clave.text.trim());
      await auth.FirebaseAuth.instance.currentUser!.sendEmailVerification();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(correo.text,
          <String>[nombre.text, apellido.text, correo.text, clave.text, '555']);
      mail = correo.text;
      caso = 2;
      timer = Timer.periodic(Duration(seconds: 3), (Timer t) => emailverify());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future login() async {
    if (loginFormKey.currentState!.validate()) {
      try {
        FirebaseMessaging messaging = FirebaseMessaging.instance;
        String? device = await messaging.getToken();
        httpLoginUserPost(correo.text, clave.text, device!).then((value) async {
          //  Navigator.pop(context);
          if (value.statusCode == 200) {
            final userprov = Provider.of<ProviderUser>(context, listen: false);
            final prefs = await SharedPreferences.getInstance();
            var respuesta = jsonDecode(value.body);
            var userdata = User.fromJson(respuesta['aplicant']);
            List token = respuesta['token'].split("|");
            userprov.user = userdata;
            userprov.token = token[1];
            userprov.logged = true;
            await prefs.setInt('id', userprov.user!.id);
            await prefs.setString('token', token[1]);
            Navigator.pushReplacementNamed(context, '/account');
          } else {
            //ScaffoldMessenger.of(context).showSnackBar(Snackbarespecial('s'));
            ScaffoldMessenger.of(context).showSnackBar(snackBarerror);
          }
        });
      } catch (e) {
        print(e);
        //  Errordialog(context, 'Error al iniciar Sesion, Reintente');
      }
    }
  }

  Future RestartInfo(BuildContext context) async {
    final userprov = Provider.of<ProviderUser>(context, listen: false);
    int id = userprov.user!.id;
    httpUserGet(id, userprov.token).then((value) async {
      if (value.statusCode == 200) {
        final userprov = Provider.of<ProviderUser>(context, listen: false);
        final prefs = await SharedPreferences.getInstance();
        var respuesta = jsonDecode(value.body);
        var userdata = User.fromJson(respuesta['Applicant']);
        userprov.user = userdata;
        userprov.logged = true;
        await prefs.setInt('id', userprov.user!.id);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(snackBarerror);
      }
    });
  }

  Widget datosperfil(double width) {
    return Container(
      width: MediaQuery.of(context).size.width * width,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          Expanded(
            child: Slider(
              activeColor: EstiloApp.primarypurple,
              value: datos()[0],
              onChanged: (value) {},
              max: datos()[1],
            ),
          ),
          p1('${datos()[2]}%', EstiloApp.primarypurple, TextAlign.center,
              'Montserrat', FontWeight.w400, FontStyle.normal)
        ],
      ),
    );
  }

  dynamic datos() {
    final ProviderUser prov = Provider.of<ProviderUser>(context, listen: false);
    User? us = prov.user;
    var map = us!.toJson();
    double llenos = 0;

    for (var dato in map.keys) {
      if (map[dato] != null) {
        llenos++;
      }
    }
    double porcentage = (llenos * 100 / map.length);
    return [
      llenos,
      double.parse('${map.length}'),
      (porcentage).toStringAsFixed(0)
    ];
  }

  void charguedata() {
    final ProviderUser prov = Provider.of<ProviderUser>(context, listen: false);
    nombre.text = prov.user!.nombres;
  }

  Future uploadFile() async {
    final ProviderUser prov = Provider.of<ProviderUser>(context, listen: false);
    if (pdfFormKey.currentState!.validate()) {
      print('Upload');
      print(buro!.path);
      await ConfirmSave(AlertConfirmAutorization());
      if (confirmsave) {
        ConfirmSave(
            ChargueDialog(context, 'Cargando', 'Subiendo Archivo al servidor'));
        var value = await httpRegisterBuroPost(buro!, user.id, prov.token);
        await UserController().RestartInfo(context);
        await Future.delayed(Duration(seconds: 1));
        Navigator.pop(context);
        if (value.statusCode == 200) {
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
                'Documento guardado con éxito',
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

          return true;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(snackBarerror);
        }
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

  AlertConfirmAutorization() {
    return AlertDialog(
      title: SizedBox(
        width: 400,
        height: 30,
        child: H4('Confirmar registro', EstiloApp.primaryblue, TextAlign.left,
            'Montserrat', FontWeight.w400, FontStyle.normal),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: H5(
            'Se registrará su documento, una vez registrado no se podrá cambiar ni editar',
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

  Future<bool> saveFile(String url, String fileName) async {
    try {
      if (await true) {
        Directory? directory;
        directory = await getExternalStorageDirectory();
        String newPath = "";
        List<String> paths = directory!.path.split("/");
        for (int x = 1; x < paths.length; x++) {
          String folder = paths[x];
          if (folder != "Android") {
            newPath += "/" + folder;
          } else {
            break;
          }
        }
        newPath = newPath + "/PDF_Download";
        directory = Directory(newPath);

        File saveFile = File(directory.path + "/$fileName");

        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }
        if (await directory.exists()) {}
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future getFile() async {
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['ppt', 'pptx', 'doc', 'docx', 'pdf', 'xls', 'xlsx'],
    );
    if (pickedFile != null) {
      File file = File(pickedFile.paths.first!);
      // File file = File(pickedFile.files.first.path!);
      // File file = File(pickedFile.files.last.path!);
      buro = file;
      print('GetFile');
      print(buro!.path);
      List name = buro!.path.split('/');
      burotext.text = name.last;
    } else {}
  }

  downloadFile(
    String url,
  ) async {
    String filename = 'dada.pdf';
    var httpClient = http.Client();
    var request = new http.Request('GET', Uri.parse(url));
    var response = httpClient.send(request);
    String dir = (await getApplicationDocumentsDirectory()).path;

    // ignore: deprecated_member_use
    List<List<int>> chunks = [];
    int downloaded = 0;

    response.asStream().listen((http.StreamedResponse r) {
      r.stream.listen((List<int> chunk) {
        // Display percentage of completion
        debugPrint(
            'downloadPercentage: ${downloaded / r.contentLength! * 100}');

        chunks.add(chunk);
        downloaded += chunk.length;
      }, onDone: () async {
        // Display percentage of completion
        debugPrint(
            'downloadPercentage: ${downloaded / r.contentLength! * 100}');

        // Save the file
        File file = new File('$dir/$filename');
        buro = file;
        print('GetUpload');
        print(buro!.path);
        List name = buro!.path.split('/');
        burotext.text = name.last;
        final Uint8List bytes = Uint8List(r.contentLength!);
        int offset = 0;
        for (List<int> chunk in chunks) {
          bytes.setRange(offset, offset + chunk.length, chunk);
          offset += chunk.length;
        }
        await file.writeAsBytes(bytes);
        return;
      });
    });
  }
}

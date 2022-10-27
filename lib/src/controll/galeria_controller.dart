import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:sfs_emprendedor/src/models/galeria_model.dart';
import 'package:sfs_emprendedor/src/models/solicitud_model.dart';
import 'package:sfs_emprendedor/src/providers/ProviderUser.dart';
import 'package:sfs_emprendedor/src/styles/custom_styles.dart';
import 'package:sfs_emprendedor/src/widgets/WidgetsSnack.dart';
import 'package:sfs_emprendedor/src/widgets/widgettext.dart';

class GaleriaController extends ControllerMVC {
  late BuildContext context;
  Solicitud solicitud = Solicitud();
  GlobalKey<FormState> photosFormKey = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final ImagePicker _picker = ImagePicker();
  final List<File> files = [];
  final List<Photo> photos = [];
  Photo photopost = Photo();
  StreamController<Widget> overlayController =
      StreamController<Widget>.broadcast();

  Future getImages() async {
    //final pickedFile = await picker.getImage(source: image);
    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      for (var picked in pickedFiles) {
        Photo photo = Photo();
        photo.photos = File(picked.path);
        photos.add(photo);
        files.add(File(picked.path));
      }
    }
    print(photos);
  }

  bool mysolicitud() {
    final userprov = Provider.of<ProviderUser>(context, listen: false);
    return solicitud.applicantId == userprov.user!.id;
  }

  Future<List?> GetSolicitudGalery() async {
    final userprov = Provider.of<ProviderUser>(context, listen: false);
    var value = await httpGetPhotosUndertaking(solicitud.id, userprov.token);
    //  Navigator.pop(context);
    if (value.statusCode == 200) {
      // Succes(context, 'Registro completado', 2);
      var _data;
      var jsonData = jsonDecode(value.body);
      //   print(jsonData);
      if (jsonData['consulta'].isEmpty) {
        return [];
      } else {
        _data = List<dynamic>.from(jsonData['consulta'].map<dynamic>(
          (dynamic item) => item,
        ));
        var Photos = Photolist.fromJson(_data).Photos;
        return Photos;
      }
    } else {
      //ScaffoldMessenger.of(context).showSnackBar(Snackbarespecial('s'));
      ScaffoldMessenger.of(context).showSnackBar(snackBarerror);
      return [];
    }
  }

  removephoto(Photo remover) {
    print(photos.remove(remover));
  }

  Future saveImages() async {
    if (photosFormKey.currentState!.validate()) {
      for (var photo in photos) {
        photo.undertakingId = solicitud.id;
        await httpRegisterPhotoPost(photo, 'token');
      }
      setState(() {});
      photos.clear();
      SetState(
        builder: (context, object) {
          return scaffoldKey.currentWidget!;
        },
      );
    }
  }

  Future<bool> SaveImage(Photo photo) async {
    if (photosFormKey.currentState!.validate()) {
      photo.undertakingId = solicitud.id;
      photopost = photo;
      setState(() {});
      var value = await httpRegisterPhotoPost(photo, 'token');
      if (value.statusCode == 200) {
        photos.remove(photo);
        setState(() {});
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(snackBarerror);
      }
    }
    return false;
  }

  SuccesGalery() async {
    await Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      margin: EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(15),
      forwardAnimationCurve: Curves.easeInOutBack,
      backgroundGradient: EstiloApp.horizontalgradientpurplepinknotify,
      onStatusChanged: (status) {
        print(status.toString());
      },
      messageText: p1('Galería actualizada', EstiloApp.colorwhite,
          TextAlign.left, 'Montserrat', FontWeight.w500, FontStyle.normal),
      titleText: H4('Correcto', EstiloApp.colorwhite, TextAlign.left,
          'Montserrat', FontWeight.w500, FontStyle.normal),
      duration: Duration(seconds: 3),
    ).show(context);
    Navigator.pop(context);
  }
}

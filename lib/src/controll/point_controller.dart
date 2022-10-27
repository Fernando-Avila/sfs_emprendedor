import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:sfs_emprendedor/src/models/point_model.dart';
import 'package:sfs_emprendedor/src/models/solicitud_model.dart';
import 'package:sfs_emprendedor/src/styles/custom_styles.dart';
import 'package:sfs_emprendedor/src/widgets/WidgetsSnack.dart';
import 'package:sfs_emprendedor/src/widgets/Widgetsdialogs.dart';
import 'package:sfs_emprendedor/src/widgets/widgettext.dart';

class PointController extends ControllerMVC {
  late BuildContext context;
  late Solicitud solicitud;
  final ciudad = TextEditingController();
  final direccion = TextEditingController();
  bool confirmsave = false;
  GlobalKey<FormState> PointFormKey = GlobalKey();
  Future<void> SavePoint() async {
    if (PointFormKey.currentState!.validate()) {
      await ConfirmSave(AlertConfirmAutorization());
      if (confirmsave) {
        Point point = Point(
            undertakingId: solicitud.id,
            ciudad: ciudad.text,
            direccion: direccion.text,
            latitud: -0.19568419561323003,
            longitud: -78.49399780283271);
        // ConfirmSave(
        //     ChargueDialog(context, 'Cargando', 'Subiendo Archivo al servidor'));
        var value = await httpRegisterPointUndertakingPost(point, 'token');
        // await Future.delayed(Duration(seconds: 1));
        // Navigator.pop(context);
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
                'Ubicacion Actualizada',
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
        } else {
          ScaffoldMessenger.of(context).showSnackBar(snackBarerror);
        }
      }
    }
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
            'Montserrat', FontWeight.w500, FontStyle.normal),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: p1(
            'Se registrará la ubicación de su emprendimiento, una vez registrada la información no se permite modificar, ni eliminar la misma',
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
}

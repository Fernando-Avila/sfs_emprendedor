import 'package:flutter/material.dart';
import 'package:sfs_emprendedor/src/styles/custom_styles.dart';
import 'package:sfs_emprendedor/src/widgets/widgettext.dart';

final snackBarerror = SnackBar(
    backgroundColor: EstiloApp.primarypurple,
    content: H5('Error de conexión', EstiloApp.colorwhite, TextAlign.left,
        'Acumin', FontWeight.w500, FontStyle.italic),
    action: SnackBarAction(
      textColor: EstiloApp.colorwhite,
      label: 'Aceptar',
      onPressed: () {},
    ));
SnackBar Snackbarespecial(String title) {
  return SnackBar(
      backgroundColor: EstiloApp.primarypink,
      content: H5(title, EstiloApp.colorwhite, TextAlign.left, 'Acumin',
          FontWeight.w500, FontStyle.italic),
      action: SnackBarAction(
        textColor: EstiloApp.colorwhite,
        label: 'Aceptar',
        onPressed: () {},
      ));
}

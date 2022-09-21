import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sfs_emprendedor/src/providers/ProviderUser.dart';
import 'package:sfs_emprendedor/src/styles/custom_styles.dart';
import 'package:sfs_emprendedor/src/widgets/widgettext.dart';

void chargescreen(BuildContext context) {
  showDialog<String>(
    //  barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SpinKitCubeGrid(
              color: EstiloApp.primaryblue,
              size: 80,
            ),
            H3('Proceso en Desarrollo', EstiloApp.primaryblue, TextAlign.center,
                'Montserrat', FontWeight.w500, FontStyle.normal),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: p1('Aceptar', EstiloApp.primaryblue, TextAlign.center,
              'Montserrat', FontWeight.w500, FontStyle.normal),
        )
      ],
    ),
  );
}

void Succes(BuildContext context, String title, int op) {
  final ProviderUser prov = Provider.of<ProviderUser>(context, listen: false);
  Timer timer = Timer(const Duration(milliseconds: 1500), () {
    if (op == 1) {
      prov.us.type == 
      
      'Inversor'
          ? Navigator.popAndPushNamed(context, '/oportunidades_page')
          : Navigator.pushNamed(context, '/mysolicitud');
    } else if (op == 2) {
      Navigator.popAndPushNamed(context, '/login');
    }
  });
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SpinKitThreeBounce(
              color: EstiloApp.primaryblue,
              size: 80,
            ),
            H3(title, EstiloApp.primaryblue, TextAlign.center, 'Montserrat',
                FontWeight.w800, FontStyle.normal),
          ],
        ),
      ),
    ),
  );
}

void Errordialog(BuildContext context, String title) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SpinKitThreeBounce(
              color: EstiloApp.primaryblue,
              size: 80,
            ),
            H3(title, EstiloApp.primaryblue, TextAlign.center, 'Montserrat',
                FontWeight.w500, FontStyle.normal),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: p1('Aceptar', EstiloApp.primaryblue, TextAlign.center,
              'Montserrat', FontWeight.w500, FontStyle.normal),
        )
      ],
    ),
  );
}

void Chargueaccountdialog(BuildContext context, String title) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SpinKitThreeBounce(
              color: EstiloApp.primaryblue,
              size: 80,
            ),
            H3(title, EstiloApp.primaryblue, TextAlign.center, 'Montserrat',
                FontWeight.w500, FontStyle.normal)
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: p1('Cancelar', EstiloApp.primaryblue, TextAlign.center,
              'Montserrat', FontWeight.w500, FontStyle.normal),
        )
      ],
    ),
  );
}

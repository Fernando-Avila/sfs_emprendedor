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
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  H3(
                      'Proceso en Desarrollo',
                      EstiloApp.primaryblue,
                      TextAlign.left,
                      'Montserrat',
                      FontWeight.w500,
                      FontStyle.normal),
                  SizedBox(
                    height: 40,
                  ),
                  SpinKitCubeGrid(
                    color: EstiloApp.primaryblue,
                    size: 80,
                  ),
                ],
              ),
            ),
          ));
}

chargescreen2(BuildContext context) {
  return AlertDialog(
    content: SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          H5('Proceso en Desarrollo', EstiloApp.primaryblue, TextAlign.left,
              'Montserrat', FontWeight.w400, FontStyle.normal),
          SpinKitCircle(
            color: EstiloApp.primarypurple,
            size: 80,
          ),
        ],
      ),
    ),
  );
}

ChargueDialog(BuildContext context, String title, String text) {
  return AlertDialog(
    title: SizedBox(
      width: 400,
      height: 30,
      child: H2(title, EstiloApp.primaryblue, TextAlign.left, 'Montserrat',
          FontWeight.w400, FontStyle.normal),
    ),
    content: SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          H5(text, EstiloApp.primaryblue, TextAlign.left, 'Montserrat',
              FontWeight.w400, FontStyle.normal),
          SpinKitCircle(
            color: EstiloApp.primarypurple,
            size: 80,
          ),
        ],
      ),
    ),
  );
}

void chargedialog(BuildContext context, String title, String text) {
  showDialog<String>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.all(50),
      title: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 40,
        child: H2(title, EstiloApp.primarypink, TextAlign.center, 'Acumin',
            FontWeight.w600, FontStyle.normal),
      ),
      content: Container(
        color: Colors.transparent,
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitCircle(
              color: EstiloApp.primarypurple,
              size: 80,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: H3(text, EstiloApp.primarypink, TextAlign.center, 'Acumin',
                  FontWeight.w600, FontStyle.normal),
            ),
          ],
        ),
      ),
    ),
  );
}

void SuccesAction(BuildContext context, String title, int op) {
  final ProviderUser prov = Provider.of<ProviderUser>(context, listen: false);
  Timer timer = Timer(Duration(milliseconds: 1500), () {
    Navigator.popAndPushNamed(context, '/login');
  });
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SpinKitThreeBounce(
              color: EstiloApp.primaryblue,
              size: 80,
            ),
            p2(title, EstiloApp.primaryblue, TextAlign.center, 'Montserrat',
                FontWeight.w800, FontStyle.normal),
          ],
        ),
      ),
    ),
  );
}

void Succes(BuildContext context, String title, int op) {
  final ProviderUser prov = Provider.of<ProviderUser>(context, listen: false);
  Timer timer = Timer(Duration(milliseconds: 1500), () {
    Navigator.popAndPushNamed(context, '/login');
    /* if (op == 1) {
      prov.us.type == 
      
      'Inversor'
          ? Navigator.popAndPushNamed(context, '/oportunidades_page')
          : Navigator.pushNamed(context, '/mysolicitud');
    } else if (op == 2) {
      Navigator.popAndPushNamed(context, '/login');
    }*/
  });
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SpinKitThreeBounce(
              color: EstiloApp.primaryblue,
              size: 80,
            ),
            p2(title, EstiloApp.primaryblue, TextAlign.center, 'Montserrat',
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
            SpinKitThreeBounce(
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

void ErrordialogDato(BuildContext context, String title, String error) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      elevation: 24,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 26,
        child: H2(title, EstiloApp.primarypurple, TextAlign.center, 'Acumin',
            FontWeight.w700, FontStyle.normal),
      ),
      content: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.1), BlendMode.dstATop),
            image: AssetImage('asset/icons/degradado/iconlogo.png'),
            fit: BoxFit.contain,
          ),
        ),
        child: Container(
          width: 200.0,
          height: 100.0,
          padding: EdgeInsets.all(10),
          child: H3(error, EstiloApp.primaryblue, TextAlign.center, 'Acumin',
              FontWeight.w600, FontStyle.normal),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: H3('Aceptar', EstiloApp.primarypink, TextAlign.center,
              'Acumin', FontWeight.w700, FontStyle.normal),
        ),
      ],
    ),
  );
}

void errorDialogDato(BuildContext context, String error, String title) {
  showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        title: SizedBox(
          width: 200.0,
          height: 200.0,
          child: H2(title, EstiloApp.primarypurple, TextAlign.center, 'Acumin',
              FontWeight.w700, FontStyle.normal),
        ),
        content: Container(
          width: 200.0,
          height: 200.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.1), BlendMode.dstATop),
              image: AssetImage('asset/img/icons/degradado/iconlogo.png'),
              fit: BoxFit.contain,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: H4(error, EstiloApp.primaryblue, TextAlign.center, 'Acumin',
                FontWeight.w600, FontStyle.normal),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: H3('Aceptar', EstiloApp.primarypink, TextAlign.center,
                'Acumin', FontWeight.w700, FontStyle.normal),
          ),
        ],
      );
    },
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
            SpinKitThreeBounce(
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

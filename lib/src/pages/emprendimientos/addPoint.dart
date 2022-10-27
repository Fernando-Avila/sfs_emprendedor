import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:sfs_emprendedor/src/controll/point_controller.dart';
import 'package:sfs_emprendedor/src/providers/ProviderSolicitud.dart';
import 'package:sfs_emprendedor/src/providers/ProviderUser.dart';
import 'package:sfs_emprendedor/src/styles/custom_styles.dart';
import 'package:sfs_emprendedor/src/widgets/WidgetsFuncionaly.dart';
import 'package:sfs_emprendedor/src/widgets/appbar.dart';
import 'package:sfs_emprendedor/src/widgets/widgettext.dart';

class AddPoint extends StatefulWidget {
  const AddPoint({Key? key}) : super(key: key);

  @override
  _AddPointState createState() => _AddPointState();
}

class _AddPointState extends StateMVC<AddPoint> {
  PointController _con = PointController();
  @override
  Widget build(BuildContext context) {
    _con.context = context;
    final ProviderUser prov = Provider.of<ProviderUser>(context, listen: false);
    _con.context = context;
    final ProviderSolicitud provsolicitud =
        Provider.of<ProviderSolicitud>(context, listen: false);
    _con.solicitud = provsolicitud.solicitud!;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        //centerTitle: true,
        backgroundColor: EstiloApp.primaryblue,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () =>
                    Navigator.canPop(context) ? Navigator.pop(context) : {},
                icon: Icon(Icons.arrow_back_ios)),
            Expanded(
              child: H5(
                  'Agregar Ubicación',
                  EstiloApp.colorwhite,
                  TextAlign.center,
                  'Montserrat',
                  FontWeight.w500,
                  FontStyle.normal),
            ),
            SizedBox()
          ],
        ),
        leading: Builder(builder: (context) {
          return leading(context);
        }),
        actions: [
          IconButton(
              onPressed: () => prov.logged
                  ? Navigator.pushNamed(context, '/account')
                  : Navigator.pushNamed(context, '/login'),
              icon: Icon(Icons.person))
        ],
      ),
      //  body: body(),
      drawer: drawer(context),
      body: body(),
    );
  }

  Widget body() {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          color: EstiloApp.primaryblue,
        ),
        Container(
          margin: EdgeInsets.all(20),
          decoration: EstiloApp.decorationBoxwhite,
          padding: EdgeInsets.all(15),
          child: Form(
              key: _con.PointFormKey,
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  p1(
                      'Ingresa la información de la ubicación de tu emprendimiento',
                      EstiloApp.primaryblue,
                      TextAlign.center,
                      'Montserrat',
                      FontWeight.w500,
                      FontStyle.normal),
                  Textfield(
                      'Ciudad:',
                      TextInputType.text,
                      _con.ciudad,
                      TextCapitalization.sentences,
                      false,
                      () {},
                      null, (value) {
                    return validator(value!);
                  }),
                  Textfield(
                      'Direccion',
                      TextInputType.text,
                      _con.direccion,
                      TextCapitalization.sentences,
                      false,
                      () {},
                      null, (value) {
                    return validator(value!);
                  }),
                  BtnDegraded(
                      metod: () {
                        _con.SavePoint();
                      },
                      widget: H5(
                          'Guardar Dirección',
                          EstiloApp.colorwhite,
                          TextAlign.left,
                          'Montserrat',
                          FontWeight.w600,
                          FontStyle.normal),
                      width: 0.4,
                      height: 40)
                ],
              )),
        ),
      ],
    );
  }
}

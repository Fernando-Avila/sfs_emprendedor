import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:sfs_emprendedor/src/controll/user_controller.dart';
import 'package:sfs_emprendedor/src/global/environment.dart';
import 'package:sfs_emprendedor/src/providers/ProviderUser.dart';
import 'package:sfs_emprendedor/src/styles/custom_styles.dart';
import 'package:sfs_emprendedor/src/widgets/WidgetsFuncionaly.dart';
import 'package:sfs_emprendedor/src/widgets/appbar.dart';
import 'package:sfs_emprendedor/src/widgets/widgettext.dart';

import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Autorizacion extends StatefulWidget {
  const Autorizacion({Key? key}) : super(key: key);

  @override
  _AutorizacionState createState() => _AutorizacionState();
}

class _AutorizacionState extends StateMVC<Autorizacion> {
  UserController _con = UserController();

  @override
  Widget build(BuildContext context) {
    final ProviderUser prov = Provider.of<ProviderUser>(context, listen: false);
    _con.context = context;
    _con.user = prov.user!;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: EstiloApp.primaryblue,
        title: Row(
          children: [
            IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios)),
            Expanded(
              child: p2(
                  'Autorización de Buro',
                  EstiloApp.colorwhite,
                  TextAlign.center,
                  'Montserrat',
                  FontWeight.w400,
                  FontStyle.normal),
            ),
          ],
        ),
        leading: Builder(builder: (context) {
          return leading(context);
        }),
      ),
      body: body(),
      drawer: drawer(context),
    );
  }

  Widget body() {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Wrap(
                spacing: 30,
                runSpacing: 15,
                alignment: WrapAlignment.spaceBetween,
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Parraftext(
                      widget: Column(
                        children: <Widget>[
                          p1(
                              'SFS necesita una autorización de Buro para revisar tu perfil crediticio, puedes subir el documento, antes descargando el modelo',
                              EstiloApp.primaryblue,
                              TextAlign.center,
                              'Montserrat',
                              FontWeight.w400,
                              FontStyle.normal),
                          Link(
                            uri: Uri.parse(
                                '${Enviroment.apiUrl}argon/pdf/autorizacionBuro.pdf'),
                            target: LinkTarget.blank,
                            builder: (BuildContext ctx, FollowLink? openLink) {
                              return Container(
                                  decoration: EstiloApp.decorationBoxwhite,
                                  child: TextButton.icon(
                                    onPressed: openLink,
                                    label: H5(
                                        'Descargar',
                                        EstiloApp.primaryblue,
                                        TextAlign.center,
                                        'Montserrat',
                                        FontWeight.w600,
                                        FontStyle.normal),
                                    icon: Icon(
                                      Icons.download,
                                      color: EstiloApp.primaryblue,
                                    ),
                                  ));
                            },
                          ),
                        ],
                      ),
                      width: 50,
                      height: 40),
                  Visibility(
                    visible: _con.user.autorizacionBuro == null,
                    maintainSize: false,
                    child: BtnWhite(
                        metod: () async {
                          await _con.getFile();
                        },
                        widget: H4(
                            'inspeccionar',
                            EstiloApp.primaryblue,
                            TextAlign.center,
                            'Montserrat',
                            FontWeight.w600,
                            FontStyle.normal),
                        width: 0.4,
                        height: 40),
                  ),
                  Visibility(
                    visible: _con.user.autorizacionBuro == null,
                    maintainSize: false,
                    child: BtnDegraded(
                        metod: () async {
                          await _con.uploadFile();
                        },
                        widget: H4(
                            'Guardar',
                            EstiloApp.colorwhite,
                            TextAlign.center,
                            'Montserrat',
                            FontWeight.w600,
                            FontStyle.normal),
                        width: 0.4,
                        height: 40),
                  ),
                  Visibility(
                    visible: _con.user.autorizacionBuro != null,
                    child: Parraftext(
                        widget: Column(
                          children: <Widget>[
                            H3(
                                'Correcto',
                                EstiloApp.primarypurple,
                                TextAlign.center,
                                'Montserrat',
                                FontWeight.w600,
                                FontStyle.normal),
                            H4(
                                'Se ha registrado exitosamente tu documento, lo puedes revisar descargándolo',
                                EstiloApp.primaryblue,
                                TextAlign.center,
                                'Montserrat',
                                FontWeight.w400,
                                FontStyle.normal),
                            Link(
                              uri: Uri.parse(
                                  '${Enviroment.apiUrl}uploads/${_con.user.autorizacionBuro}'),
                              target: LinkTarget.blank,
                              builder:
                                  (BuildContext ctx, FollowLink? openLink) {
                                return Container(
                                    decoration: EstiloApp.decorationBoxwhite,
                                    child: TextButton.icon(
                                      onPressed: openLink,
                                      label: H5(
                                          'Descargar',
                                          EstiloApp.primaryblue,
                                          TextAlign.center,
                                          'Montserrat',
                                          FontWeight.w600,
                                          FontStyle.normal),
                                      icon: Icon(
                                        Icons.download,
                                        color: EstiloApp.primaryblue,
                                      ),
                                    ));
                              },
                            ),
                          ],
                        ),
                        width: 50,
                        height: 40),
                  ),
                ]),
          ),
          /* Link(
            uri: Uri.parse('http://192.168.1.51:8000/pdf'),
            target: LinkTarget.blank,
            builder: (BuildContext ctx, FollowLink? openLink) {
              return Container(
                  decoration: EstiloApp.decorationBoxwhite,
                  child: TextButton.icon(
                    onPressed: openLink,
                    label: H5(
                        'Descargar',
                        EstiloApp.primaryblue,
                        TextAlign.center,
                        'Montserrat',
                        FontWeight.w600,
                        FontStyle.normal),
                    icon: Icon(
                      Icons.download,
                      color: EstiloApp.primaryblue,
                    ),
                  ));
            },
          ),*/
          Visibility(
            visible: _con.user.autorizacionBuro == null,
            child: Form(
              key: _con.pdfFormKey,
              child: Textfield(
                  'Autorizacion',
                  TextInputType.text,
                  _con.burotext,
                  TextCapitalization.characters,
                  true,
                  () {
                    setState(() {});
                  },
                  Icon(
                    Icons.dashboard_customize,
                    color: EstiloApp.primaryblue,
                  ),
                  (value) {
                    return validator(value!);
                  }),
            ),
          )
        ],
      ),
    );
  }
}

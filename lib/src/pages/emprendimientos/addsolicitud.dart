import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:sfs_emprendedor/src/controll/solicitud_controller.dart';
import 'package:sfs_emprendedor/src/pages/form/comofunciona.dart';
import 'package:sfs_emprendedor/src/providers/ProviderUser.dart';
import 'package:sfs_emprendedor/src/styles/custom_styles.dart';
import 'package:sfs_emprendedor/src/widgets/WidgetsFuncionaly.dart';
import 'package:sfs_emprendedor/src/widgets/Widgetsdesign.dart';
import 'package:sfs_emprendedor/src/widgets/appbar.dart';
import 'package:sfs_emprendedor/src/widgets/widgettext.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:image_picker/image_picker.dart';

class Addsolicitud extends StatefulWidget {
  Addsolicitud({Key? key}) : super(key: key);

  @override
  _AddsolicitudState createState() => _AddsolicitudState();
}

class _AddsolicitudState extends StateMVC<Addsolicitud> {
  SolicitudController _con = SolicitudController();
  @override
  Widget build(BuildContext context) {
    final ProviderUser prov = Provider.of<ProviderUser>(context, listen: false);
    _con.context = context;
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
              child: H3(
                  'CREAR SOLICITUD',
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
      body: body(),
      drawer: drawer(context),
    );
  }

  Widget body() {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.22,
          width: MediaQuery.of(context).size.width,
          //padding: EdgeInsets.only(bottom: ),
          color: EstiloApp.primaryblue,
        ),
        PageView(
          controller: _con.pageController,
          scrollDirection: Axis.vertical,
          children: [Calculador(), datos()],
        )
      ],
    );
  }

  Widget datos() {
    return Container(
      decoration: EstiloApp.decorationBoxwhite,
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(20),
      child: Form(
        key: _con.addsolicitudkeyform,
        child: ListView(
          //   alignment: WrapAlignment.center,
          //   crossAxisAlignment: WrapCrossAlignment.center,

          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: H3(
                  'Datos Generales',
                  EstiloApp.primarypink,
                  TextAlign.center,
                  'Montserrat',
                  FontWeight.w500,
                  FontStyle.normal),
            ),
            p1(
                'Completa el formulario para tu solicitud',
                EstiloApp.primaryblue,
                TextAlign.justify,
                'Montserrat',
                FontWeight.w400,
                FontStyle.normal),
            Textfield('Nombre Emprendimiento', TextInputType.text, _con.nombre,
                TextCapitalization.sentences, false, () {}, null, (value) {
              return validator(value!);
            }),
            Textfieldml(
                'Descripcion del Emprendimiento',
                _con.descripcion,
                TextCapitalization.sentences,
                false,
                () {},
                ToolTipeDesing(
                    title: 'Describe un poco tu emprendimiento',
                    color: EstiloApp.primarypink), (value) {
              return validator(value!);
            }),
            Textfield(
                'Tipo de Financiamiento',
                TextInputType.text,
                _con.tipo_financiamiento,
                TextCapitalization.sentences,
                false,
                () {},
                null, (value) {
              return validator(value!);
            }),
            Dropdown(_con.categoria_list, _con.categoria_financiamiento,
                EstiloApp.colorwhite, 0.8, 'Categoria', () {}),
            Dropdown(_con.categorianegocio_list, _con.categoria_negocio,
                EstiloApp.colorwhite, 0.8, 'Sector', () {}),
            Dropdown(_con.frecuencia_list, _con.frecuencia,
                EstiloApp.colorwhite, 0.8, 'Frecuencia de pago', () {}),
            cams(_con.foto_emprendimiento, 'Foto de tu emprendimiento'),
            /*texfield('Frecuencia de Pagos', frecuenciapagos),
            texfield('Categoría de negocio', categoria),
            texfield('Tipo de financiamiento', tipo),
            texfield('Tu Emprendimiento', emprendimiento),
            texfield('Sobre ti', sobreti),
            texfield('Ubicacíon Emprendimiento', ubicacion),
            texfield('Redes Sociales', redes),
            texfield('Pagina Web', web),
            texfield('Ruc', ruc),*/

            Wrap(
              alignment: WrapAlignment.center,
              children: [
                BtnDegraded(
                    metod: () {
                      _con.register1();
                    },
                    widget: H4(
                        'Generar Solicitud',
                        EstiloApp.colorwhite,
                        TextAlign.center,
                        'Montserrat',
                        FontWeight.w600,
                        FontStyle.normal),
                    width: 0.6,
                    height: 40),
              ],
            )
            /*InkWell(
              borderRadius: BorderRadius.circular(60),
              splashColor: Colors.grey,
              onTap: () => chargescreen(context),
              child: Container(
                padding:  EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                decoration: BoxDecoration(
                    gradient: EstiloApp.horizontalgradientpurplepink,
                    borderRadius: BorderRadius.circular(60)),
                child: p2(
                    'Generar Solicitud',
                    EstiloApp.colorwhite,
                    TextAlign.center,
                    'Montserrat',
                    FontWeight.w400,
                    FontStyle.normal),
              ),
            ),*/
          ],
        ),
      ),
    );
  }

  Widget Calculador() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ListView(children: [
        calc(),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: tablaAmortizacion(amortizacion: calculo()),
        ),
      ]),
    );
  }

  Widget calc() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 4,
                offset: Offset(2, 2),
              ),
            ],
            color: EstiloApp.colorwhite,
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    p2('Capital:', EstiloApp.primaryblue, TextAlign.center,
                        'Montserrat', FontWeight.w500, FontStyle.normal),
                    text('US \$${_con.capital}', 5)
                  ],
                ),
                SfSlider(
                  min: 0.0,
                  max: 5000,
                  value: _con.capital,
                  activeColor: EstiloApp.primaryblue,
                  stepSize: 500,
                  interval: 1000,
                  showTicks: true,
                  showLabels: true,
                  enableTooltip: true,
                  showDividers: true,
                  minorTicksPerInterval: 1,
                  labelFormatterCallback:
                      (dynamic actualValue, String formattedText) {
                    return '\$$formattedText';
                  },
                  onChanged: (dynamic value) {
                    setState(() {
                      _con.capital = value;
                      calcular();
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    p2('Plazo:', EstiloApp.primaryblue, TextAlign.center,
                        'Montserrat', FontWeight.w500, FontStyle.normal),
                    text('${_con.plazo} meses', 10)
                  ],
                ),
                SfSlider(
                  min: 3,
                  max: 24,
                  value: _con.plazo,
                  activeColor: EstiloApp.primaryblue,
                  stepSize: 3,
                  interval: 3,
                  showTicks: true,
                  showLabels: true,
                  showDividers: true,
                  onChanged: (dynamic value) {
                    setState(() {
                      _con.plazo = value;
                      calcular();
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    p2(
                        'Tasa de Interes:',
                        EstiloApp.primaryblue,
                        TextAlign.center,
                        'Montserrat',
                        FontWeight.w500,
                        FontStyle.normal),
                    text('${_con.tir}% Anual', 5)
                  ],
                ),
                SfSlider(
                  min: 14,
                  max: 30,
                  value: _con.tir,
                  activeColor: EstiloApp.primaryblue,
                  stepSize: 2,
                  interval: 2,
                  showTicks: true,
                  showLabels: true,
                  showDividers: true,
                  labelFormatterCallback:
                      (dynamic actualValue, String formattedText) {
                    return '$formattedText%';
                  },
                  onChanged: (dynamic value) {
                    setState(() {
                      _con.tir = value;
                      calcular();
                    });
                  },
                ),
                /*Dropdown(_con.frecuencia_list, _con.frecuencia,
                    EstiloApp.colorwhite, 0.8, 'Frecuencia de pago', () {
                  setState(() {
                    print('tocado');
                    _con.frecuencia;
                  });
                }),*/
                Container(
                  margin: EdgeInsets.all(12),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: EstiloApp.primaryblue,
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: <Widget>[
                          p2(
                              'CUOTA MENSUAL:',
                              EstiloApp.colorwhite,
                              TextAlign.center,
                              'Montserrat',
                              FontWeight.w500,
                              FontStyle.normal),
                          H3(
                              'US\$${(_con.total).toStringAsFixed(2)}',
                              EstiloApp.colorwhite,
                              TextAlign.center,
                              'Montserrat',
                              FontWeight.w500,
                              FontStyle.normal),
                        ],
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: EstiloApp.primarypink,
                          padding:
                              EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                          shadowColor: EstiloApp.primarypurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                        onPressed: () => _con.pageController.nextPage(
                            duration: Duration(seconds: 1),
                            curve: Curves.easeInOut),
                        child: p2(
                            'Continuar',
                            EstiloApp.colorwhite,
                            TextAlign.center,
                            'Montserrat',
                            FontWeight.w400,
                            FontStyle.normal),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget cams(File? imagen, String title) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: EstiloApp.colorwhite,
          borderRadius: BorderRadius.circular(20),
          boxShadow: kElevationToShadow[2],
          border: Border.all(width: 0.05)),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            color: Colors.white,
            child: imagen == null
                ? Padding(
                    padding: EdgeInsets.only(top: 40, bottom: 10),
                    child: Image.asset(
                      'asset/img/placeholder.png',
                    ))
                : Padding(
                    padding: EdgeInsets.only(top: 40, bottom: 10),
                    child: Image.file(
                      imagen,
                    ),
                  ),
          ),
          Container(
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: p1(title, EstiloApp.primaryblue, TextAlign.left,
                      'Acumin', FontWeight.w600, FontStyle.normal),
                ),
                ToolTipeDesing(
                  title: 'Una foto que identifique tu emprendimiento.',
                  color: EstiloApp.primarypurple,
                ),
                InkWell(
                  onTap: () async {
                    _con.foto_emprendimiento =
                        await _con.getImage(ImageSource.gallery);
                    setState(() {});
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 20, right: 10),
                    child: Icon(
                      Icons.file_upload,
                      size: 30.0,
                      color: EstiloApp.primarypink,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    _con.foto_emprendimiento =
                        await _con.getImage(ImageSource.camera);
                    setState(() {});
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0, right: 10.0),
                    child: Icon(
                      Icons.camera_alt,
                      size: 30.0,
                      color: EstiloApp.primarypurple,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<List> calculo() {
    List<List> amortizacion = [];
    double capital = 0;
    double interes = 0;
    double valor = _con.capital + (_con.capital * ((_con.tir / 100)));
    double interesmensual = ((_con.tir / 12) / 100);
    print(valor);
    double pagomes =
        (_con.capital / _con.plazo) + (_con.capital * interesmensual);

    for (var i = 0; i < _con.plazo; i++) {
      interes = valor * (((_con.tir / _con.plazo) / 100));
      capital = pagomes - interes;
      List mes = [
        capital,
        interes,
        // recibes += pagomes + (valor * 0.02),
        pagomes,
      ];
      valor -= pagomes;
      amortizacion.add(mes);
    }
    return amortizacion;
  }

  void calcular() {
    double interesmensual = (_con.tir / 12) / 100;
    _con.total = (_con.capital / _con.plazo) + (_con.capital * interesmensual);
  }
}

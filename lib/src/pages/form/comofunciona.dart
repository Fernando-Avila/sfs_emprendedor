import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfs_emprendedor/src/providers/ProviderUser.dart';
import 'package:sfs_emprendedor/src/styles/custom_styles.dart';
import 'package:sfs_emprendedor/src/widgets/Widgetgeneral.dart';
import 'package:sfs_emprendedor/src/widgets/Widgetsdialogs.dart';
import 'package:sfs_emprendedor/src/widgets/appbar.dart';
import 'package:sfs_emprendedor/src/widgets/funciones.dart';
import 'package:sfs_emprendedor/src/widgets/widgettext.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class Comofunciona extends StatefulWidget {
   Comofunciona({Key? key}) : super(key: key);

  @override
  _ComofuncionaState createState() => _ComofuncionaState();
}

class _ComofuncionaState extends State<Comofunciona> {
  double _capital = 0;
  int _interes = 14;
  int _plazo = 3;
  double _total = 0;
  @override
  Widget build(BuildContext context) {
    final ProviderUser prov = Provider.of<ProviderUser>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => prov.logged
                  ? Navigator.pushNamed(context, '/account')
                  : Navigator.pushNamed(context, '/login'),
              icon:  Icon(Icons.person))
        ],
        elevation: 0,
        // centerTitle: true,
        backgroundColor: EstiloApp.primaryblue,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () => Navigator.maybePop(context),
                icon: Icon(Icons.arrow_back_ios)),
            //textH3('COMO FUNCIONA', EstiloApp.colorwhite, FontWeight.w100),
            SizedBox()
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
    return ListView(
      children: [
        info(),
         Divider(
          height: 20,
          thickness: 3,
          indent: 30,
          endIndent: 30,
          color: EstiloApp.primaryblue,
        ),
        calc(),
      ],
    );
  }

  Widget info() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      height: MediaQuery.of(context).size.height * 0.36,
      child: Column(
        children: [
          p2(
              'Creemos que la rentabilidad con impacto social es posible.Ponemos en contacto a pequeños y medianos emprendedores que necesitan financiamiento con inversionistas que conceden los recursos.',
              EstiloApp.primaryblue,
              TextAlign.center,
              'Montserrat',
              FontWeight.w300,
              FontStyle.normal),
          Padding(
            padding:  EdgeInsets.only(top: 20),
            child: p2(
                'Juntos definen las condiciones que los harán crecer. Nosotros nos encargamos de hacerlo posible.',
                EstiloApp.primarypink,
                TextAlign.center,
                'Montserrat',
                FontWeight.w300,
                FontStyle.normal),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                button('SOCIOS', 'asset/icons/degradado/iconsocio.png', 1),
                Image.asset(
                  'asset/icons/degradado/iconlogo.png',
                ),
                button('INVERSIONISTAS',
                    'asset/icons/degradado/iconinversionista.png', 2),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget calc() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                inf('asset/icons/azules/iconcalc.png', '1.Calcula tu cuota',
                    context),
                inf('asset/icons/azules/iconsolicitud.png',
                    '2.Llena la solicitud', context),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                inf('asset/icons/azules/iconsend.png',
                    '3.Envía tu informacion financiera', context),
                inf('asset/icons/azules/iconcheck.png',
                    '4.Acepta las condiciones de financiamiento', context),
              ],
            ),
            Padding(
              padding:  EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Container(
                padding:
                     EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    boxShadow:  [
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
                            p2(
                                'Capital:',
                                EstiloApp.primaryblue,
                                TextAlign.center,
                                'Montserrat',
                                FontWeight.w500,
                                FontStyle.normal),
                            text('US \$$_capital', 5)
                          ],
                        ),
                        SfSlider(
                          min: 0.0,
                          max: 5000,
                          value: _capital,
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
                              _capital = value;
                              _total =
                                  calcularvalores(_capital, _plazo, _interes);
                            });
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            p2(
                                'Plazo:',
                                EstiloApp.primaryblue,
                                TextAlign.center,
                                'Montserrat',
                                FontWeight.w500,
                                FontStyle.normal),
                            text('$_plazo meses', 10)
                          ],
                        ),
                        SfSlider(
                          min: 3,
                          max: 24,
                          value: _plazo,
                          activeColor: EstiloApp.primaryblue,
                          stepSize: 3,
                          interval: 3,
                          showTicks: true,
                          showLabels: true,
                          showDividers: true,
                          enableTooltip: true,
                          onChanged: (dynamic value) {
                            setState(() {
                              _plazo = value.toInt();
                              _total =
                                  calcularvalores(_capital, _plazo, _interes);
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
                            text('$_interes% Anual', 5)
                          ],
                        ),
                        SfSlider(
                          min: 14,
                          max: 30,
                          value: _interes,
                          activeColor: EstiloApp.primaryblue,
                          stepSize: 2,
                          interval: 2,
                          showTicks: true,
                          showLabels: true,
                          showDividers: true,
                          enableTooltip: true,
                          labelFormatterCallback:
                              (dynamic actualValue, String formattedText) {
                            return '$formattedText%';
                          },
                          onChanged: (dynamic value) {
                            setState(() {
                              _interes = value.toInt();
                              _total =
                                  calcularvalores(_capital, _plazo, _interes);
                            });
                          },
                        ),
                        Padding(
                          padding:  EdgeInsets.all(12),
                          child: Container(
                            padding:  EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
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
                                        'US\$${(_total).toStringAsFixed(2)}',
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
                                    padding:  EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 5),
                                    shadowColor: EstiloApp.primarypurple,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                  ),
                                  onPressed: () => chargescreen(context),
                                  child: Text('compartir'),
                                  //child: textp2('Compartir', EstiloApp.colorwhite,
                                  //FontWeight.normal)
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget button(String title, String img, int op) {
    return InkWell(
        splashColor: EstiloApp.primarypurple,
        onTap: () => chargescreen(context),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Image.asset(
                img,
              ),
            ),
            //text(title, 10),
          ],
        ));
  }
}

Widget text(String title, double pd) {
  return Padding(
    padding: EdgeInsets.only(top: pd),
    child: Container(
      padding:  EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: EstiloApp.primaryblue, borderRadius: BorderRadius.circular(5)),
      child: p3(title, EstiloApp.colorwhite, TextAlign.center, 'Montserrat',
          FontWeight.w400),
    ),
  );
}

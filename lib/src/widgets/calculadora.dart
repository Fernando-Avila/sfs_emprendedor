import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfs_emprendedor/src/providers/ProviderUser.dart';
import 'package:sfs_emprendedor/src/styles/custom_styles.dart';
import 'package:sfs_emprendedor/src/widgets/Widgetsdesign.dart';
import 'package:sfs_emprendedor/src/widgets/Widgetsdialogs.dart';
import 'package:sfs_emprendedor/src/widgets/appbar.dart';
import 'package:sfs_emprendedor/src/widgets/widgettext.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({Key? key}) : super(key: key);

  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  double _capital = 0;
  double _interes = 14;
  double _plazo = 3;
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
              icon: const Icon(Icons.person))
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
            // textH3('Calculadora', EstiloApp.colorwhite, FontWeight.w100),
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
    return Padding(
      padding: EdgeInsets.all(10),
      child: ListView(children: [
        calc(),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: tablaAmortizacion(amortizacion: calculo()),
        )
      ]),
    );
  }

  Widget calc() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            boxShadow: const [
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
                    p2('TCapital:', EstiloApp.primaryblue, TextAlign.center,
                        'Montserrat', FontWeight.w500, FontStyle.normal),
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
                      calcular();
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    p2('Plazo:', EstiloApp.primaryblue, TextAlign.center,
                        'Montserrat', FontWeight.w500, FontStyle.normal),
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
                  onChanged: (dynamic value) {
                    setState(() {
                      _plazo = value;
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
                  labelFormatterCallback:
                      (dynamic actualValue, String formattedText) {
                    return '$formattedText%';
                  },
                  onChanged: (dynamic value) {
                    setState(() {
                      _interes = value;
                      calcular();
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 5),
                            shadowColor: EstiloApp.primarypurple,
                            shape:  RoundedRectangleBorder(
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
    );
  }

  Widget text(String title, double pd) {
    return Padding(
      padding: EdgeInsets.only(top: pd),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: EstiloApp.primaryblue,
            borderRadius: BorderRadius.circular(5)),
        child: p3(title, EstiloApp.colorwhite, TextAlign.center, 'Montserrat',
            FontWeight.w400),
      ),
    );
  }

  void calcular() {
    double interesmensual = (_interes / 12) / 100;
    // print(interesmensual);
    //print(_capital / _plazo);
    //print((_capital / _plazo) * interesmensual);
    _total = (_capital / _plazo) + (_capital * interesmensual);
  }

  List<List> calculo() {
    List<List> amortizacion = [];
    double capital = 0;
    double interes = 0;
    double valor = _capital + (_capital * (_interes / 100));
    double interesmensual = (_interes / 12) / 100;
    print(valor);
    double pagomes = (_capital / _plazo) + (_capital * interesmensual);

    for (var i = 0; i < _plazo; i++) {
      interes = valor * ((_interes / _plazo) / 100);
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
}

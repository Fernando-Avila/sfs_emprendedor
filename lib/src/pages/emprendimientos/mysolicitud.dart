import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:sfs_emprendedor/src/controll/solicitud_controller.dart';
import 'package:sfs_emprendedor/src/global/environment.dart';
import 'package:sfs_emprendedor/src/global/routes.dart';
import 'package:sfs_emprendedor/src/models/solicitud_model.dart';
import 'package:sfs_emprendedor/src/providers/ProviderSolicitud.dart';
import 'package:sfs_emprendedor/src/providers/ProviderUser.dart';
import 'package:sfs_emprendedor/src/styles/custom_styles.dart';
import 'package:sfs_emprendedor/src/widgets/WidgetsFuncionaly.dart';
import 'package:sfs_emprendedor/src/widgets/Widgetsdesign.dart';
import 'package:sfs_emprendedor/src/widgets/appbar.dart';
import 'package:sfs_emprendedor/src/widgets/widgettext.dart';

class Mysolicitud extends StatefulWidget {
  Mysolicitud({Key? key}) : super(key: key);

  @override
  _MysolicitudState createState() => _MysolicitudState();
}

class _MysolicitudState extends StateMVC<Mysolicitud> {
  SolicitudController _con = SolicitudController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ProviderUser prov = Provider.of<ProviderUser>(context, listen: false);
    _con.context = context;
    return RefreshIndicator(
      displacement: 250,
      backgroundColor: EstiloApp.colorwhite,
      color: EstiloApp.primarypurple,
      strokeWidth: 3,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: () async {
        await _con.memoizer.runOnce(() async {
          return await _con.GetSolicitudAplicant();
        });
        return setState(() {});
      },
      child: Scaffold(
        key: _con.scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: EstiloApp.primaryblue,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back_ios)),
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
      ),
    );
  }

  Widget body() {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.22,
          width: MediaQuery.of(context).size.width,
          color: EstiloApp.primaryblue,
        ),
        FutureBuilder(
          future: _con.memoizer.runOnce(() async {
            return await _con.GetSolicitudAplicant();
          }),
          builder: (context, snapshot) {
            Widget children = SizedBox();
            if (snapshot.hasData) {
              List data = snapshot.data as List;
              print(data);
              children = data.isNotEmpty
                  ? PageView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, i) {
                        return _detailsolicitud(context, i, data[i]);
                      })
                  : Container(
                      padding: EdgeInsets.all(30),
                      alignment: Alignment.center,
                      child: Wrap(
                        spacing: 20,
                        runSpacing: 10,
                        alignment: WrapAlignment.center,
                        runAlignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: <Widget>[
                          Image.asset('asset/icons/degradado/iconlogo.png'),
                          H3(
                              'Empieza creando una solicitud',
                              EstiloApp.primaryblue,
                              TextAlign.center,
                              'Montserrat',
                              FontWeight.w500,
                              FontStyle.normal),
                          BtnDegraded(
                              metod: () {
                                Navigator.pushReplacementNamed(
                                    context, '/addsolicitud');
                              },
                              widget: H3(
                                  'Solicitar',
                                  EstiloApp.colorwhite,
                                  TextAlign.center,
                                  'Montserrat',
                                  FontWeight.w600,
                                  FontStyle.normal),
                              width: 0.5,
                              height: 50)
                        ],
                      ),
                    );
            } else if (snapshot.hasError) {
              children = ErrorChargue(color: EstiloApp.colorblack);
            } else {
              children = chargueSolicitud();
            }
            return children;
          },
        ),
      ],
    );
  }

  Widget literal(String title, String text, MaterialColor color) {
    return Column(
      children: <Widget>[
        H4(title, color, TextAlign.center, 'Montserrat', FontWeight.w700,
            FontStyle.normal),
        p2(text, color, TextAlign.center, 'Montserrat', FontWeight.w500,
            FontStyle.normal),
      ],
    );
  }

  Widget _detailsolicitud(BuildContext context, int index, Solicitud data) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(right: 20, left: 20, bottom: 10),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black54,
          blurRadius: 4,
          offset: Offset(2, 2),
        ),
      ], color: EstiloApp.colorwhite, borderRadius: BorderRadius.circular(35)),
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: size.height * 0.15,
            child: Stack(
              children: [
                CachedNetworkImage(
                  //mageUrl: data.photoEmprendimiento,
                  imageUrl:
                      '${Enviroment.apiUrl}storage/${data.photoEmprendimiento}',
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35)),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(35),
                              topRight: Radius.circular(35)),
                          gradient: EstiloApp.horizontalgradienttransparent),
                    ),
                  ),
                  /*Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50)),
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              'https://pbs.twimg.com/profile_images/945853318273761280/0U40alJG_400x400.jpg'),
                          fit: BoxFit.cover)),
                  child: Container(
                    decoration:  BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50)),
                        gradient: EstiloApp.horizontalgradienttransparent),
                  ),
                ),*/
                  /*Container(
                  padding: EdgeInsets.all(22),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      textp1('Capital de Trabajo', EstiloApp.colorwhite,
                          FontWeight.bold),
                      textp2('Ana Yepez Saenz', EstiloApp.colorwhite,
                          FontWeight.w500),
                      textp1('C9SF01', EstiloApp.colorwhite, FontWeight.bold)
                    ],
                  ),
                ),*/
                ),
                Container(
                  padding: EdgeInsets.all(22),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      H5(
                          '${data.nameUndertaking}',
                          EstiloApp.colorwhite,
                          TextAlign.center,
                          'Montserrat',
                          FontWeight.w700,
                          FontStyle.normal),
                      H5(
                          '${data.tipoFinanciamiento}',
                          EstiloApp.colorwhite,
                          TextAlign.center,
                          'Montserrat',
                          FontWeight.w700,
                          FontStyle.normal),
                      p1(
                          data.categoriaEmprendimiento,
                          EstiloApp.colorwhite,
                          TextAlign.center,
                          'Montserrat',
                          FontWeight.w700,
                          FontStyle.normal),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: Wrap(
              spacing: 10,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          H2(
                              '\$${data.montoSolicitado}',
                              EstiloApp.primaryblue,
                              TextAlign.center,
                              'Montserrat',
                              FontWeight.w700,
                              FontStyle.normal),
                          H4(
                              '\$${data.valorRecolectado} (${porcentaje(data.montoSolicitado, data.valorRecolectado)}%) Recolentado',
                              EstiloApp.primaryblue,
                              TextAlign.left,
                              'Montserrat',
                              FontWeight.w400,
                              FontStyle.normal),
                        ],
                      ),
                    ),
                    BtnDegraded(
                        metod: () async {
                          final ProviderSolicitud provsolicitud =
                              Provider.of<ProviderSolicitud>(context,
                                  listen: false);
                          provsolicitud.solicitud = data;
                          Navigator.pushNamed(
                              context, PageRoutes().detailmysolicitud);
                        },
                        widget: H4(
                            'Detalles',
                            EstiloApp.colorwhite,
                            TextAlign.center,
                            'Montserrat',
                            FontWeight.w400,
                            FontStyle.normal),
                        width: 0.3,
                        height: 40),
                  ],
                ),
                Divider(
                  height: 30,
                  thickness: 3,
                  color: EstiloApp.primarypink,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    literal('Plazo', '${data.plazo}', EstiloApp.primaryblue),
                    literal('Industria', '${data.categoriaNegocio}',
                        EstiloApp.primaryblue),
                    literal('Tasa', '${data.tir} %', EstiloApp.primaryblue),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: tablaAmortizacion(
                amortizacion:
                    calculo(data.montoSolicitado, data.tir, data.plazo)),
          ),
        ],
      ),
    );
  }

  List<List> calculo(dynamic capital, dynamic tir, dynamic plazo) {
    List<List> amortizacion = [];

    double interes = 0;
    double valor = capital + (capital * ((tir / 100)));
    double interesmensual = ((tir / 12) / 100);
    print(valor);
    double pagomes = (capital / plazo) + (capital * interesmensual);

    for (var i = 0; i < plazo; i++) {
      interes = valor * (((tir / plazo) / 100));
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

  porcentaje(montoSolicitado, valorRecolectado) {
    double val = ((valorRecolectado * 100) / montoSolicitado);
    return val.toStringAsFixed(2);
  }
}

import 'package:animated_icon/animate_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:sfs_emprendedor/src/controll/solicitud_controller.dart';
import 'package:sfs_emprendedor/src/global/environment.dart';
import 'package:sfs_emprendedor/src/global/routes.dart';
import 'package:sfs_emprendedor/src/providers/ProviderSolicitud.dart';
import 'package:sfs_emprendedor/src/providers/ProviderUser.dart';
import 'package:sfs_emprendedor/src/styles/custom_styles.dart';
import 'package:sfs_emprendedor/src/widgets/WidgetsFuncionaly.dart';
import 'package:sfs_emprendedor/src/widgets/Widgetsdesign.dart';
import 'package:sfs_emprendedor/src/widgets/appbar.dart';
import 'package:sfs_emprendedor/src/widgets/funciones.dart';
import 'package:sfs_emprendedor/src/widgets/widgettext.dart';
import 'package:skeletons/skeletons.dart';

class Detailmysolicitud extends StatefulWidget {
  const Detailmysolicitud({Key? key}) : super(key: key);

  @override
  _DetailmysolicitudState createState() => _DetailmysolicitudState();
}

class _DetailmysolicitudState extends StateMVC<Detailmysolicitud> {
  SolicitudController _con = SolicitudController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
              child: H3('Detalles', EstiloApp.colorwhite, TextAlign.center,
                  'Montserrat', FontWeight.w500, FontStyle.normal),
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
          controller: _con.mypageController,
          children: [
            info(),
            history(),
            verify(),
            info(),
          ],
        )
      ],
    );
  }

  Widget info() {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 4,
                offset: Offset(2, 2),
              ),
            ],
            color: EstiloApp.colorwhite,
            borderRadius: BorderRadius.circular(35)),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: size.height * 0.13,
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        '${Enviroment.apiUrl}storage/${_con.solicitud.photoEmprendimiento}',
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
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //  textH3('Ana Yepez Saenz', EstiloApp.colorwhite,
                              //    FontWeight.bold),
                              Divider(
                                color: EstiloApp.colorwhite,
                                thickness: 1,
                                endIndent: size.width * 0.35,
                              ),
                            ],
                          ),
                          //textp3('Sector Publico', EstiloApp.colorwhite,
                          //FontWeight.bold),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                // child: textp5('Solicitudes Vigentes: 1/1',
                                //     EstiloApp.colorwhite, FontWeight.w100),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                      color: EstiloApp.colorwhite,
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                                // child: textp5('Solicitudes Pagadas: 0/1',
                                //   EstiloApp.colorwhite, FontWeight.w100),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                      color: EstiloApp.colorwhite,
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                                //  child: textp5('Puntuacion: 100%',
                                //    EstiloApp.colorwhite, FontWeight.w100),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: datainfo())
          ],
        ),
      ),
    );
  }

  Widget history() {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 4,
                offset: Offset(2, 2),
              ),
            ],
            color: EstiloApp.colorwhite,
            borderRadius: BorderRadius.circular(35)),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: size.height * 0.1,
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          '${Enviroment.apiUrl}storage/${_con.solicitud.photoEmprendimiento}',
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
                              gradient:
                                  EstiloApp.horizontalgradienttransparent),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                H5(
                                    'Información extra',
                                    EstiloApp.colorwhite,
                                    TextAlign.center,
                                    'Montserrat',
                                    FontWeight.w700,
                                    FontStyle.normal),
                                H5(
                                    '${_con.solicitud.nameUndertaking}',
                                    EstiloApp.colorwhite,
                                    TextAlign.center,
                                    'Montserrat',
                                    FontWeight.w700,
                                    FontStyle.normal),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              datahistory()
            ],
          ),
        ),
      ),
    );
  }

  Widget datahistory() {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Wrap(
        runAlignment: WrapAlignment.start,
        alignment: WrapAlignment.spaceBetween,
        spacing: 10,
        runSpacing: 5,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          p2(
              '${_con.solicitud.descripcionEmprendimiento}',
              EstiloApp.primaryblue,
              TextAlign.left,
              'Montserrat',
              FontWeight.w400,
              FontStyle.normal),
          FutureBuilder(
            future: _con.pointmemoizer.runOnce(() async {
              return await _con.GetPointSolicitud();
            }),
            builder: (context, snapshot) {
              Widget children = SizedBox();
              if (snapshot.hasData) {
                List data = snapshot.data as List;
                children = data.isNotEmpty
                    ? ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, i) {
                          return Ubiinfo(context, i, data[i]);
                        })
                    : BtnBlue(
                        metod: () {
                          Navigator.pushNamed(
                              context, PageRoutes().addpointmysolicitud);
                        },
                        widget: p1(
                            'Actualizar ubicacion',
                            EstiloApp.colorwhite,
                            TextAlign.justify,
                            'Montserrat',
                            FontWeight.w400,
                            FontStyle.normal),
                        width: 0.4,
                        height: 40);
              } else if (snapshot.hasError) {
              } else {
                children = SkeletonParagraph(
                    style: SkeletonParagraphStyle(
                        lines: 3,
                        spacing: 4,
                        lineStyle: SkeletonLineStyle(
                          randomLength: true,
                          height: 10,
                          borderRadius: BorderRadius.circular(8),
                          minLength: MediaQuery.of(context).size.width / 3,
                        )));
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  p2('Ubicacion', EstiloApp.primaryblue, TextAlign.left,
                      'Montserrat', FontWeight.w400, FontStyle.normal),
                  children,
                ],
              );
            },
          ),
          divider(),
          FutureBuilder(
            future: _con.networkmemoizer.runOnce(() async {
              return await _con.GetNetworkSolicitud();
            }),
            builder: (context, snapshot) {
              Widget children = SizedBox();
              if (snapshot.hasData) {
                List data = snapshot.data as List;
                children = data.isNotEmpty
                    ? Column(
                        children: <Widget>[
                          GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 4,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 10),
                              itemCount: data.length,
                              itemBuilder: (context, i) {
                                return Networkinfo(
                                  data: data[i],
                                );
                              }),
                          BtnBlue(
                              metod: () {
                                final ProviderSolicitud provsolicitud =
                                    Provider.of<ProviderSolicitud>(context,
                                        listen: false);
                                provsolicitud.solicitud = _con.solicitud;
                                Navigator.pushNamed(context,
                                    PageRoutes().addnetworkmysolicitud);
                              },
                              widget: p2(
                                  'Agregar Redes',
                                  EstiloApp.colorwhite,
                                  TextAlign.left,
                                  'Montserrat',
                                  FontWeight.w400,
                                  FontStyle.normal),
                              width: 0.4,
                              height: 40)
                        ],
                      )
                    : BtnBlue(
                        metod: () {
                          final ProviderSolicitud provsolicitud =
                              Provider.of<ProviderSolicitud>(context,
                                  listen: false);
                          provsolicitud.solicitud = _con.solicitud;
                          Navigator.pushNamed(
                              context, PageRoutes().addnetworkmysolicitud);
                        },
                        widget: p2(
                            'Agregar Redes',
                            EstiloApp.colorwhite,
                            TextAlign.left,
                            'Montserrat',
                            FontWeight.w400,
                            FontStyle.normal),
                        width: 0.4,
                        height: 40);
              } else if (snapshot.hasError) {
              } else {
                children = SkeletonParagraph(
                    style: SkeletonParagraphStyle(
                        lines: 3,
                        spacing: 4,
                        lineStyle: SkeletonLineStyle(
                          randomLength: true,
                          height: 10,
                          borderRadius: BorderRadius.circular(8),
                          minLength: MediaQuery.of(context).size.width / 3,
                        )));
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  p1('Redes Sociales', EstiloApp.primaryblue, TextAlign.left,
                      'Montserrat', FontWeight.w400, FontStyle.normal),
                  children,
                ],
              );
            },
          ),
          divider(),
          BtnDegraded(
              metod: () => Navigator.pushNamed(context, '/galeriasolicitud'),
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Iconsax.gallery, color: EstiloApp.colorwhite),
                      SizedBox(width: 10),
                      p2('Galería', EstiloApp.colorwhite, TextAlign.left,
                          'Montserrat', FontWeight.w400, FontStyle.normal),
                    ],
                  ),
                  ToolTipeDesing(
                      title:
                          'Cada emprendimiento dispone de una galería propia',
                      color: EstiloApp.colorwhite),
                ],
              ),
              width: 0.4,
              height: 50)
        ],
      ),
    );
  }

  Widget verify() {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 10),
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
          color: Colors.black54,
          blurRadius: 4,
          offset: Offset(2, 2),
        ),
      ], color: EstiloApp.colorwhite, borderRadius: BorderRadius.circular(35)),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height * 0.13,
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl:
                      '${Enviroment.apiUrl}storage/${_con.solicitud.photoEmprendimiento}',
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
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //  textH3('Ana Yepez Saenz', EstiloApp.colorwhite,
                            //    FontWeight.bold),
                            H5(
                                'Verificación',
                                EstiloApp.colorwhite,
                                TextAlign.center,
                                'Montserrat',
                                FontWeight.w700,
                                FontStyle.normal),
                            H5(
                                '${_con.solicitud.nameUndertaking}',
                                EstiloApp.colorwhite,
                                TextAlign.center,
                                'Montserrat',
                                FontWeight.w700,
                                FontStyle.normal),
                            Divider(
                              color: EstiloApp.colorwhite,
                              thickness: 1,
                              endIndent: size.width * 0.35,
                            ),
                          ],
                        ),
                        //textp3('Sector Publico', EstiloApp.colorwhite,
                        //FontWeight.bold),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              // child: textp5('Solicitudes Vigentes: 1/1',
                              //     EstiloApp.colorwhite, FontWeight.w100),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    color: EstiloApp.colorwhite,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              // child: textp5('Solicitudes Pagadas: 0/1',
                              //   EstiloApp.colorwhite, FontWeight.w100),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    color: EstiloApp.colorwhite,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              //  child: textp5('Puntuacion: 100%',
                              //    EstiloApp.colorwhite, FontWeight.w100),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Expanded(child: datainfo())
          Expanded(child: dataverify())
        ],
      ),
    );
  }

  Widget datainfo() {
    return Container(
      padding: const EdgeInsets.all(30),
      constraints: const BoxConstraints(maxWidth: 500),
      child: ListView(
        children: <Widget>[
          Slider(
            activeColor: EstiloApp.primaryblue,
            inactiveColor: Colors.blueGrey,
            value: double.parse(_con.solicitud.valorRecolectado.toString()),
            min: 0,
            max: double.parse(_con.solicitud.valorRecolectado.toString()),
            onChanged: (dynamic value) {},
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  p2(
                      '\$${_con.solicitud.valorRecolectado}',
                      EstiloApp.primaryblue,
                      TextAlign.left,
                      'Montserrat',
                      FontWeight.w700,
                      FontStyle.normal),
                  p3(
                      '\$${_con.solicitud.valorRecolectado} (${porcentaje(_con.solicitud.montoSolicitado, _con.solicitud.valorRecolectado)}%) Recolentado',
                      EstiloApp.primaryblue,
                      TextAlign.left,
                      'Montserrat',
                      FontWeight.w400),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  p2(
                      '\$${_con.solicitud.montoSolicitado}',
                      EstiloApp.primaryblue,
                      TextAlign.left,
                      'Montserrat',
                      FontWeight.w700,
                      FontStyle.normal),
                  p3('Objetivo', EstiloApp.primaryblue, TextAlign.left,
                      'Montserrat', FontWeight.w400),
                ],
              ),
            ],
          ),
          p1('Información del financiamiento.', EstiloApp.primaryblue,
              TextAlign.left, 'Montserrat', FontWeight.w700, FontStyle.normal),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Visibility(
                child: p3('Perfil Verificado.', EstiloApp.primarypink,
                    TextAlign.left, 'Montserrat', FontWeight.w600),
              ),
              _con.solicitud.verificacion == 1
                  ? Row(
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          color: EstiloApp.primarypink,
                        ),
                        p3('Solicitud verificada.', EstiloApp.primarypink,
                            TextAlign.left, 'Montserrat', FontWeight.w500),
                      ],
                    )
                  : BtnDegraded(
                      metod: () {
                        _con.mypageController.animateToPage(2,
                            duration: Duration(seconds: 1),
                            curve: Curves.easeInOut);
                        setState(() {});
                      },
                      widget: Row(
                        children: <Widget>[
                          Icon(
                            Icons.cancel,
                            color: EstiloApp.colorwhite,
                          ),
                          Expanded(
                            child: p3('No verificada.', EstiloApp.colorwhite,
                                TextAlign.left, 'Montserrat', FontWeight.w600),
                          ),
                        ],
                      ),
                      width: 0.4,
                      height: 40)
            ],
          ),
          datarow('Monto', '\$ ${_con.solicitud.montoSolicitado}'),
          datarow('Plazo', '${_con.solicitud.plazo}'),
          datarow('TIR', '${_con.solicitud.tir} meses'),
          datarow('Frecuencia de Pagos', '${_con.solicitud.frecuenciaPago}'),
          datarow(
              'Tipo de financiamiento', '${_con.solicitud.tipoFinanciamiento}'),
          datarow('Categoria de negocio', '${_con.solicitud.categoriaNegocio}'),
          datarow('Codigo', 'C9SF01'),
        ],
      ),
    );
  }

  porcentaje(montoSolicitado, valorRecolectado) {
    double val = ((valorRecolectado * 100) / montoSolicitado);
    return val.toStringAsFixed(2);
  }

  Widget datarow(String title, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: EstiloApp.primaryblue,
            width: 1.0,
          ),
        ),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Flexible(
          flex: 2,
          child: p2(title, EstiloApp.primaryblue, TextAlign.left, 'Montserrat',
              FontWeight.w700, FontStyle.normal),
        ),
        Flexible(
            flex: 1,
            child: Align(
                alignment: Alignment.centerLeft,
                child: p2(text, EstiloApp.primaryblue, TextAlign.left,
                    'Montserrat', FontWeight.w500, FontStyle.normal))),
      ]),
    );
  }

  Widget dataverify() {
    return Container(
      child: ListView(
        children: [datarow('s', 'text')],
      ),
    );
  }

  Widget Ubiinfo(BuildContext context, int i, data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        p3('Ciudad: ${data.ciudad}', EstiloApp.primaryblue, TextAlign.left,
            'Montserrat', FontWeight.w400),
        p3(data.direccion, EstiloApp.primaryblue, TextAlign.left, 'Montserrat',
            FontWeight.w400),
        InkWell(
          onTap: () async {
            await openMap(data.latitud, data.longitud);
          },
          child: p3('Ver Mapa', EstiloApp.primaryblue, TextAlign.left,
              'Montserrat', FontWeight.w600),
        ),
      ],
    );
  }

  Widget divider() {
    return Divider(height: 5, thickness: 2, color: EstiloApp.primarypink);
  }
}

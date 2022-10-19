import 'package:flutter/material.dart';
import 'package:sfs_emprendedor/src/global/environment.dart';
import 'package:sfs_emprendedor/src/styles/custom_styles.dart';
import 'package:sfs_emprendedor/src/widgets/widgettext.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:skeletons/skeletons.dart';

class ToolTipeDesing extends StatelessWidget {
  final String title;
  const ToolTipeDesing({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
        triggerMode: TooltipTriggerMode.tap,
        decoration: BoxDecoration(color: Colors.black45),
        child: Icon(Icons.info, color: EstiloApp.primarypink),
        textStyle: TextStyle(
            color: EstiloApp.colorwhite,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            fontSize: 14),
        message: title);
  }
}

class chargueSolicitud extends StatelessWidget {
  const chargueSolicitud({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(right: 20, left: 20, bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: EstiloApp.decorationBoxwhite,
      child: Column(
        children: <Widget>[

          SkeletonItem(
            
            child: SkeletonAvatar(
              style: SkeletonAvatarStyle(
                  height: size.height * 0.15, width: size.width),
            ),
          ),
          SkeletonAvatar(
            style: SkeletonAvatarStyle(
                height: size.height * 0.15, width: size.width),
          ),
          SkeletonParagraph(
              style: SkeletonParagraphStyle(
                  lines: 5,
                  spacing: 8,
                  lineStyle: SkeletonLineStyle(
                    randomLength: true,
                    height: 10,
                    borderRadius: BorderRadius.circular(8),
                    minLength: MediaQuery.of(context).size.width / 2,
                  ))),
        ],
      ),
    );
  }
}

class ErrorChargue extends StatelessWidget {
  final MaterialColor color;
  const ErrorChargue({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.error,
            color: EstiloApp.primaryblue,
            size: 150,
          ),
          H3('Existe un error en la carga', color, TextAlign.center,
              'Montserrat', FontWeight.w600, FontStyle.normal),
        ],
      ),
    );
  }
}

class tablaAmortizacion extends StatelessWidget {
  final List<List> amortizacion;
  const tablaAmortizacion({Key? key, required this.amortizacion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: EstiloApp.decorationBoxwhite,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              p2('N°', EstiloApp.primaryblue, TextAlign.center, 'Montserrat',
                  FontWeight.w300, FontStyle.normal),
              p2('Capital', EstiloApp.primaryblue, TextAlign.center,
                  'Montserrat', FontWeight.w300, FontStyle.normal),
              p2('Interes', EstiloApp.primaryblue, TextAlign.center,
                  'Montserrat', FontWeight.w300, FontStyle.normal),
              p2('Recibes', EstiloApp.primaryblue, TextAlign.center,
                  'Montserrat', FontWeight.w300, FontStyle.normal)
            ],
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: amortizacion.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: p2(
                              '${index + 1}',
                              EstiloApp.primaryblue,
                              TextAlign.center,
                              'Montserrat',
                              FontWeight.w300,
                              FontStyle.normal),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.21,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(148, 172, 167, 169),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                stops: [
                                  index * 0.10,
                                  0.4,
                                ],
                                colors: <Color>[
                                  Colors.green,
                                  Colors.transparent
                                ],
                              )),
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          alignment: Alignment.centerRight,
                          child: p2(
                              '\$ ${(amortizacion[index][0]).toStringAsFixed(2)}',
                              EstiloApp.primaryblue,
                              TextAlign.center,
                              'Montserrat',
                              FontWeight.w300,
                              FontStyle.normal),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.21,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(148, 172, 167, 169),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                stops: [
                                  (10 - index) * 0.1,
                                  0.4,
                                ],
                                colors: <Color>[Colors.red, Colors.transparent],
                              )),
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          alignment: Alignment.centerRight,
                          child: p2(
                              '\$ ${(amortizacion[index][1]).toStringAsFixed(2)}',
                              EstiloApp.primaryblue,
                              TextAlign.center,
                              'Montserrat',
                              FontWeight.w300,
                              FontStyle.normal),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.21,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          color: Color.fromARGB(41, 0, 23, 92),
                          alignment: Alignment.centerRight,
                          child: p2(
                              '\$ ${(amortizacion[index][2]).toStringAsFixed(2)}',
                              EstiloApp.primaryblue,
                              TextAlign.center,
                              'Montserrat',
                              FontWeight.w300,
                              FontStyle.normal),
                        ),
                      )
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}

class FotoPerfil extends StatelessWidget {
  final dynamic image;
  final double size;
  const FotoPerfil({Key? key, this.image, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return image != null
        ? InkWell(
            onTap: () => showImageViewer(
                context,
                Image.network(
                  '${Enviroment.apiUrl}storage/${image}',
                  headers: const {
                    'content-type': 'application/json',
                    'accept': 'application/json',
                    "connection": "Keep-Alive",
                  },
                ).image,
                onViewerDismissed: () {}),
            child: ClipOval(
                child: CachedNetworkImage(
              httpHeaders: const {
                'content-type': 'application/json',
                'accept': 'application/json',
                "connection": "Keep-Alive",
              },
              progressIndicatorBuilder: (context, url, progress) => Center(
                child: CircularProgressIndicator(
                  value: progress.progress,
                ),
              ),
              imageUrl: '${Enviroment.apiUrl}storage/${image}',
              width: size,
              height: size,
              fit: BoxFit.cover,
              errorWidget: (context, url, progress) => Center(
                child: Icon(Icons.person, size: size),
              ),
            )))
        : ClipOval(child: Icon(Icons.person, size: size));
  }
}

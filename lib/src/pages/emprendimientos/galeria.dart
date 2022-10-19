import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:sfs_emprendedor/src/controll/galeria_controller.dart';
import 'package:sfs_emprendedor/src/global/environment.dart';
import 'package:sfs_emprendedor/src/providers/ProviderSolicitud.dart';
import 'package:sfs_emprendedor/src/providers/ProviderUser.dart';
import 'package:sfs_emprendedor/src/styles/custom_styles.dart';
import 'package:sfs_emprendedor/src/widgets/WidgetsFuncionaly.dart';
import 'package:sfs_emprendedor/src/widgets/Widgetsdesign.dart';
import 'package:sfs_emprendedor/src/widgets/appbar.dart';
import 'package:sfs_emprendedor/src/widgets/overlayExample.dart';
import 'package:sfs_emprendedor/src/widgets/widgettext.dart';
import 'package:skeletons/skeletons.dart';
import 'package:swipe_image_gallery/swipe_image_gallery.dart';

class Galeria extends StatefulWidget {
  const Galeria({Key? key}) : super(key: key);

  @override
  _GaleriaState createState() => _GaleriaState();
}

class _GaleriaState extends StateMVC<Galeria> {
  GaleriaController _con = GaleriaController();
  StreamController<Widget> overlayController =
      StreamController<Widget>.broadcast();

  @override
  void dispose() {
    overlayController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ProviderUser prov = Provider.of<ProviderUser>(context, listen: false);
    final ProviderSolicitud provsolicitud =
        Provider.of<ProviderSolicitud>(context, listen: false);
    _con.context = context;
    _con.solicitud = provsolicitud.solicitud!;
    return RefreshIndicator(
      displacement: 250,
      backgroundColor: EstiloApp.colorwhite,
      color: EstiloApp.primarypurple,
      strokeWidth: 3,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: () async {
        await _con.GetSolicitudGalery();
        return setState(() {});
      },
      child: Scaffold(
        backgroundColor: EstiloApp.primaryblue,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: EstiloApp.primaryblue,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios)),
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
                icon: const Icon(Icons.person))
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
          decoration: BoxDecoration(
              color: EstiloApp.colorwhite,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40))),
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
              minWidth: MediaQuery.of(context).size.width),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: FutureBuilder(
                  future: _con.GetSolicitudGalery(),
                  builder: (context, snapshot) {
                    Widget children = SizedBox();
                    if (snapshot.hasData) {
                      List data = snapshot.data as List;

                      print(data);
                      children = Column(
                        children: <Widget>[
                          Visibility(
                            visible: _con.mysolicitud(),
                            child: BtnWhite(
                                metod: () => Navigator.pushReplacementNamed(
                                    context, '/addphoto'),
                                widget: H4(
                                    'Agregar Imagenes',
                                    EstiloApp.primaryblue,
                                    TextAlign.center,
                                    'Montserrat',
                                    FontWeight.w600,
                                    FontStyle.normal),
                                width: 0.5,
                                height: 50),
                          ),
                          GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent:
                                          MediaQuery.of(context).size.width / 3,
                                      childAspectRatio: 3 / 3,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10),
                              itemCount: data.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return photo(data[index], data, index);
                              })
                        ],
                      );
                    } else if (snapshot.hasError) {
                      children = ErrorChargue(color: EstiloApp.colorblack);
                    } else {
                      children = GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent:
                                      MediaQuery.of(context).size.width / 3,
                                  childAspectRatio: 3 / 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemCount: 15,
                          itemBuilder: (BuildContext ctx, index) {
                            return SkeletonAvatar(
                              style: SkeletonAvatarStyle(
                                  borderRadius: BorderRadius.circular(5)),
                            );
                          });
                    }
                    return children;
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget photo(data, List datas, int i) {
    List<Widget> images = [];
    for (var dat in datas) {
      images.add(Image(
          image: CachedNetworkImageProvider(
        '${Enviroment.apiUrl}storage/${dat.photos}',
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
          "connection": "Keep-Alive",
        },
      )));
    }
    return InkWell(
        onTap: () {
          SwipeImageGallery(
                  onSwipe: (index) {
                    overlayController.add(OverlayExample(
                      title: '${index + 1}/${images.length}',
                      info: datas[index].namePhotos,
                      date: datas[index].createdAt,
                    ));
                  },
                  overlayController: overlayController,
                  initialOverlay: OverlayExample(
                    title: '${i + 1}/${images.length}',
                    info: data.namePhotos,
                    date: data.createdAt,
                  ),
                  context: context,
                  children: images,
                  initialIndex: i)
              .show();
        },
        child: CachedNetworkImage(
          httpHeaders: {
            'content-type': 'application/json',
            'accept': 'application/json',
            "connection": "Keep-Alive",
          },
          progressIndicatorBuilder: (context, url, progress) => SkeletonAvatar(
            style: SkeletonAvatarStyle(borderRadius: BorderRadius.circular(5)),
          ),
          imageUrl: '${Enviroment.apiUrl}storage/${data.photos}',
          fit: BoxFit.cover,
        ));
  }
}

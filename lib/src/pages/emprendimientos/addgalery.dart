import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:sfs_emprendedor/src/controll/galeria_controller.dart';
import 'package:sfs_emprendedor/src/models/galeria_model.dart';
import 'package:sfs_emprendedor/src/providers/ProviderSolicitud.dart';
import 'package:sfs_emprendedor/src/providers/ProviderUser.dart';
import 'package:sfs_emprendedor/src/styles/custom_styles.dart';
import 'package:sfs_emprendedor/src/widgets/WidgetsFuncionaly.dart';
import 'package:sfs_emprendedor/src/widgets/appbar.dart';
import 'package:sfs_emprendedor/src/widgets/overlayExample.dart';
import 'package:sfs_emprendedor/src/widgets/widgettext.dart';
import 'package:swipe_image_gallery/swipe_image_gallery.dart';

class Addgalery extends StatefulWidget {
  const Addgalery({Key? key}) : super(key: key);

  @override
  _AddgaleryState createState() => _AddgaleryState();
}

class _AddgaleryState extends StateMVC<Addgalery> {
  GaleriaController _con = GaleriaController();
  @override
  Widget build(BuildContext context) {
    final ProviderUser prov = Provider.of<ProviderUser>(context, listen: false);
    final ProviderSolicitud provsolicitud =
        Provider.of<ProviderSolicitud>(context, listen: false);
    _con.context = context;
    _con.solicitud = provsolicitud.solicitud!;
    return Scaffold(
      key: _con.scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        //centerTitle: true,
        backgroundColor: EstiloApp.primaryblue,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios)),
            H4('Agregar imagenes', EstiloApp.colorwhite, TextAlign.center,
                'Montserrat', FontWeight.normal, FontStyle.normal)
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
    );
  }

  Widget body() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
          minWidth: MediaQuery.of(context).size.width),
      // decoration: BoxDecoration(gradient: EstiloApp.horizontalgradientblue),
      child: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            decoration: EstiloApp.decorationBoxwhite,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            child: Wrap(
                spacing: 30,
                runSpacing: 20,
                alignment: WrapAlignment.spaceBetween,
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  H5(
                      'Puedes agregar Imágenes desde tu dispositivo, para luego guardarlas en la galería de tu emprendimiento',
                      EstiloApp.primaryblue,
                      TextAlign.center,
                      'Montserrat',
                      FontWeight.w600,
                      FontStyle.normal),
                  BtnDegraded(
                      metod: () async {
                        await _con.getImages();
                        setState(() {});
                      },
                      widget: p1(
                          'Agregar',
                          EstiloApp.colorwhite,
                          TextAlign.center,
                          'Montserrat',
                          FontWeight.w500,
                          FontStyle.italic),
                      width: 0.3,
                      height: 40),
                  BtnBlue(
                      metod: () async {
                        bool correct = false;
                        int t = _con.photos.length;
                        for (var i = 0; i < t; i++) {
                          setState(() {});
                          if (await _con.SaveImage(_con.photos.last)) {
                            setState(() {});
                            correct = true;
                          } else {
                            correct = false;
                            break;
                          }
                        }
                        if (correct) {
                          _con.SuccesGalery();
                        }
                      },
                      widget: p1(
                          'Guardar',
                          EstiloApp.colorwhite,
                          TextAlign.center,
                          'Montserrat',
                          FontWeight.w500,
                          FontStyle.italic),
                      width: 0.3,
                      height: 40),
                ]),
          ),
          Form(
            key: _con.photosFormKey,
            child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: MediaQuery.of(context).size.width / 3,
                    childAspectRatio: 3 / 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: _con.photos.length,
                itemBuilder: (BuildContext ctx, index) {
                  return photo(_con.photos[index], _con.photos, index);
                }),
          ),
        ],
      )),
    );
  }

  Widget photo(Photo photo, List datas, int i) {
    List<Widget> images = [];
    for (var dat in datas) {
      images.add(Image(image: FileImage(photo.photos)));
    }
    return Container(
      decoration: EstiloApp.decorationBoxwhite,
      padding: EdgeInsets.all(3),
      width: MediaQuery.of(context).size.width / 3,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      InkWell(
                        onLongPress: () {
                          _con.removephoto(photo);
                          setState(() {});
                        },
                        onTap: () {
                          SwipeImageGallery(
                                  onSwipe: (index) {
                                    _con.overlayController.add(OverlayExample(
                                      title: '${index + 1}/${images.length}',
                                      info: datas[index].namePhotos == null
                                          ? 'Titulo'
                                          : datas[index].namePhotos,
                                      date: DateTime.now(),
                                    ));
                                  },
                                  overlayController: _con.overlayController,
                                  initialOverlay: OverlayExample(
                                    title: '${i + 1}/${images.length}',
                                    info: datas[i].namePhotos == null
                                        ? 'Titulo'
                                        : datas[i].namePhotos,
                                    date: DateTime.now(),
                                  ),
                                  context: context,
                                  children: images,
                                  initialIndex: i)
                              .show();
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Image.file(
                            photo.photos,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            onPressed: () async {
                              await _con.removephoto(photo);
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.close,
                              color: EstiloApp.primaryblue,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: EstiloApp.colorwhite,
                height: 30,
                padding: EdgeInsets.only(top: 6),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (value) {
                    _con.photos[i].namePhotos = value;
                    setState(() {});
                  },
                  validator: (value) {
                    return validator(value!);
                  },
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  autofocus: false,
                  cursorColor: EstiloApp.primaryblue,
                  decoration: EstiloApp.inputdecoration(p1(
                      'Titulo',
                      EstiloApp.colorblack,
                      TextAlign.center,
                      'Montserrat',
                      FontWeight.w400,
                      FontStyle.normal)),
                ),
              )
            ],
          ),
          Visibility(
            visible: photo == _con.photopost,
            child: Center(
                child: SpinKitPulse(
              color: EstiloApp.primaryblue,
              size: MediaQuery.of(context).size.width / 3.5,
            )),
          )
        ],
      ),
    );
  }
}

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:sfs_emprendedor/src/controll/network_controller.dart';
import 'package:sfs_emprendedor/src/models/network_model.dart';
import 'package:sfs_emprendedor/src/providers/ProviderSolicitud.dart';
import 'package:sfs_emprendedor/src/providers/ProviderUser.dart';
import 'package:sfs_emprendedor/src/styles/custom_styles.dart';
import 'package:sfs_emprendedor/src/widgets/WidgetsFuncionaly.dart';
import 'package:sfs_emprendedor/src/widgets/Widgetsdesign.dart';

import 'package:sfs_emprendedor/src/widgets/appbar.dart';
import 'package:sfs_emprendedor/src/widgets/widgettext.dart';
import 'package:skeletons/skeletons.dart';
import 'package:unicons/unicons.dart';
import 'package:url_launcher/url_launcher.dart';

class Addnetwork extends StatefulWidget {
  const Addnetwork({Key? key}) : super(key: key);

  @override
  _AddnetworkState createState() => _AddnetworkState();
}

class _AddnetworkState extends StateMVC<Addnetwork> {
  NetworkController _con = NetworkController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final ProviderUser prov = Provider.of<ProviderUser>(context, listen: false);
    _con.context = context;
    final ProviderSolicitud provsolicitud =
        Provider.of<ProviderSolicitud>(context, listen: false);
    _con.solicitud = provsolicitud.solicitud!;
    return Scaffold(
      key: _con.Scaffoldkey,
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
                  'Redes Sociales',
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
    return Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            runAlignment: WrapAlignment.center,
            children: <Widget>[
              H3('Tus Redes', EstiloApp.primaryblue, TextAlign.left,
                  'Montserrat', FontWeight.w600, FontStyle.normal),
              FutureBuilder(
                future: _con.networkmemoizer.runOnce(() async {
                  return await _con.GetNetworkSolicitud();
                }),
                builder: (context, snapshot) {
                  Widget children = SizedBox();
                  if (snapshot.hasData) {
                    List data = snapshot.data as List;
                    children = GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 4,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 10),
                        itemCount: data.length,
                        itemBuilder: (context, i) {
                          return Networkinfo(
                            data: data[i],
                          );
                        });
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
                      children,
                    ],
                  );
                },
              ),
              Visibility(
                  visible: _con.networks.isNotEmpty,
                  maintainSize: false,
                  child: Column(
                    children: <Widget>[
                      BtnDegraded(
                          metod: () async {
                            await _con.ConfirmSave();
                            print(_con.confirmsave);
                            if (_con.confirmsave) {
                              bool correct = false;
                              int t = _con.networks.length;
                              for (var i = 0; i < t; i++) {
                                setState(() {});
                                if (await _con.SaveNetwork(
                                    _con.networks.last)) {
                                  setState(() {});
                                  correct = true;
                                } else {
                                  correct = false;
                                  break;
                                }
                              }
                              if (correct) {
                                await _con.succesSave();
                              }
                            }
                          },
                          widget: p1(
                              _con.networks.length > 1
                                  ? 'Guardar redes'
                                  : 'Guardar red',
                              EstiloApp.colorwhite,
                              TextAlign.center,
                              'Montserrat',
                              FontWeight.w600,
                              FontStyle.italic),
                          width: 0.4,
                          height: 40),
                      GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, mainAxisSpacing: 10),
                        itemCount: _con.networks.length,
                        itemBuilder: (BuildContext context, int i) {
                          return Addnetworkinfo(_con.networks[i], i);
                        },
                      ),
                    ],
                  )),
              H4('Agregar Red', EstiloApp.primaryblue, TextAlign.left,
                  'Montserrat', FontWeight.w600, FontStyle.normal),
              GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 4,
                padding: EdgeInsets.all(10),
                mainAxisSpacing: 10,
                children: [
                  BtnAdd('Facebook', Icons.facebook),
                  BtnAdd('YouTube', UniconsLine.youtube),
                  BtnAdd('Instagram', UniconsLine.instagram),
                  BtnAdd('TikTok', Icons.tiktok),
                  BtnAdd('LinkedIn', UniconsLine.linkedin),
                  BtnAdd('Twitter', UniconsLine.twitter),
                  BtnAdd('Discord', Icons.discord),
                  BtnAdd('Pinterest', Icons.search),
                  BtnAdd('Twitch', Iconsax.message),
                  BtnAdd('Pagina Web', Icons.travel_explore),
                ],
              ),
            ],
          ),
        ));
  }

  Widget Addnetworkinfo(Network network, int pos) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Card(
          color: EstiloApp.colorwhite,
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          margin: EdgeInsets.all(15),
          child: InkWell(
            onTap: () async {
              if (await canLaunchUrl(Uri.parse(network.enlace))) {
                await launchUrl(Uri.parse(network.enlace));
              }
            },
            child: Stack(
              fit: StackFit.loose,
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: iconetwork(network.network),
                        ),
                        p2(network.name, EstiloApp.primaryblue, TextAlign.left,
                            'Montserrat', FontWeight.w400, FontStyle.normal),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: network == _con.networkpost,
                  child: Center(
                      child: SpinKitPulse(
                    color: EstiloApp.primaryblue,
                    size: MediaQuery.of(context).size.width / 3.5,
                  )),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: IconButton(
              onPressed: () async {
                await showGeneralDialog(
                  context: context,
                  pageBuilder: (ctx, a1, a2) {
                    return Container();
                  },
                  transitionBuilder: (ctx, a1, a2, child) {
                    var curve = Curves.easeInOut.transform(a1.value);
                    return Transform.scale(
                      scale: curve,
                      child:
                          _con.AlertAddnetwork(network.network, network, pos),
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 300),
                );
                setState(() {});
              },
              icon: Icon(
                Icons.edit_note,
                color: EstiloApp.primaryblue,
              )),
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
              onPressed: () async {
                await _con.removenetwork(network);
                print('eliminar');
                setState(() {});
              },
              icon: Icon(
                Icons.close,
                color: EstiloApp.primaryblue,
              )),
        ),
      ],
    );
  }

  Widget BtnAdd(String title, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () async {
          await showGeneralDialog(
            context: context,
            pageBuilder: (ctx, a1, a2) {
              return Container();
            },
            transitionBuilder: (ctx, a1, a2, child) {
              var curve = Curves.easeInOut.transform(a1.value);
              return Transform.scale(
                scale: curve,
                child: _con.AlertAddnetwork(title, null, null),
              );
            },
            transitionDuration: const Duration(milliseconds: 300),
          );
          setState(() {});
          print(_con.networks);
        },
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  color: EstiloApp.primaryblue,
                ),
              ),
              p3(title, EstiloApp.primaryblue, TextAlign.left, 'Montserrat',
                  FontWeight.w400),
            ],
          ),
        ),
      ),
      color: EstiloApp.colorwhite,
      elevation: 10,
    );
  }
}

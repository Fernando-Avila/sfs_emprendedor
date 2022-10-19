import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:sfs_emprendedor/src/controll/solicitud_controller.dart';
import 'package:sfs_emprendedor/src/providers/ProviderUser.dart';

class Detailmysolicitud extends StatefulWidget {
  const Detailmysolicitud({Key? key}) : super(key: key);

  @override
  _DetailmysolicitudState createState() => _DetailmysolicitudState();
}

class _DetailmysolicitudState extends StateMVC<Detailmysolicitud> {
  SolicitudController _con = SolicitudController();
  @override
  Widget build(BuildContext context) {
    final ProviderUser prov = Provider.of<ProviderUser>(context, listen: false);
    _con.context = context;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: Container(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sfs_emprendedor/src/models/solicitud_model.dart';

class ProviderSolicitud extends ChangeNotifier {
  Solicitud? _solicitud;
  Solicitud? get solicitud => _solicitud;
  set solicitud(Solicitud? solicitud) {
    _solicitud = solicitud;
    notifyListeners();
  }

  bool mysolicitud = false;
   
}

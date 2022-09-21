
import 'package:flutter/material.dart';
import 'package:sfs_emprendedor/src/models/user.dart';

class ProviderUser extends ChangeNotifier {
  bool _logged = false;
  bool get logged => _logged;
  set logged(bool logged) {
    _logged = logged;
    notifyListeners();
  }

  bool _appbar = false;
  bool get appbar => _appbar;
  set appbar(bool appbar) {
    _appbar = appbar;
    notifyListeners();
  }

  int _idop = 0;
  int get idop => _idop;
  set idop(int idop) {
    _idop = idop;
    notifyListeners();
  }

  User _us = User(1, 'nombre', 'apellido', 'fechanacimiento', 'cedula',
      'correo', 'clave', 'celular', 'rol', 'ciudad', 'tipo');
  User get us => _us;
  set us(User us) {
    _us = us;
    notifyListeners();
  }
}

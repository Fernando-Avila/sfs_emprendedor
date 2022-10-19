import 'package:flutter/material.dart';
import 'package:sfs_emprendedor/src/models/user_model.dart';

class ProviderUser extends ChangeNotifier {
  User? _user;

  User? get user => _user;
  set user(User? user) {
    _user = user;
    notifyListeners();
  }

  String _token = '';

  String get token => _token;
  set token(String token) {
    _token = token;
    notifyListeners();
  }

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
}

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sfs_emprendedor/src/models/user.dart';
import 'package:sfs_emprendedor/src/providers/ProviderUser.dart';
import 'package:sfs_emprendedor/src/widgets/Widgetsdialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

void reseendemail(BuildContext context) async {
  await auth.FirebaseAuth.instance.currentUser!.reload();
  final user = auth.FirebaseAuth.instance.currentUser;
  final uid = user!.uid;
  if (!user.emailVerified) {
    try {
      await user.sendEmailVerification();
      Succes(context, 'Se ha reenviado el correo de confirmación', 3);
    } catch (e) {
      print(e);
      Errordialog(
          context, 'No se ha podido enviar el correo, reintentalo mas tarde');
    }
  }
}

bool logged = false;
Future<bool> registrar(User us) async {
  try {
    await auth.FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: us.correo.trim(), password: us.clave.trim());
    await auth.FirebaseAuth.instance.currentUser!.sendEmailVerification();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(us.correo, <String>[
      us.nombre,
      us.apellido,
      us.fechanacimiento,
      us.cedula,
      us.correo,
      us.clave,
      us.celular,
      us.rol,
      us.ciudad,
      us.type
    ]);
    return true;
  } catch (e) {
    return false;
  }
}
/*
Future<bool> login(String correo, String clave, BuildContext context) async {
  bool result = false;

  try {
    await auth.FirebaseAuth.instance
        .signInWithEmailAndPassword(email: correo, password: clave);
    List<String>? usuario;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    usuario = await prefs.getStringList(correo);
    final ProviderUser prov = Provider.of<ProviderUser>(context, listen: false);
    prov.us = User(1, usuario![0], usuario[1], usuario[2], usuario[3],
        usuario[4], usuario[5], usuario[6], usuario[7], usuario[8], usuario[9]);
    logged = true;
    prov.logged = true;
    result = true;
  } catch (e) {}
  return result;
}*/

void logout(BuildContext context) {
  final ProviderUser prov = Provider.of<ProviderUser>(context, listen: false);
  prov.logged = false;
}

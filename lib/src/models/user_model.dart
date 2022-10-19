// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sfs_emprendedor/src/global/environment.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

Future httpRegisterBuroPost(File file, int id, String token) async {
  var path = 'api/buroaplicant/$id';
  var url = Uri.parse(Enviroment.apiUrl + path);
  var request =
      http.MultipartRequest("POST", Uri.parse(Enviroment.apiUrl + path));
  var requests = await encodepdf(file, request);
  print(requests.fields);
  print(requests.files.first.filename);
  return await requests.send();
}

Future<http.MultipartRequest> encodepdf(
    File file, http.MultipartRequest request) async {
  print('Encode');
  print(file.path);
  var path = await http.MultipartFile.fromPath("autorizacionBuro", file.path);
  request.files.add(path);
  return request;
}

Future httpRegisterUserPost(User user) async {
  var path = 'api/registroA/';
  var url = Uri.parse(Enviroment.apiUrl + path);
  return await http.post(url, headers: {
    "accept": "application/json"
  }, body: {
    "nombres": user.nombres,
    "apellidos": user.apellidos,
    "email": user.email,
    "password": user.password,
    "phone": user.phone
  }).then((value) async {
    print(value);
    print(value.body);
    return value;
  });
}

Future httpLoginUserPost(String email, String pass, String devicetoken) async {
  var path = 'api/accesoA/';
  var url = Uri.parse(Enviroment.apiUrl + path);
  return await http.post(url, headers: {
    "accept": "application/json"
  }, body: {
    "email": email,
    "password": pass,
    "device_token": devicetoken
  }).then((value) async {
    print(value);
    print(value.body);
    return value;
  });
}

class User {
  User({
    this.id,
    this.type,
    this.razonSocial,
    this.nombres,
    this.apellidos,
    this.email,
    this.password,
    this.ci,
    this.ruc,
    this.photoPerfil,
    this.photoCedulaFront,
    this.photoCedulaBack,
    this.statusA,
    this.phone,
    this.birthDate,
    this.solicitudesVigentes,
    this.solicitudesPagadas,
    this.puntualidad,
    this.rol,
    this.genre,
    this.estadoCivil,
    this.nameTitular,
    this.nameBanco,
    this.typeC,
    this.nroCuenta,
    this.autorizacionBuro,
    this.deviceToken,
    this.createdAt,
    this.updatedAt,
  });

  dynamic id;
  dynamic type;
  dynamic razonSocial;
  dynamic nombres;
  dynamic apellidos;
  dynamic email;
  dynamic password;
  dynamic ci;
  dynamic ruc;
  dynamic photoPerfil;
  dynamic photoCedulaFront;
  dynamic photoCedulaBack;
  dynamic statusA;
  dynamic phone;
  dynamic birthDate;
  dynamic solicitudesVigentes;
  dynamic solicitudesPagadas;
  dynamic puntualidad;
  dynamic rol;
  dynamic genre;
  dynamic estadoCivil;
  dynamic nameTitular;
  dynamic nameBanco;
  dynamic typeC;
  dynamic nroCuenta;
  dynamic autorizacionBuro;
  dynamic deviceToken;
  dynamic createdAt;
  dynamic updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        type: json["type"],
        razonSocial: json["razonSocial"],
        nombres: json["nombres"],
        apellidos: json["apellidos"],
        email: json["email"],
        password: json["password"],
        ci: json["ci"],
        ruc: json["ruc"],
        photoPerfil: json["photo_perfil"],
        photoCedulaFront: json["photo_cedula_front"],
        photoCedulaBack: json["photo_cedula_back"],
        statusA: json["statusA"],
        phone: json["phone"],
        birthDate: json["birth_date"],
        solicitudesVigentes: json["solicitudesVigentes"],
        solicitudesPagadas: json["solicitudesPagadas"],
        puntualidad: json["puntualidad"],
        rol: json["rol"],
        genre: json["genre"],
        estadoCivil: json["estadoCivil"],
        nameTitular: json["name_titular"],
        nameBanco: json["name_banco"],
        typeC: json["typeC"],
        nroCuenta: json["nro_cuenta"],
        autorizacionBuro: json["autorizacionBuro"],
        deviceToken: json["device_token"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "razonSocial": razonSocial,
        "nombres": nombres,
        "apellidos": apellidos,
        "email": email,
        "password": password,
        "ci": ci,
        "ruc": ruc,
        "photo_perfil": photoPerfil,
        "photo_cedula_front": photoCedulaFront,
        "photo_cedula_back": photoCedulaBack,
        "statusA": statusA,
        "phone": phone,
        "birth_date": birthDate,
        "solicitudesVigentes": solicitudesVigentes,
        "solicitudesPagadas": solicitudesPagadas,
        "puntualidad": puntualidad,
        "rol": rol,
        "genre": genre,
        "estadoCivil": estadoCivil,
        "name_titular": nameTitular,
        "name_banco": nameBanco,
        "typeC": typeC,
        "nro_cuenta": nroCuenta,
        "autorizacionBuro": autorizacionBuro,
        "device_token": deviceToken,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

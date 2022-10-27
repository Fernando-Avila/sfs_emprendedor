import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sfs_emprendedor/src/global/environment.dart';

Point pointFromJson(String str) => Point.fromJson(json.decode(str));

String pointToJson(Point data) => json.encode(data.toJson());

Future<dynamic> httpGetPointSolicitud(int id, String token) async {
  var path = 'api/pointundertakings/$id';
  var url = Uri.parse(Enviroment.apiUrl + path);
  return await http
      .get(url, headers: {"accept": "application/json"}).then((value) async {
    print(value.body);
    return value;
  });
}

Future httpRegisterPointUndertakingPost(Point Point, String token) async {
  var path = 'api/points/';
  var url = Uri.parse(Enviroment.apiUrl + path);
  return await http.post(url, headers: {
    "accept": "application/json"
  }, body: {
    "undertaking_id": Point.undertakingId.toString(),
    "ciudad": Point.ciudad,
    "latitud": Point.latitud.toString(),
    "longitud": Point.longitud.toString(),
    "direccion": Point.direccion
  }).then((value) async {
    print(value.request);
    print(value);
    print(value.body);
    return value;
  });
}

class Pointlist {
  final List<Point> Points;
  Pointlist({
    required this.Points,
  });
  factory Pointlist.fromJson(List<dynamic> json) {
    List<Point> Points = <Point>[];
    Points = json.map((i) => Point.fromJson(i)).toList();
    return new Pointlist(Points: Points);
  }
}

class Point {
  Point({
    this.id,
    this.applicantId,
    this.investorId,
    this.undertakingId,
    this.ciudad,
    this.latitud,
    this.longitud,
    this.direccion,
    this.createdAt,
    this.updatedAt,
  });

  dynamic id;
  dynamic applicantId;
  dynamic investorId;
  dynamic undertakingId;
  dynamic ciudad;
  dynamic latitud;
  dynamic longitud;
  dynamic direccion;
  dynamic createdAt;
  dynamic updatedAt;

  factory Point.fromJson(Map<String, dynamic> json) => Point(
        id: json["id"] == null ? null : json["id"],
        applicantId: json["applicant_id"],
        investorId: json["investor_id"],
        undertakingId:
            json["undertaking_id"] == null ? null : json["undertaking_id"],
        ciudad: json["ciudad"] == null ? null : json["ciudad"],
        latitud: json["latitud"] == null ? null : json["latitud"],
        longitud: json["longitud"] == null ? null : json["longitud"],
        direccion: json["direccion"] == null ? null : json["direccion"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "applicant_id": applicantId,
        "investor_id": investorId,
        "undertaking_id": undertakingId == null ? null : undertakingId,
        "ciudad": ciudad == null ? null : ciudad,
        "latitud": latitud == null ? null : latitud,
        "longitud": longitud == null ? null : longitud,
        "direccion": direccion == null ? null : direccion,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}

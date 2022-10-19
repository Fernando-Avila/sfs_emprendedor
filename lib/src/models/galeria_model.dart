// To parse this JSON data, do
//
//     final Photo = PhotoFromJson(jsonString);
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sfs_emprendedor/src/global/environment.dart';

Future<dynamic> httpGetPhotosUndertaking(int id, String token) async {
  var path = 'api/photosundertakings/$id';
  var url = Uri.parse(Enviroment.apiUrl + path);
  return await http
      .get(url, headers: {"accept": "application/json"}).then((value) async {
    return value;
  });
}

Future httpRegisterPhotoPost(Photo photo, String token) async {
  var path = 'api/photoundertakings/';
  var url = Uri.parse(Enviroment.apiUrl + path);
  var request =
      http.MultipartRequest("POST", Uri.parse(Enviroment.apiUrl + path));
  var requests = await encode(photo, request);
  print(requests.fields);
  return await requests.send();

  /* return await http
      .post(url,
          headers: {"accept": "application/json"},
          body: solicitudToJson(solicitud))
      .then((value) async {
    print(solicitudToJson(solicitud));
    print(value);
    print(value.body);
    return value;
  });*/
}

Future<http.MultipartRequest> encode(
    Photo photo, http.MultipartRequest request) async {
  request.fields["undertaking_id"] = photo.undertakingId.toString();
  request.fields["name_photos"] = photo.namePhotos;
  var path = await http.MultipartFile.fromPath("photos", photo.photos.path);
  request.files.add(path);
  return request;
}

class Photolist {
  final List<Photo> Photos;
  Photolist({
    required this.Photos,
  });
  factory Photolist.fromJson(List<dynamic> json) {
    List<Photo> Photos = <Photo>[];
    Photos = json.map((i) => Photo.fromJson(i)).toList();
    return new Photolist(Photos: Photos);
  }
}

Photo PhotoFromJson(String str) => Photo.fromJson(json.decode(str));

String PhotoToJson(Photo data) => json.encode(data.toJson());

class Photo {
  Photo({
    this.id,
    this.undertakingId,
    this.namePhotos,
    this.photos,
    this.createdAt,
    this.updatedAt,
  });

  dynamic id;
  dynamic undertakingId;
  dynamic namePhotos;
  dynamic photos;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json["id"] == null ? null : json["id"],
        undertakingId:
            json["undertaking_id"] == null ? null : json["undertaking_id"],
        namePhotos: json["name_photos"] == null ? null : json["name_photos"],
        photos: json["photos"] == null ? null : json["photos"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "undertaking_id": undertakingId == null ? null : undertakingId,
        "name_photos": namePhotos == null ? null : namePhotos,
        "photos": photos == null ? null : photos,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}

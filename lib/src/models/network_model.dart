// To parse this JSON data, do
//
//     final network = networkFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sfs_emprendedor/src/global/environment.dart';

Network networkFromJson(String str) => Network.fromJson(json.decode(str));

String networkToJson(Network data) => json.encode(data.toJson());

Future<dynamic> httpGetNetworkSolicitud(int id, String token) async {
  var path = 'api/metworksundertakings/$id';
  var url = Uri.parse(Enviroment.apiUrl + path);
  return await http
      .get(url, headers: {"accept": "application/json"}).then((value) async {
    print(value.body);
    return value;
  });
}

class Networklist {
  final List<Network> Networks;
  Networklist({
    required this.Networks,
  });
  factory Networklist.fromJson(List<dynamic> json) {
    List<Network> Networks = <Network>[];
    Networks = json.map((i) => Network.fromJson(i)).toList();
    return new Networklist(Networks: Networks);
  }
}

Future httpRegisterNetworkPost(Network network, String token) async {
  var path = 'api/networks/';
  var url = Uri.parse(Enviroment.apiUrl + path);
  return await http.post(url, headers: {
    "accept": "application/json"
  }, body: {
    "undertaking_id": network.undertakingId.toString(),
    "network": network.network,
    "name": network.name,
    "enlace": network.enlace
  }).then((value) async {
    print(value.request);
    print(networkToJson(network));
    print(value);
    print(value.body);
    return value;
  });
}

class Network {
  Network({
    this.id,
    this.undertakingId,
    this.network,
    this.name,
    this.enlace,
    this.createdAt,
    this.updatedAt,
  });

  dynamic id;
  dynamic undertakingId;
  dynamic network;
  dynamic name;
  dynamic enlace;
  dynamic createdAt;
  dynamic updatedAt;

  factory Network.fromJson(Map<String, dynamic> json) => Network(
        id: json["id"] == null ? null : json["id"],
        undertakingId:
            json["undertaking_id"] == null ? null : json["undertaking_id"],
        network: json["network"] == null ? null : json["network"],
        name: json["name"] == null ? null : json["name"],
        enlace: json["enlace"] == null ? null : json["enlace"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "undertaking_id": '${undertakingId}',
        "network": '${network}',
        "name": '{$name}',
        "enlace": '${enlace}'
      };
}

// To parse this JSON data, do
//
//     final solicitud = solicitudFromJson(jsonString);
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sfs_emprendedor/src/global/environment.dart';

Solicitud solicitudFromJson(String str) => Solicitud.fromJson(json.decode(str));

String solicitudToJson(Solicitud data) => json.encode(data.toJson());

Future httpRegistersolicitudPost1(Solicitud solicitud, String token) async {
  var path = 'api/undertakings/';
  var url = Uri.parse(Enviroment.apiUrl + path);
  return await http
      .post(url,
          headers: {"accept": "application/json"},
          body: solicitudToJson(solicitud))
      .then((value) async {
    print(solicitudToJson(solicitud));
    print(value);
    print(value.body);
    return value;
  });
}

Future<dynamic> httpGetSolicitudAplicant(int id, String token) async {
  var path = 'api/emprendimientosApplicant/$id';
  var url = Uri.parse(Enviroment.apiUrl + path);
  return await http
      .get(url, headers: {"accept": "application/json"}).then((value) async {
    print(value.body);
    return value;
  });
}

Future httpRegistersolicitudPost(Solicitud solicitud, String token) async {
  var path = 'api/undertakings/';
  var url = Uri.parse(Enviroment.apiUrl + path);
  var request =
      http.MultipartRequest("POST", Uri.parse(Enviroment.apiUrl + path));
  var requests = await encode(solicitud, request);
  print(requests.fields);
  var value = await requests.send();
  var response = await http.Response.fromStream(value);
  print(response.body);
  return value;

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

class Solicitudlist {
  final List<Solicitud> solicitudes;
  Solicitudlist({
    required this.solicitudes,
  });
  factory Solicitudlist.fromJson(List<dynamic> json) {
    List<Solicitud> solicitudes = <Solicitud>[];
    solicitudes = json.map((i) => Solicitud.fromJson(i)).toList();
    return new Solicitudlist(solicitudes: solicitudes);
  }
}

Future<http.MultipartRequest> encode(
    Solicitud solicitud, http.MultipartRequest request) async {
  request.fields["applicant_id"] = '${solicitud.applicantId}';
  request.fields["name_undertaking"] = solicitud.nameUndertaking;
  request.fields["descripcion_emprendimiento"] =
      solicitud.descripcionEmprendimiento;
  request.fields["montoSolicitado"] = solicitud.montoSolicitado.toString();
  request.fields["plazo"] = solicitud.plazo.toString();
  request.fields["tir"] = solicitud.tir.toString();
  request.fields["frecuencia_pago"] = solicitud.frecuenciaPago;
  request.fields["tipo_financiamiento"] = solicitud.tipoFinanciamiento;
  request.fields["categoria_emprendimiento"] =
      solicitud.categoriaEmprendimiento;
  request.fields["categoria_negocio"] = solicitud.categoriaNegocio;
  var path = await http.MultipartFile.fromPath(
      "photo_emprendimiento", solicitud.photoEmprendimiento.path);
  request.files.add(path);
  return request;
}

class Solicitud {
  Solicitud({
    this.id,
    this.applicantId,
    this.nameUndertaking,
    this.descripcionEmprendimiento,
    this.montoSolicitado,
    this.plazo,
    this.tir,
    this.frecuenciaPago,
    this.tipoFinanciamiento,
    this.categoriaEmprendimiento,
    this.categoriaNegocio,
    this.verificacion,
    this.valorRecolectado,
    this.photoEmprendimiento,
    this.photoComprobantePagoSfs,
    this.nroComprobante,
    this.createdAt,
    this.updatedAt,
  });

  dynamic id;
  dynamic applicantId;
  dynamic nameUndertaking;
  dynamic descripcionEmprendimiento;
  dynamic montoSolicitado;
  dynamic plazo;
  dynamic tir;
  dynamic frecuenciaPago;
  dynamic tipoFinanciamiento;
  dynamic categoriaEmprendimiento;
  dynamic categoriaNegocio;
  dynamic verificacion;
  dynamic valorRecolectado;
  dynamic photoEmprendimiento;
  dynamic photoComprobantePagoSfs;
  dynamic nroComprobante;
  dynamic createdAt;
  dynamic updatedAt;

  factory Solicitud.fromJson(Map<String, dynamic> json) => Solicitud(
        id: json["id"] == null ? null : json["id"],
        applicantId: json["applicant_id"] == null ? null : json["applicant_id"],
        nameUndertaking:
            json["name_undertaking"] == null ? null : json["name_undertaking"],
        descripcionEmprendimiento: json["descripcion_emprendimiento"] == null
            ? null
            : json["descripcion_emprendimiento"],
        montoSolicitado:
            json["montoSolicitado"] == null ? null : json["montoSolicitado"],
        plazo: json["plazo"] == null ? null : json["plazo"],
        tir: json["tir"] == null ? null : json["tir"],
        frecuenciaPago:
            json["frecuencia_pago"] == null ? null : json["frecuencia_pago"],
        tipoFinanciamiento: json["tipo_financiamiento"] == null
            ? null
            : json["tipo_financiamiento"],
        categoriaEmprendimiento: json["categoria_emprendimiento"] == null
            ? null
            : json["categoria_emprendimiento"],
        categoriaNegocio: json["categoria_negocio"] == null
            ? null
            : json["categoria_negocio"],
        //verificacion:
        //json["verificacion"] == null ? null : json["verificacion"],
        verificacion:
            json["verificacion"] == null ? null : json["verificacion"],
        valorRecolectado: json["valor_recolectado"] == null
            ? null
            : json["valor_recolectado"],
        photoEmprendimiento: json["photo_emprendimiento"] == null
            ? null
            : json["photo_emprendimiento"],
        photoComprobantePagoSfs: json["photo_comprobante_pagoSFS"],
        nroComprobante: json["nro_comprobante"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );
  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "applicant_id": applicantId == null ? null : applicantId,
        "name_undertaking": nameUndertaking == null ? null : nameUndertaking,
        "descripcion_emprendimiento": descripcionEmprendimiento == null
            ? null
            : descripcionEmprendimiento,
        "montoSolicitado": montoSolicitado == null ? null : montoSolicitado,
        "plazo": plazo == null ? null : plazo,
        "tir": tir == null ? null : tir,
        "frecuencia_pago": frecuenciaPago == null ? null : frecuenciaPago,
        "tipo_financiamiento":
            tipoFinanciamiento == null ? null : tipoFinanciamiento,
        "categoria_emprendimiento":
            categoriaEmprendimiento == null ? null : categoriaEmprendimiento,
        "categoria_negocio": categoriaNegocio == null ? null : categoriaNegocio,
        "verificacion": verificacion == null ? null : verificacion,
        "valor_recolectado": valorRecolectado == null ? null : valorRecolectado,
        "photo_emprendimiento":
            photoEmprendimiento == null ? null : photoEmprendimiento,
        "photo_comprobante_pagoSFS": photoComprobantePagoSfs,
        "nro_comprobante": nroComprobante,
        //  "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        //  "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}

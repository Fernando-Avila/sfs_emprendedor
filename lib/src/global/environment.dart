import 'dart:io' show Platform;

class Enviroment {
  //static String apiUrl = 'http://10.0.2.2:8000/';
  static String apiUrl = 'http://192.168.1.51:8000/';

  String apigoogle = 'AIzaSyAdtacnR0FmXvBzATNFczLuIuLLd6V9yg0';
  // static String apiUrl = 'http://192.168.100.144:8090/api/';
  static String keymessaging =
      'BMnEDleIV0mKcGKgK0jefQc7dnWrbG37E7doeKxc0CoqcmwWuRd6Z6N4rVgmfpUpRV03lourUlAePngHepL_Ric';
  static String? contact(String Contacto) {
    if (Platform.isAndroid) {
      return 'whatsapp://send?phone=$Contacto';
    } else if (Platform.isIOS) {
      return 'https://wa.me/$Contacto';
    }
  }

static  var header = {
    'content-type': 'application/json',
    'accept': 'application/json',
    "connection": "Keep-Alive",
  };
}

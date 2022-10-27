import 'package:url_launcher/url_launcher.dart';
import 'package:external_app_launcher/external_app_launcher.dart';

double calcularvalores(double _capital, int _plazo, int _interes) {
  double interesmensual = (_interes / 12) / 100;
  print(interesmensual);
  print(_capital / _plazo);
  print((_capital / _plazo) * interesmensual);
  return (_capital / _plazo) + (_capital * interesmensual);
}

Future<void> openMap(lat, lng) async {
  Uri url = Uri.parse('geo:${lat},${lng}?q=${lat},${lng}');

  // ignore: deprecated_member_use
  if (await canLaunch(url.toString())) {
    // ignore: deprecated_member_use
    print('Se puede XD');
    await launch(url.toString());
  } else {
    await LaunchApp.openApp(
      androidPackageName: 'com.google.android.gms.maps',
      iosUrlScheme: 'maps://',
      openStore: true,
    );
  }
}

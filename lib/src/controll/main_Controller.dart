import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_messaging_platform_interface/src/remote_notification.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:sfs_emprendedor/src/styles/custom_styles.dart';
import 'package:sfs_emprendedor/src/widgets/widgettext.dart';

class MainController extends ControllerMVC {
  late BuildContext context;

  Future<void> Notify(RemoteNotification Message, BuildContext contextk) async {
    await Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      margin: EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(15),
      forwardAnimationCurve: Curves.easeInOutBack,
      backgroundGradient: EstiloApp.horizontalgradientpurplepinknotify,
      boxShadows: [
        BoxShadow(
            offset: Offset(0.0, 1.0),
            blurRadius: 1.0,
            color: Color(0x24000000)),
      ],
      onTap: (value) {
        Navigator.pushNamed(contextk, '/register');
      },
      messageText: p1(Message.title!, EstiloApp.colorwhite, TextAlign.left,
          'Montserrat', FontWeight.w500, FontStyle.normal),
      titleText: H4(Message.body!, EstiloApp.colorwhite, TextAlign.left,
          'Montserrat', FontWeight.w500, FontStyle.normal),
      duration: Duration(seconds: 5),
    ).show(contextk);
    print('Cerrada');
  }
}

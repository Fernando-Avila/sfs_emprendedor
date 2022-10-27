import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sfs_emprendedor/src/controll/notification.dart';

class PushNotificationController {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static StreamController<RemoteNotification> _messageStreamController =
      new StreamController();
  static Stream<RemoteNotification> get MessageStream =>
      _messageStreamController.stream;
  static Future _backgroundHandler(RemoteMessage message) async {
    print(' _backgroundHandler');
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    await notifycation(message.notification!);
    print(' _onMessageHandler');
    if (message.notification != null) {
      _messageStreamController.add(message.notification!);
    }
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    print(' _onMessageOpenApp');
  }

  static Future initializaApp() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? device = await messaging.getToken();
    print('Controller $device');
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen((event) {
      _onMessageHandler(event);
    });
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
  }

  static closeStream() {
    _messageStreamController.close();
  }
}

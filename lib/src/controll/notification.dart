import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void notifycation(RemoteNotification notification) async {
  print(notification.title);
  print(notification.body);
  print(notification.titleLocArgs.length);
  print(notification.bodyLocKey);
  print(notification.titleLocKey);
  print('and');
  print(notification.android!.imageUrl);
  print(notification.android!.link);
  print(notification.android!.clickAction);
  print(notification.android!.channelId);

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
          'com.example.pickup_conductor_main', 'principal');
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      1, notification.title, notification.body, platformChannelSpecifics,
      payload: 'data');
}

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid, iOS: null, macOS: null);

    /*await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);*/
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (details) => selectNotification);
  }

  Future selectNotification(String? payload) async {
    //Handle notification tapped logic here
  }
}

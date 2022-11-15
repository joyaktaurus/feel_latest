// @dart=2.9
import 'package:feelathomeproject/Screens/Notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  // _showOverlayWindow();
  RemoteNotification notification = message.notification;
  AndroidNotification android = message.notification?.android;
  print("New Notification");
}

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title// description
  importance: Importance.max,
  sound: RawResourceAndroidNotificationSound('notification_sound'),
);

/// Initialize the [FlutterLocalNotificationsPlugin] package.
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  bool _initialized = false;

  Future<String> getFCMToken() {
    return FirebaseMessaging.instance.getToken();
  }

  Future<void> init() async {
      BuildContext context;
      // For iOS request permission first.
      await Firebase.initializeApp();
      var initialzationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
      var initializationSettings =
      InitializationSettings(android: initialzationSettingsAndroid);
      flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification: (String payload)async{
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NotificationPage()));
      });
      // Set the background messaging handler early on, as a named top-level function
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
      var fcmToken = await FirebaseMessaging.instance.getToken();
      print(fcmToken);
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
  }
}

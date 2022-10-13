// @dart=2.9
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  // _showOverlayWindow();
  RemoteNotification notification = message.notification;
  AndroidNotification android = message.notification?.android;

  // flutterLocalNotificationsPlugin.show(
  //     message.data.hashCode,
  //     message.data["title"],
  //     message.data["body"],
  //     NotificationDetails(
  //       android: AndroidNotificationDetails(
  //           channel.id, channel.name, channel.description,
  //           sound: RawResourceAndroidNotificationSound('notification_sound'),
  //           // TODO add a proper drawable resource to android, for now using
  //           //      one that already exists in example app.
  //           // ABITODO: Add a ringtone , navigate to the Call Accept Screen
  //           icon: 'launch_background',
  //           priority: Priority.high,
  //           importance: Importance.high,
  //           fullScreenIntent: true),
  //     ));
}

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
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
    if (!_initialized) {
      // For iOS request permission first.
      await Firebase.initializeApp();

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
      _initialized = true;

    }
  }
}

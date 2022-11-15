// @dart=2.9

import 'package:feelathomeproject/screens/splash_screen.dart';
import 'package:feelathomeproject/widgets/NavigationService.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'notificationservice/local_notification_service.dart';
import 'view_models/home_view_model.dart';
import 'view_models/user_view_model.dart';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

AndroidNotificationChannel channel;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
FirebaseMessaging messaging;

void main() async {
  // await SystemAlertWindow.requestPermissions(prefMode: prefMode);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var fcmToken = await FirebaseMessaging.instance.getToken();
  print(fcmToken);
  messaging = FirebaseMessaging.instance;
  messaging.subscribeToTopic("flutter-notification");

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
        'flutter_notification_title', // title
        'flutter_notification_description', // description
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        showBadge: true,
        playSound: true);

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  LocalNotificationService.initialize();
  runApp(MyApp());
  await Permission.location.request();
  await Permission.camera.request();
  //await PushNotificationsManager().init();

}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
      ],
      child: MaterialApp(
          navigatorKey:NavigationService.navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Feel At Home',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: ShowSplash()),
    );
  }
 // final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  MethodChannel callChannel = MethodChannel("samples.flutter.dev/battery");
  bool isFromFcm = false;
  RemoteMessage fcmMessage;
}
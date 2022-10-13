// @dart=2.9
import 'package:feelathomeproject/screens/splash_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'fcm/fcm_setup.dart';
import 'view_models/home_view_model.dart';
import 'view_models/user_view_model.dart';

void main() async {
  // await SystemAlertWindow.requestPermissions(prefMode: prefMode);
  runApp(MyApp());
 // await Permission.camera.request();
  await Permission.location.request();
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationsManager().init();
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
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Feel At Home',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: ShowSplash()),
    );
  }
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  MethodChannel callChannel = MethodChannel("samples.flutter.dev/battery");
  bool isFromFcm = false;
  RemoteMessage fcmMessage;
}
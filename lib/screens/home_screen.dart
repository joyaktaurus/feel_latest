// @dart=2.9
import 'package:feelathomeproject/screens/tab_home_listing.dart';
import 'package:feelathomeproject/screens/tab_profile.dart';
import 'package:feelathomeproject/screens/tab_searchh.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../fcm/fcm_setup.dart';
import 'Notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  // _showOverlayWindow();
  RemoteNotification notification = message.notification;
  AndroidNotification android = message.notification?.android;
  flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
            channel.id, channel.name, channel.description,
            // TODO add a proper drawable resource to android, for now using
            //      one that already exists in example app.
            // ABITODO: Add a ringtone , navigate to the Call Accept Screen
            icon: 'launch_background',
            priority: Priority.high,
            importance: Importance.high,
            fullScreenIntent: true),
      ));
}

class HomeScreen extends StatefulWidget {
  int selectedPage = 0;

  HomeScreen(this.selectedPage);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  MethodChannel channel = MethodChannel("samples.flutter.dev/battery");
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final _pageOptions = [Tab_home_listing(), Tab_searchh(), Tab_profile()];

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Get.toNamed(NOTIFICATIOINS_ROUTE);

        Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomeScreen(0)));

    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Get.find<HomeController>().getNotificationsNumber();
      print(message);
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
// If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
             "Notification",
              channel.name,
             "notifications",
              icon: android.smallIcon,
              playSound: true,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOptions[widget.selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.selectedPage, //New
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/images/home.png")),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/images/search.png")),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/images/account.png")),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      widget.selectedPage = index;
    });
  }
}

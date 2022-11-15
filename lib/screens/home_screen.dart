// @dart=2.9
import 'dart:convert';

import 'package:feelathomeproject/screens/tab_home_listing.dart';
import 'package:feelathomeproject/screens/tab_profile.dart';
import 'package:feelathomeproject/screens/tab_search.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../main.dart';
import '../network/shared_preference_helper.dart';
import 'Notifications.dart';
import 'login.dart';

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

// It is assumed that all messages contain a data field with the key 'type'

  @override
  void initState() {
    super.initState();
    var initialzationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
    InitializationSettings(android: initialzationSettingsAndroid);


    flutterLocalNotificationsPlugin
        .initialize(initializationSettings);

    setupInteractedMessage();

    FirebaseMessaging.onMessage.listen((message) async {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;

      if (notification != null && android != null && !kIsWeb) {
        String action = jsonEncode(message.data);

        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.name,
                "new channel",
                priority: Priority.high,
                importance: Importance.max,
                setAsGroupSummary: true,
                styleInformation: DefaultStyleInformation(true, true),
                largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
                channelShowBadge: true,
                autoCancel: true,
              ),
            ),
            payload: action);
      }
    });
    FirebaseMessaging.onMessageOpenedApp
        .listen((message) => _handleMessage(message.data));
  }
  Future<dynamic> onDidReceiveNotificationResponse(payload) async {
    // Map<String, dynamic> action = jsonDecode(payload);
    // _handleMessage(action);
  }

  Future<void> setupInteractedMessage() async {
    await FirebaseMessaging.instance
        .getInitialMessage()
        .then((value) => _handleMessage(value != null ? value.data : Map()));
  }

  void _handleMessage(Map<String, dynamic> data) {
    if (data['redirect'] == "product") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NotificationPage()));
    } else if (data['redirect'] == "product_details") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
              NotificationPage()));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOptions[widget.selectedPage],
      extendBody: true,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15), topLeft: Radius.circular(15)),
          boxShadow: [
            BoxShadow(color: Colors.green.shade50, spreadRadius: 0, blurRadius: 16),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: BottomNavigationBar(
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
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    if (index == 2) {
      _startApp(index);
    } else {
      setState(() {
        widget.selectedPage = index;
      });
    }
  }

  Future<void> _startApp(int index) async {
    SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();
    String isLoggedIn = await sharedPreferenceHelper.getisLoggedInVale();
    if (isLoggedIn != null) {
      if (isLoggedIn == "true") {
        setState(() {
          widget.selectedPage = index;
        });
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Login()),
            (Route<dynamic> route) => false);
      }
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Login()),
          (Route<dynamic> route) => false);
    }
  }
}

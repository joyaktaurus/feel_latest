import 'package:flutter/material.dart';
import '../network/shared_preference_helper.dart';
import 'home_screen.dart';


class ShowSplash extends StatefulWidget {
  @override
  _ShowSplashState createState() => _ShowSplashState();
}

class _ShowSplashState extends State<ShowSplash> {
  @override
  void initState() {
    super.initState();
    // FirebaseMessaging.instance.getInitialMessage().then(
    //       (message) {
    //     print("FirebaseMessaging.instance.getInitialMessage");
    //     if (message != null) {
    //       print("New Notification");
    //       if (message.data['_id'] != null) {
    //         Navigator.of(context)
    //             .push(MaterialPageRoute(builder: (context) => NotificationPage()));
    //       }
    //     }
    //   },
    // );
    // // 2. This method only call when App in forground it mean app must be opened
    // FirebaseMessaging.onMessage.listen(
    //       (message) {
    //     print("FirebaseMessaging.onMessage.listen");
    //     if (message.notification != null) {
    //       print(message.notification!.title);
    //       print(message.notification!.body);
    //       print("message.data11 ${message.data}");
    //       LocalNotificationService.createanddisplaynotification(message);
    //
    //     }
    //   },
    // );
    // // 3. This method only call when App in background and not terminated(not closed)
    // FirebaseMessaging.onMessageOpenedApp.listen(
    //       (message) {
    //         LocalNotificationService.createanddisplaynotification(message);
    //     print("FirebaseMessaging.onMessageOpenedApp.listen");
    //     if (message.notification != null) {
    //       print(message.notification!.title);
    //       print(message.notification!.body);
    //       print("message.data22 ${message.data['_id']}");
    //
    //     }
    //   },
    // );
    //wait 4 seconds and start login page
    Future.delayed(Duration(seconds: 2)).then((value) async {
      _startApp();
    });
  }

  Future<void> _startApp() async {
    SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();
    sharedPreferenceHelper.searchPopUpValue("false");
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomeScreen(0)),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    //main container main background color
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF33cdde), Color(0xFF028b9b)])),
      //scaffold set transparent for view container background
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          child: Image.asset(
                            "assets/images/logo.png",
                            height: 150.0,
                            width: 150.0,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(left: 0.0, right: 0.0, top: 10.0),
                          child: const Text(
                            'Feel At Home',
                            style: TextStyle(
                                fontFamily: 'kistalbld',
                                color: Colors.white,
                                fontSize: 20),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 1.0),
                          child: Text(
                            "Guardian far from home",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'kistalitl',
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 19.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

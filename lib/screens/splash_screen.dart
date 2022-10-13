import 'package:flutter/material.dart';
import '../network/shared_preference_helper.dart';
import '../view_models/user_view_model.dart';
import 'ChatRoom.dart';
import 'Radio.dart';
import 'home_screen.dart';
import 'login.dart';

class ShowSplash extends StatefulWidget {
  @override
  _ShowSplashState createState() => _ShowSplashState();
}
class _ShowSplashState extends State<ShowSplash> {

  @override
  void initState() {
    super.initState();
    //wait 4 seconds and start login page
    Future.delayed(Duration(seconds: 2)).then((value) async {
      _startApp();
    });
  }

  Future<void> _startApp() async {
    SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();
    sharedPreferenceHelper.searchPopUpValue("false");
    String isLoggedIn = await sharedPreferenceHelper.getisLoggedInVale();
    if (isLoggedIn != null) {
      if (isLoggedIn == "true") {
        Navigator.of(context).pushAndRemoveUntil(
           MaterialPageRoute(builder: (context) => HomeScreen(0)), //
       //     MaterialPageRoute(builder: (context) => CustomRadioExample()),
         //  MaterialPageRoute(builder: (context) => ChatRoom()),
            (Route<dynamic> route) => false);
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

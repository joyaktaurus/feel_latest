// @dart=2.9
import 'package:feelathomeproject/Screens/splash_screen.dart';
import 'package:feelathomeproject/screens/Help.dart';
import 'package:feelathomeproject/screens/Notifications.dart';
import 'package:feelathomeproject/screens/my_Rooms.dart';
import 'package:feelathomeproject/util/menu_line.dart';
import 'package:feelathomeproject/util/utils.dart';
import 'package:flutter/material.dart';

import '../network/shared_preference_helper.dart';
import 'about.dart';
import 'complaint_list.dart';
import 'my_billings.dart';
import 'my_details.dart';

class Tab_profile extends StatefulWidget {
  //const SplashScreen() : super(key: key);

  @override
  _Tab_profileState createState() => _Tab_profileState();
}

class _Tab_profileState extends State<Tab_profile> {
  String name = "---";
  SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: Container(
        child: Column(
          children: [
            Container(child: getHeader()),
            Expanded(
              child: getBody(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _LoadData();
  }

  Future<void> _LoadData() async {
    SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();
    var userModel = await sharedPreferenceHelper.getUser();
    String name = userModel.customer.name;
    setState(() {
      this.name = name;
    });
  }

  Widget getHeader() {
    print(name);
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 50),
      width: MediaQuery.of(context).size.width,
      height: 150,
      decoration: new BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 15),
                child: Image.asset(
                  'assets/images/account.png',
                  width: 61,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      child: name == "---"
                          ? Text(
                              name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            )
                          : Text(
                              name.capitalize(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getBody() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: new BoxDecoration(color: Colors.white),
      child: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 1.0,
              ),
              OpenFlutterMenuLine(
                  title: 'My Rooms',
                  assetImage: 'assets/images/room.png',
                  onTap: (() => {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => My_Rooms()))
                      })),
              Divider(),
              OpenFlutterMenuLine(
                  title: 'My Profiles',
                  assetImage: 'assets/images/myprofile.png',
                  onTap: (() => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => My_details()))
                      })),
              Divider(),
           /*   OpenFlutterMenuLine(
                  title: 'My Billings',
                  assetImage: 'assets/images/mybilling.png',
                  onTap: (() => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MyBillingsList()))
                      })),
              Divider(),*/
              OpenFlutterMenuLine(
                  title: 'Notifications',
                  assetImage: 'assets/images/notification.png',
                  onTap: (() => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => NotificationPage()))
                      })),
              Divider(),
              OpenFlutterMenuLine(
                  title: 'Help',
                  assetImage: 'assets/images/help.png',
                  onTap: (() => {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => HelpPage()))
                      })),
              Divider(),
              OpenFlutterMenuLine(
                  title: 'Complaints',
                  assetImage: 'assets/images/complaints.png',
                  onTap: (() => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ComplaintList()))
                        //Navigator.of(context).pushNamed(OpenFlutterEcommerceRoutes.settings)
                      })),
              Divider(),
              OpenFlutterMenuLine(
                  title: 'About',
                  assetImage: 'assets/images/about.png',
                  onTap: (() => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AboutPage()))
                        //Navigator.of(context).pushNamed(OpenFlutterEcommerceRoutes.settings)
                      })),
              Divider(),
              OpenFlutterMenuLine(
                  title: 'Logout',
                  assetImage: 'assets/images/logout.png',
                  onTap: (() => {sharedPreferenceHelper.removeAll(),
                  Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) =>ShowSplash()),
                  (Route<dynamic> route) => false)
                  })),
              Divider(),
            ],
          )
        ],
      ),
    );
  }
}

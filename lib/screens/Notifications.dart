// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../network/shared_preference_helper.dart';
import '../util/styles.dart';
import '../view_models/base_view_model.dart';
import '../view_models/user_view_model.dart';
import '../widgets/loading_animation.dart';
import '../widgets/loading_widget.dart';
import 'map_view.dart';

class NotificationPage extends StatefulWidget {
  //const SplashScreen() : super(key: key);
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool isSwitched = false;
  int statusNotifvalue = 1;
  UserViewModel _userViewModel;
  SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Provider.of<UserViewModel>(context, listen: false)
            .getNotificationList());
    _userViewModel = Provider.of<UserViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: Container(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: ListTile(
                  dense: true,
                  leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back)),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                child: Text(
                  "NOTIFICATIONS",
                  style: TextStyle(
                      color: GreenBottom,
                      fontSize: 20.5,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
            getHeader(),
            Expanded(
              child: getBody(),
            ),
          ],
        ),
      ),
    );
  }

  Widget getHeader() {
    return Container(
      margin: EdgeInsets.only(left: 1, right: 1, top: 10),
      child: Card(
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  SizedBox(
                    width: 16,
                  ),
                  Text("Notifications(ON/OFF)"),
                ],
              ),
              Consumer<UserViewModel>(builder: (contextModel, model, child) {
                return model.response == Response.Success &&
                        model.notifDataModel.notification_status != null &&
                        model.notifDataModel.notification_status.isNotEmpty &&
                        model.notifDataModel.notification_status != "null"
                    ? Switch(
                        value: Provider.of<UserViewModel>(context)
                                    .notifDataModel
                                    .notification_status ==
                                "1"
                            ? true
                            : false,
                        //  value: isSwitched,
                        onChanged: (value) async {
                          setState(() {
                            isSwitched = value;
                            if (isSwitched) {
                              Provider.of<UserViewModel>(context, listen: false)
                                  .toggleNotification(true);
                              print('Noti: $value');
                              statusNotifvalue = 1;
                            } else {
                              Provider.of<UserViewModel>(context, listen: false)
                                  .toggleNotification(false);
                              print('Noti: $value');
                              statusNotifvalue = 0;
                            }
                            print(isSwitched);
                          });
                          var res = false;
                          res = await _userViewModel.PostNotificationStatus(
                              statusNotifvalue);
                          if (res) {}
                        },
                        activeTrackColor: GreenBottom,
                        activeColor: Colors.white,
                      )
                    : Switch(
                        value: isSwitched,
                        //  value: isSwitched,
                        onChanged: (value) async {
                          setState(() {
                            isSwitched = value;
                            if (isSwitched) {
                              Provider.of<UserViewModel>(context, listen: false)
                                  .toggleNotification(true);
                              print('Noti: $value');
                              statusNotifvalue = 1;
                            } else {
                              Provider.of<UserViewModel>(context, listen: false)
                                  .toggleNotification(false);
                              print('Noti: $value');
                              statusNotifvalue = 0;
                            }
                            print(isSwitched);
                          });
                          var res = false;
                          res = await _userViewModel.PostNotificationStatus(
                              statusNotifvalue);
                          if (res) {}
                        },
                        activeTrackColor: GreenBottom,
                        activeColor: Colors.white,
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget getBody() {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Container(
        child: Consumer<UserViewModel>(builder: (contextModel, model, child) {
          return model.response == Response.Success &&
                  model.notificationList != null &&
                  model.notificationList.isNotEmpty
              ? ListView.builder(
                  itemCount: model.notificationList.length,
                  itemBuilder: (BuildContext ctxt, int Index) {
                    return Card(
                      elevation: 4,
                      margin: EdgeInsets.all(10),
                      child: Container(
                          padding: EdgeInsets.all(8),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 8,
                                )
                              ],
                              borderRadius: BorderRadius.circular(2),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      model.notificationList[Index]?.type ?? "",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      model.notificationList[Index]
                                              ?.description ??
                                          "",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                ],
                              ),
                            ),
                          )),
                    );
                  })
              : model.notificationList.isEmpty &&
                      model.response == Response.Success
                  ? Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Center(
                        child: Text("No Data"),
                      ),
                    )
                  : LoadingAnimation();
        }),
      ),
    );
  }
}


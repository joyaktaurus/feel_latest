// @dart=2.9
import 'package:feelathomeproject/screens/ChatRoom.dart';
import 'package:feelathomeproject/screens/complaint_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../util/CustomAlertDialog.dart';
import '../util/styles.dart';
import '../view_models/base_view_model.dart';
import '../view_models/user_view_model.dart';
import '../widgets/loading_animation.dart';
import '../widgets/loading_widget.dart';

class ComplaintList extends StatefulWidget {
  //const SplashScreen() : super(key: key);
  @override
  _ComplaintListState createState() => _ComplaintListState();
}

class _ComplaintListState extends State<ComplaintList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Provider.of<UserViewModel>(context, listen: false).getComplaintList());
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
                padding: const EdgeInsets.only(top: 42),
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
              alignment: Alignment.center,
              child: Container(
                child: Text.rich(
                  TextSpan(
                      text: "SUPPORT TICKET",
                      style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 20.5,
                          fontWeight: FontWeight.normal),
                      children: [
                        TextSpan(
                          text: "",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.5,
                              fontWeight: FontWeight.normal),
                        ),
                      ]),
                ),
              ),
            ),
            Expanded(
              child: getBodyv(),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton:
      Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: GreenBottom,
          onPressed: () {
            setState(() {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ComplaintRegistration()));
            });
          },
        ),
      ),

      /* floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 50.0,
                width: 50.0,
                child: InkWell(
                  onTap: () {
                    showDialog(
                      barrierColor: Colors.black26,
                      context: context,
                      builder: (context) {
                        return const CustomAlertDialog(
                          title: "Emergency Call",
                          description: "Do you want continue.",
                        );
                      },
                    );
                  },
                  child: FittedBox(
                    child: FloatingActionButton(
                      child: Column(
                        children: [
                          Image.asset('assets/images/emergency.png'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        )*/
    );
  }

  Widget getBodyv() {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5, top: 4),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Container(
        child: Consumer<UserViewModel>(builder: (contextModel, model, child) {
          return model.response == Response.Success &&
                  model.supportList != null &&
                  model.supportList.isNotEmpty
              ? ListView.builder(
                  itemCount: model.supportList.length,
                  itemBuilder: (BuildContext ctxt, int Index) {
                    return InkWell(
                      onTap: (() => {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ChatRoom(index: Index)))
                          }),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Card(
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                'Date & Time: ',
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                'Status',
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Text(model.supportList[Index]
                                                      ?.created_on ??
                                                  ""),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text(model.supportList[Index]
                                                      ?.status ??
                                                  ""),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Title")),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(model.supportList[Index]?.issue_type=="Other"?
                                          model.supportList[Index]?.title ??
                                              "":model.supportList[Index].issue_type)),
                                  model.supportList[Index].status == "closed"
                                      ? Column(
                                          children: [
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: RatingBar.builder(
                                                initialRating: model
                                                            .supportList[Index]
                                                            .rating !=
                                                        null
                                                    ? num.tryParse(model
                                                            .supportList[Index]
                                                            .rating)
                                                        ?.toDouble()
                                                    : 0.0,
                                                minRating: 1,
                                                maxRating: model
                                                            .supportList[Index]
                                                            .rating !=
                                                        null
                                                    ? num.tryParse(model
                                                            .supportList[Index]
                                                            .rating)
                                                        ?.toDouble()
                                                    : 0.0,
                                                tapOnlyMode: false,
                                                updateOnDrag: false,
                                                direction: Axis.horizontal,
                                                allowHalfRating: false,
                                                itemCount: 5,
                                                itemSize: 15.0,
                                                itemBuilder: (context, _) =>
                                                    Icon(
                                                  Icons.star,
                                                  color: GreenBottom,
                                                ),
                                                onRatingUpdate: (rating) {
                                                  print(rating);
                                                },
                                              ),
                                            ),
                                          ],
                                        )
                                      : SizedBox(
                                          width: 0,
                                        )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  })
              : model.supportList.isEmpty && model.response == Response.Success
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

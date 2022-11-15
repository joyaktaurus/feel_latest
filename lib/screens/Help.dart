// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../util/styles.dart';
import '../view_models/base_view_model.dart';
import '../view_models/user_view_model.dart';
import '../widgets/loading_widget.dart';
import 'map_view.dart';

class HelpPage extends StatefulWidget {
  //const SplashScreen() : super(key: key);
  @override
  _HelpPageState createState() => _HelpPageState();
}

bool arrow = false;

Future<void> _sendMail() async {
  final Uri launchUri = Uri(
    scheme: 'mailto',
    path: 'info@feelathomegroup.com',
  );
  await launchUrl(launchUri);
}

class _HelpPageState extends State<HelpPage> {
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Provider.of<UserViewModel>(context, listen: false).gethelpList());
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
                  "HELP",
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
    return InkWell(
      onTap: () {
        _sendMail();
      },
      child: Card(
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          width: MediaQuery.of(context).size.width,
          height: 100,
          decoration: new BoxDecoration(color: Colors.white),
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Icon(Icons.mail_outline),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(CircleBorder()),
                  padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                  backgroundColor: MaterialStateProperty.all(GreenBottom),
                  // <-- Button color
                  overlayColor:
                      MaterialStateProperty.resolveWith<Color>((states) {
                    if (states.contains(MaterialState.pressed))
                      return Colors.blue; // <-- Splash color
                  }),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          child: Text(
                            "Email Us",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          child: Text(
                            "info@feelathomegroup.com",
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 10.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getBody() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: new BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(top: 20, left: 20, right: 10),
              child: Text(
                "FAQ",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.5,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Consumer<UserViewModel>(
                  builder: (contextModel, model, child) {
                return model.response == Response.Success &&
                        model.faqList != null &&
                        model.faqList.isNotEmpty
                    ? new ListView.builder(
                        itemCount: 5,
                        itemBuilder: (BuildContext ctxt, int Index) {
                          return ExpansionTile(
                            controlAffinity: ListTileControlAffinity.trailing,
                            collapsedIconColor:
                                isExpanded ? Colors.black : Colors.black,
                            childrenPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            expandedCrossAxisAlignment: CrossAxisAlignment.end,
                            maintainState: true,
                            title: Text(
                              model.faqList[Index]?.question ?? "",
                              style: TextStyle(
                                  color:
                                      isExpanded ? Colors.black : Colors.black,
                                  fontSize: 15.5,
                                  fontWeight: FontWeight.normal),
                            ),
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  model.faqList[Index]?.answer ?? "",
                                  style: TextStyle(
                                      color: isExpanded
                                          ? Colors.black
                                          : Colors.black,
                                      fontSize: 15.5,
                                      fontWeight: FontWeight.normal),
                                ),
                              )
                              // This button is used to remove this item
                            ],
                            onExpansionChanged: (bool expanding) => setState(
                              () => this.isExpanded = expanding,
                            ),
                          );
                          /* return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              InkWell(
                                child: Container(
                                  margin: EdgeInsets.only(left: 5, right: 5),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            Container(
                                                width: 200,
                                                child: Text(
                                                  model.faqList[Index]
                                                      ?.question ?? "",
                                                  overflow: TextOverflow.clip,
                                                  maxLines: 2,
                                                )),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 15.0),
                                          child: Icon(Icons.chevron_right),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );*/
                        })
                    : model.faqList.isEmpty &&
                            model.response == Response.Success
                        ? Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Center(
                              child: Text("No Data"),
                            ),
                          )
                        : Loading();
              }),
            ),
          ),
        ],
      ),
    );
  }
}

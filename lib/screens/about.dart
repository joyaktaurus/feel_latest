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

class AboutPage extends StatefulWidget {
  //const SplashScreen() : super(key: key);
  @override
  _AboutPageState createState() => _AboutPageState();
}

Future<void> _launchInWebViewOrVC(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.inAppWebView,
    webViewConfiguration: const WebViewConfiguration(
        headers: <String, String>{'my_header_key': 'my_header_value'}),
  )) {
    throw 'Could not launch $url';
  }
}

class _AboutPageState extends State<AboutPage> {
  Future<void> _launched;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Provider.of<UserViewModel>(context, listen: false).getAboutList());
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
                  "ABOUT",
                  style: TextStyle(
                      color: GreenBottom,
                      fontSize: 20.5,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Expanded(
              child: getBody(),
            ),
          ],
        ),
      ),
    );
  }

  Widget getBody() {
    final Uri toLaunch = Uri(
        scheme: 'https',
        host: 'www.seowebdesign.in',
        path: '/feelathome/site/about-us');
    return Consumer<UserViewModel>(builder: (contextModel, model, child) {
      return model.response == Response.Success &&
              model.aboutDataModel != null
          ? Column(
              children: [
                Container(
                  margin: EdgeInsets.all(40),
                  child: Image.asset(
                    "assets/images/logo.png",
                    height: 100.0,
                    width: 100.0,
                    color: GreenBottom,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0, left: 20, right: 20),
                  child: Text(
                    model.aboutDataModel?.about ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.0,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          InkWell(
                            onTap: () => setState(() {
                              _launched = _launchInWebViewOrVC(toLaunch);
                            }),
                            child: Container(
                              margin: EdgeInsets.only(left: 5, right: 5),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text("Privacy Policy"),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15.0),
                                        child: Icon(Icons.chevron_right),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => setState(() {
                              _launched = _launchInWebViewOrVC(toLaunch);
                            }),
                            child: Container(
                              margin: EdgeInsets.only(left: 5, right: 5),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text("Terms & Conditions"),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15.0),
                                        child: Icon(Icons.chevron_right),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => setState(() {
                              Share.share(
                                  'Download Feel at home app at https://seowebdesign.in/feelathome/site/');
                            }),
                            child: Container(
                              margin: EdgeInsets.only(left: 5, right: 5),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text("Share"),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15.0),
                                        child: Icon(Icons.chevron_right),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )
          : Loading();
    });
  }
}

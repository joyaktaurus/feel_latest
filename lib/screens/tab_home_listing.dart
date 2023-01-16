// @dart=2.9
import 'package:feelathomeproject/Screens/Radio.dart';
import 'package:feelathomeproject/screens/CollegedetailsView.dart';
import 'package:feelathomeproject/screens/popular_property.dart';
import 'package:feelathomeproject/screens/search_popup.dart';
import 'package:feelathomeproject/util/background_home_page.dart';
import 'package:feelathomeproject/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../network/shared_preference_helper.dart';
import '../util/light_color.dart';
import '../util/styles.dart';
import '../util/widgets.dart';
import '../view_models/base_view_model.dart';
import '../view_models/user_view_model.dart';
import '../widgets/loading_widget.dart';
import 'home_screen.dart';
import 'login.dart';

class Tab_home_listing extends StatefulWidget {
  //const SplashScreen() : super(key: key);

  @override
  _Tab_home_listingState createState() => _Tab_home_listingState();
}

class _Tab_home_listingState extends State<Tab_home_listing> {
  String dropdownValue, dropdownValue1, dropdownValue2;
  UserViewModel _userViewModel;
  int countryValue = 0;
  int countryValueId = 1;
  String _groupValue = '1';
  bool _isVisible = false;

  ValueChanged<String> _valueChangedHandler() {
    return (value) => setState(() {
          _groupValue = value;
          print(_groupValue);
        });
  }

  @override
  void initState() {
    super.initState();
    _startApp();
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Provider.of<UserViewModel>(context, listen: false).getCountryList(1));
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Provider.of<UserViewModel>(context, listen: false).getCollageList(1));
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Provider.of<UserViewModel>(context, listen: false)
            .getSearchList(null, 1, null, null, null, null, null, null));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          backgroundHomeDash(),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/logo_text.png',
                                      fit: BoxFit.fitHeight,
                                      width: 100.0,
                                      height: 65.0,
                                    ),
                                  ],
                                ),
                                Visibility(
                                  visible: _isVisible,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) => Login()),
                                          (Route<dynamic> route) => false);
                                    },
                                    child: Icon(Icons.person_outlined),
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          CircleBorder()),
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.all(5)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              GreenBottom),
                                      // <-- Button color
                                      overlayColor: MaterialStateProperty
                                          .resolveWith<Color>((states) {
                                        if (states
                                            .contains(MaterialState.pressed))
                                          return Colors
                                              .blue; // <-- Splash color
                                      }),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Feel At Home Offers You the",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15.5,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 7.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Best Level Of Comfort !!",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.5,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            _search(),
                            SizedBox(
                              height: 20,
                            ),
                            _CountrySelectionUi(),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(top: 20, left: 11, right: 10),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PopularPropertyList()));
                            },
                            child: Row(
                              children: [
                                const Text.rich(
                                  TextSpan(
                                      text: "Popular",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.5,
                                          fontWeight: FontWeight.bold),
                                      children: [
                                        TextSpan(
                                          text: " Properties",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.5,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ]),
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Text("View All",
                                        style: new TextStyle(
                                            color: Colors.blue,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.normal)),
                                    Icon(
                                      Icons.chevron_right_outlined,
                                      color: Colors.blue,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: getBody()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _CountrySelectionUi() {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyRadioOption<String>(
              value: '1',
              groupValue: _groupValue,
              id: '1',
              onChanged: _valueChangedHandler(),
              label: 'CANADA',
              image: 'assets/images/candaimage.jpeg',
            ),
            MyRadioOption<String>(
              value: '2',
              groupValue: _groupValue,
              id: '2',
              onChanged: _valueChangedHandler(),
              label: 'UK',
              image: 'assets/images/ukimage.webp',
            ),
            MyRadioOption<String>(
              value: '3',
              groupValue: _groupValue,
              id: '3',
              onChanged: _valueChangedHandler(),
              label: 'IRELAND',
              image: 'assets/images/irela.jpg',
            ),
            MyRadioOption<String>(
              value: '4',
              groupValue: _groupValue,
              id: '4',
              onChanged: _valueChangedHandler(),
              label: 'AUSTRALIA',
              image: 'assets/images/austa.jpg',
            ),
          ],
        ),
      ),
    );
  }

  Widget getBody() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Consumer<UserViewModel>(builder: (contextModel, model, child) {
        return model.response == Response.Success &&
                model.pptySearchList != null &&
                model.pptySearchList.isNotEmpty
            ? GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                itemCount: model.pptySearchList.length > 4
                    ? 4
                    : model.pptySearchList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15.0,
                    mainAxisSpacing: 15.0,
                    childAspectRatio: 2 / 3),
                itemBuilder: (ctx, i) {
                  return GestureDetector(
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            model.pptySearchList[i].image != null
                                ? SizedBox(
                                 height: 150,
                                  child: Image.network(
                                      "https://seowebdesign.in/feelathome/site/images/1/"
                                      '${model.pptySearchList[i].image[0]}',
                                      fit: BoxFit.fitWidth),
                                )
                                : SizedBox(
                                height: 150,
                                  child: Image.asset("assets/images/nia.jpg",
                                      fit: BoxFit.fitWidth),
                                ),
                            Padding(
                              padding: const EdgeInsets.all(9.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                      child: Text(
                                    CheckIsNotNull(
                                            model.pptySearchList[i].property_name)
                                        ? model.pptySearchList[i].property_name
                                        : " ",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                    maxLines: 2,
                                  )),
                                  model.pptySearchList[i].price != null
                                      ? SizedBox(
                                          child: Column(children: [
                                          Row(children: [
                                            Text(
                                              "From",
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text(
                                              " "
                                              '${model.pptySearchList[i].currency_code}',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: GreenBottom,
                                              ),
                                            ),
                                            Text(
                                              " "
                                              '${model.pptySearchList[i].price}',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: GreenBottom,
                                              ),
                                            ),
                                          ]),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 25),
                                            child: Row(children: [
                                              Text(
                                                " \/"
                                                '${model.pptySearchList[i].price_per_pr}',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Text(
                                                " \/"
                                                '${model.pptySearchList[i].price_per}',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ]),
                                          ),
                                        ]))
                                      : Container(),
                                  SizedBox(
                                      child: Text(
                                    " ",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CollegedetailsView(
                                id: i,
                                getToolbarname: model
                                        .pptySearchList[i].property_name.isEmpty
                                    ? " "
                                    : model.pptySearchList[i].property_name !=
                                            null
                                        ? model.pptySearchList[i].property_name
                                        : " ",
                                isfromSearach: false,
                              )));
                    },
                  );
                },
              )
            : model.pptySearchList.isEmpty && model.response == Response.Success
                ? Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Center(
                      child: Text("No Data"),
                    ),
                  )
                : LoadingAnimation();
      }),
    );
  }

  Widget _search() {
    return Consumer<UserViewModel>(builder: (contextModel, model, child) {
      return InkWell(
        onTap: () {
          Navigator.of(context).push(
              // MaterialPageRoute(builder: (context) => HomeScreen(1)),
              MaterialPageRoute(
                  builder: (context) => SearchPage(
                        newCountryValue: countryValueId,
                      )));
        },
        child: Container(
          child: Container(
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                //  color: LightColor.lightGrey.withAlpha(100),
                color: LightColor.lightGrey.withAlpha(80),
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 2.0),
                  child: const Icon(Icons.search, color: Colors.grey),
                ),
                Text(
                  "Search",
                  //  style: countryNameTextStyle,
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<void> _startApp() async {
    SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();
    String isLoggedIn = await sharedPreferenceHelper.getisLoggedInVale();
    if (isLoggedIn != null) {
      if (isLoggedIn == "true") {
        setState(() {
          _isVisible = false;
        });
      } else {
        setState(() {
          _isVisible = true;
        });
      }
    } else {
      setState(() {
        _isVisible = true;
      });
    }
  }
}

// @dart=2.9
import 'package:feelathomeproject/Screens/Radio.dart';
import 'package:feelathomeproject/screens/CollegedetailsView.dart';
import 'package:feelathomeproject/screens/popular_property.dart';
import 'package:feelathomeproject/screens/search_popup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../util/light_color.dart';
import '../util/styles.dart';
import '../util/widgets.dart';
import '../view_models/base_view_model.dart';
import '../view_models/user_view_model.dart';
import '../widgets/loading_widget.dart';
import 'home_screen.dart';

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
  String _groupValue;

  ValueChanged<String> _valueChangedHandler() {
    return (value) => setState(() {
          _groupValue = value;
          print(_groupValue);

        });
  }

  @override
  void initState() {
    super.initState();
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
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: Container(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10, top: 50),
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    decoration: new BoxDecoration(color: Colors.white),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: _search(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/banner.jpg"),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyRadioOption<String>(
                            value: '1',
                            groupValue: _groupValue,
                            onChanged: _valueChangedHandler(),
                            label: 'CANADA',
                            image: 'assets/images/ca.png',
                          ),
                          MyRadioOption<String>(
                            value: '2',
                            groupValue: _groupValue,
                            onChanged: _valueChangedHandler(),
                            label: 'UK',
                            image: 'assets/images/gb.png',
                          ),
                          MyRadioOption<String>(
                            value: '3',
                            groupValue: _groupValue,
                            onChanged: _valueChangedHandler(),
                            label: 'IRELAND',
                            image: 'assets/images/ie.png',
                          ),
                          MyRadioOption<String>(
                            value: '4',
                            groupValue: _groupValue,
                            onChanged: _valueChangedHandler(),
                            label: 'AUSTRALIA',
                            image: 'assets/images/au.png',
                          ),
                        ],
                      ),
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
                            Text.rich(
                              TextSpan(
                                  text: "POPULAR",
                                  style: TextStyle(
                                      color: Colors.lightBlue,
                                      fontSize: 15.5,
                                      fontWeight: FontWeight.normal),
                                  children: [
                                    TextSpan(
                                      text: " PROPERTIES",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.5,
                                          fontWeight: FontWeight.normal),
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
            ),
            Expanded(child: getBody()),
          ],
        ),
      ),
    );
  }

  Widget getBody() {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 10),
      child: Consumer<UserViewModel>(builder: (contextModel, model, child) {
        return model.response == Response.Success &&
                model.pptySearchList != null &&
                model.pptySearchList.isNotEmpty
            ? GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                itemCount: model.pptySearchList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15.0,
                    mainAxisSpacing: 15.0,
                    childAspectRatio: 2 / 3),
                itemBuilder: (ctx, i) {
                  return GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(9.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 3),
                              blurRadius: 3.0),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(9.0),
                                  topRight: Radius.circular(9.0),
                                ),
                                color: Color(0xffe5e6ea),
                              ),
                              child: model.pptySearchList[i].image != null
                                  ? Image.network(
                                      "https://seowebdesign.in/feelathome/site/images/1/"
                                      '${model.pptySearchList[i].image}',
                                      fit: BoxFit.fitHeight)
                                  : Image.asset("assets/images/no_image.jpg",
                                      fit: BoxFit.fitHeight),
                            ),
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
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                  maxLines: 2,
                                )),
                                model.pptySearchList[i].price != null
                                    ? SizedBox(
                                        child: Text.rich(
                                          TextSpan(
                                              text: "From",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: " \$"
                                                      '${model.pptySearchList[i].price}',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                    color: GreenBottom,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: "/week",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      )
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
                : Loading();
      }),
    );
  }

  Widget _search() {
    return Consumer<UserViewModel>(builder: (contextModel, model, child) {
      return Container(
        margin: EdgeInsets.only(top: 8.0),
        child: Row(
          children: [
            /*  Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(builder: (context, setState) {
                          return AlertDialog(
                            title: Container(
                              color: Colors.transparent,
                              child: Text(
                                'Pick Country',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  color: Colors.transparent,
                                  height: 300.0,
                                  // Change as per your requirement
                                  width: 300.0,
                                  // Change as per your requirement
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: model.countryList.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10),
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              //background color of dropdown button
                                              border: Border.all(
                                                  color: Colors.black12,
                                                  width: 1),
                                              //border of dropdown button
                                              borderRadius: BorderRadius.circular(
                                                  10), //border raiuds of dropdown button
                                            ),
                                            child: Container(
                                              color: Colors.transparent,
                                              child: ListTile(
                                                leading: Container(
                                                  height: 40,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      fit: BoxFit.scaleDown,
                                                      image: AssetImage(model
                                                          .countryList[index]
                                                          .country_photo),
                                                    ),
                                                  ),
                                                ),
                                                title: Text(model
                                                        .countryList[index]
                                                        ?.cname ??
                                                    ""),
                                              ),
                                            ),
                                          ),
                                        ),
                                        onTap: () async {
                                          model.collageList.clear();
                                          model.campusList.clear();
                                          model.cityList.clear();
                                          await model.getCountryList(
                                              model.countryList[index]?.id ??
                                                  1);
                                          WidgetsBinding.instance.addPostFrameCallback((_) =>
                                              Provider.of<UserViewModel>(context, listen: false)
                                                  .getSearchList(
                                                  null,
                                                  model.countryList[index]?.id ??
                                                      1,
                                                  null,
                                                  null,
                                                  null,
                                                  null,
                                                  null,
                                                  null));
                                          setState(() {
                                            countryValue = index;
                                            countryValueId = model.countryList[index]?.id ?? 1;
                                          });
                                          Navigator.pop(context);
                                        }, //
                                      );
                                    },
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel"),
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                      });
                },
                child: Container(
                  height: 40,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(),
                  child: Row(
                    children: [
                      Container(
                        height: 25,
                        width: 30,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.scaleDown,
                            image: model.countryList != null
                                ? AssetImage(model
                                    .countryList[countryValue].country_photo)
                                : AssetImage("assets/images/ca.png"),
                          ),
                        ),
                      ),
                      const Icon(Icons.arrow_drop_down_rounded),
                    ],
                  ),
                ),
              ),
            ),*/
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      // MaterialPageRoute(builder: (context) => HomeScreen(1)),
                      MaterialPageRoute(
                          builder: (context) => SearchPage(
                                newCountryValue: countryValueId,
                              )));
                },
                child: Container(
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: LightColor.lightGrey.withAlpha(100),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 2.0),
                        child: const Icon(Icons.search, color: Colors.blue),
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
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      );
    });
  }
}

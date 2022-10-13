// @dart=2.9

import 'package:feelathomeproject/screens/filter_search_screen.dart';
import 'package:feelathomeproject/screens/search_popup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/countries_model.dart';
import '../network/shared_preference_helper.dart';
import '../util/light_color.dart';
import '../util/styles.dart';
import '../view_models/base_view_model.dart';
import '../view_models/user_view_model.dart';
import '../widgets/loading_widget.dart';
import 'BottomPopup.dart';
import 'CollegedetailsView.dart';
import 'home_screen.dart';
import 'map_view.dart';

class Tab_searchh extends StatefulWidget {
  //const SplashScreen() : super(key: key);
  int newCollageValue, newCampusValue, newCityValue;

  @override
  _Tab_searchhState createState() => _Tab_searchhState();
}

class _Tab_searchhState extends State<Tab_searchh> {
  List country_data = List();
  int newCountryValue = 1;
  int countryValue = 0;
  String countryid; //default id for the dropdown
  int countryValueId = 1;
  String dropdownValue, dropdownValue1, dropdownValue2;
  String collage = "Collage", campus = "Campus", city = "City";
  SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();
  @override
  void initState() {
    super.initState();
    _startApp();
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Provider.of<UserViewModel>(context, listen: false).getCountryList(1));
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Provider.of<UserViewModel>(context, listen: false).getCollageList(1));
  }

  Future<void> _startApp() async {
    SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();
    String isFromSearchPopup =
        await sharedPreferenceHelper.getsearchPopUpValue();
    if (isFromSearchPopup != null) {
      if (isFromSearchPopup == "true") {
        print("URLLL==");
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) =>
            Provider.of<UserViewModel>(context, listen: false)
                .getSearchList(null, 1, null, null, null, null, null, null));
      }
    } else {}
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
                    height: 120,
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
                        Container(
                          margin: EdgeInsets.only(right: 40.0, top: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FiltersScreen(countryValueId)));
                                },
                                child: Container(
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/filter.png",
                                        height: 15.0,
                                        width: 20.0,
                                        fit: BoxFit.fill,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 2.0),
                                        child: const Text(
                                          "Filter",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 10.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            ListTile(
                                              leading:  new Text('All'),
                                              onTap: () {
                                                WidgetsBinding.instance.addPostFrameCallback((_) =>
                                                    Provider.of<UserViewModel>(context, listen: false)
                                                        .getSearchList(
                                                        null,
                                                        countryValueId,
                                                        null,
                                                        null,
                                                        null,
                                                        null,
                                                        null,
                                                        null));
                                                Navigator.pop(context);
                                              },
                                            ),
                                            ListTile(
                                              leading:  new Text('Low to High'),
                                              onTap: () {
                                                WidgetsBinding.instance.addPostFrameCallback((_) =>
                                                    Provider.of<UserViewModel>(context, listen: false)
                                                        .getSearchList(
                                                        null,
                                                        countryValueId,
                                                        null,
                                                        null,
                                                        null,
                                                        "low",
                                                        null,
                                                        null));
                                                Navigator.pop(context);
                                              },
                                            ),
                                            ListTile(
                                              leading:  new Text('High to Low'),
                                              onTap: () {
                                                WidgetsBinding.instance.addPostFrameCallback((_) =>
                                                    Provider.of<UserViewModel>(context, listen: false)
                                                        .getSearchList(
                                                        null,
                                                        countryValueId,
                                                        null,
                                                        null,
                                                        null,
                                                        "high",
                                                        null,
                                                        null));
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: Container(
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/sort.png",
                                        height: 15.0,
                                        width: 20.0,
                                        fit: BoxFit.fill,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 2.0),
                                        child: const Text(
                                          "Sort",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 10.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(top: 20, left: 10),
                child: const Text.rich(
                  TextSpan(
                      text: "SEARCH",
                      style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 15.5,
                          fontWeight: FontWeight.normal),
                      children: [
                        TextSpan(
                          text: " LISTING",
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
              child: getBody(),
              //  child: CSCPicker(
              //   ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _search() {
    return Container(
      margin: EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(),
            child:
                Consumer<UserViewModel>(builder: (contextModel, model, child) {
              return GestureDetector(
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
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
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
                                          setState(() {
                                            countryValue = index;
                                            countryValueId =
                                                model.countryList[index]?.id ??
                                                    1;
                                          });
                                          Navigator.pop(context);
                                        }, //
                                      );
                                    },
                                  ),

                                  /* ListView.builder(
                                              shrinkWrap: true,
                                              itemCount:
                                                  model.countryList.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return ListTile(
                                                  title: Card(
                                                      child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(model
                                                            .countryList[index]
                                                            ?.cname ??
                                                        ""),
                                                  )),
                                                  onTap: () async {
                                                    newCollageValue = null;
                                                    newCampusValue = null;
                                                    newCityValue = null;
                                                    model.collageList.clear();
                                                    model.campusList.clear();
                                                    model.cityList.clear();
                                                    await model.getCountryList(
                                                        model.countryList[index]
                                                                ?.id ??
                                                            1);
                                                    await model.getSearchList(_searchKeyword, model.countryList[index]
                                                        ?.id ??
                                                        1, newCollageValue, newCityValue, newCampusValue, null, null, null);
                                                    setState(() {
                                                      countryValue = index;
                                                      newCountryValue = model
                                                          .countryList[index]
                                                          .id;
                                                    });
                                                    Navigator.pop(context);
                                                  }, //
                                                );
                                              },
                                            ),*/
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
              );
            }),
          ),
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
  }

  /*Widget _search() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Container(
        child: Consumer<UserViewModel>(builder: (contextModel, model, child) {
          return model.response == Response.Success &&
                  model.countryList != null &&
                  model.countryList.isNotEmpty
              ? Column(
                  children: [
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(
                                      builder: (context, setState) {
                                    return AlertDialog(
                                      title: Container(
                                        color: Colors.transparent,
                                        child: Text(
                                          'Pick Country',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15),
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
                                            child: Expanded(
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount:
                                                    model.countryList.length,
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 10),
                                                      child: DecoratedBox(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          //background color of dropdown button
                                                          border: Border.all(
                                                              color: Colors
                                                                  .black12,
                                                              width: 1),
                                                          //border of dropdown button
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10), //border raiuds of dropdown button
                                                        ),
                                                        child: Container(
                                                          color: Colors
                                                              .transparent,
                                                          child: ListTile(
                                                            leading: Container(
                                                              height: 40,
                                                              width: 30,
                                                              decoration:
                                                                  BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                                  fit: BoxFit
                                                                      .scaleDown,
                                                                  image: AssetImage(model
                                                                      .countryList[
                                                                          index]
                                                                      .country_photo),
                                                                ),
                                                              ),
                                                            ),
                                                            title: Text(model
                                                                    .countryList[
                                                                        index]
                                                                    ?.cname ??
                                                                ""),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    onTap: () async {
                                                      widget.newCollageValue = null;
                                                      widget.newCampusValue = null;
                                                      widget.newCityValue = null;
                                                      model.collageList.clear();
                                                      model.campusList.clear();
                                                      model.cityList.clear();
                                                      await model
                                                          .getCountryList(model
                                                                  .countryList[
                                                                      index]
                                                                  ?.id ??
                                                              1);
                                                      setState(() {
                                                        countryValue = index;
                                                        newCountryValue = model
                                                            .countryList[index]
                                                            .id;
                                                      });
                                                      Navigator.pop(context);
                                                    }, //
                                                  );
                                                },
                                              ),
                                            ),

                                            /* ListView.builder(
                                              shrinkWrap: true,
                                              itemCount:
                                                  model.countryList.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return ListTile(
                                                  title: Card(
                                                      child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(model
                                                            .countryList[index]
                                                            ?.cname ??
                                                        ""),
                                                  )),
                                                  onTap: () async {
                                                    newCollageValue = null;
                                                    newCampusValue = null;
                                                    newCityValue = null;
                                                    model.collageList.clear();
                                                    model.campusList.clear();
                                                    model.cityList.clear();
                                                    await model.getCountryList(
                                                        model.countryList[index]
                                                                ?.id ??
                                                            1);
                                                    await model.getSearchList(_searchKeyword, model.countryList[index]
                                                        ?.id ??
                                                        1, newCollageValue, newCityValue, newCampusValue, null, null, null);
                                                    setState(() {
                                                      countryValue = index;
                                                      newCountryValue = model
                                                          .countryList[index]
                                                          .id;
                                                    });
                                                    Navigator.pop(context);
                                                  }, //
                                                );
                                              },
                                            ),*/
                                          ),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: FlatButton(
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(),
                            child: Row(
                              children: [
                                Container(
                                  height: 25,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.scaleDown,
                                      image: model.countryList[countryValue]
                                                  .country_photo !=
                                              null
                                          ? NetworkImage(
                                              "https://seowebdesign.in/feelathome/site/public/country/rectangle-"
                                              '${model.countryList[countryValue].country_photo}')
                                          : AssetImage(
                                              "assets/images/no_image.jpg"),
                                    ),
                                  ),
                                ),
                                const Icon(Icons.arrow_drop_down_rounded),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: LightColor.lightGrey.withAlpha(100),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Row(
                              children: [
                                Container(
                                  width: 100,
                                  child: TextField(
                                    textInputAction: TextInputAction.search,
                                    onSubmitted: (value) async {},
                                    onChanged: (value) {},
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Search",
                                        hintStyle: TextStyle(fontSize: 12),
                                        contentPadding: EdgeInsets.only(
                                            left: 1,
                                            right: 1,
                                            bottom: 0,
                                            top: 5),
                                        prefixIcon: Icon(Icons.search,
                                            color: Colors.blue)),
                                  ),
                                ),
                                Flexible(
                                  fit: FlexFit.tight,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(
                                              "Select Collage",
                                              style: TextStyle(
                                                fontSize: 13.0,
                                              ),
                                            ),
                                            onChanged: (int changedValue) {
                                              widget.newCollageValue =
                                                  changedValue;
                                              setState(() {
                                                widget.newCollageValue;
                                                print(widget.newCollageValue);
                                              });
                                            },
                                            value: widget.newCollageValue,
                                            items: model.collageList
                                                .map((CollegeData) {
                                              return DropdownMenuItem(
                                                child: Text(
                                                  CollegeData.college_name,
                                                  style: TextStyle(
                                                    fontSize: 13.0,
                                                  ),
                                                ),
                                                value: CollegeData.id,
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        new DropdownButtonHideUnderline(
                                          child: new DropdownButton(
                                            hint: Text(
                                              "Select Campus",
                                              style: TextStyle(
                                                fontSize: 13.0,
                                              ),
                                            ),
                                            onChanged: (int changedValue) {
                                              widget.newCampusValue =
                                                  changedValue;
                                              setState(() {
                                                widget.newCampusValue;
                                                print(widget.newCampusValue);
                                              });
                                            },
                                            value: widget.newCampusValue,
                                            items: model.campusList
                                                .map((CampusData) {
                                              return DropdownMenuItem(
                                                child: Text(
                                                  CampusData.campus_name,
                                                  style: TextStyle(
                                                    fontSize: 13.0,
                                                  ),
                                                ),
                                                value: CampusData.id,
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        new DropdownButtonHideUnderline(
                                          child: new DropdownButton(
                                            hint: Text(
                                              "Select City",
                                              style: TextStyle(
                                                fontSize: 13.0,
                                              ),
                                            ),
                                            onChanged: (int changedValue) {
                                              widget.newCityValue =
                                                  changedValue;
                                              setState(() {
                                                widget.newCityValue;
                                                print(widget.newCityValue);
                                              });
                                            },
                                            value: widget.newCityValue,
                                            items:
                                                model.cityList.map((CityData) {
                                              return DropdownMenuItem(
                                                child: Text(
                                                  CityData.province_name,
                                                  style: TextStyle(
                                                    fontSize: 13.0,
                                                  ),
                                                ),
                                                value: CityData.id,
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ],
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
                )
              : Container();
        }),
      ),
    );
  }*/

  Widget getBody() {
    return Container(
      child: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(
            Duration(seconds: 1),
            () {
              setState(() {
                WidgetsBinding.instance.addPostFrameCallback((_) =>
                    Provider.of<UserViewModel>(context, listen: false)
                        .getSearchList(
                            null, 1, null, null, null, null, null, null));
              });
            },
          );
        },
        child: Consumer<UserViewModel>(builder: (contextModel, model, child) {
          return model.response == Response.Success &&
                  model.pptySearchList != null &&
                  model.pptySearchList.isNotEmpty
              ? new ListView.builder(
                  itemCount: model.pptySearchList.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (BuildContext ctxt, int Index) {
                    return GestureDetector(
                      child: Card(
                        elevation: 4,
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 120,
                                  child: model.pptySearchList[Index].image !=
                                          null
                                      ? Image.network(
                                          "https://seowebdesign.in/feelathome/site/images/1/"
                                          '${model.pptySearchList[Index].image}',
                                          fit: BoxFit.fitHeight)
                                      : Image.asset(
                                          "assets/images/no_image.jpg",
                                          fit: BoxFit.fitHeight),
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  model.pptySearchList[Index]
                                                          ?.property_name ??
                                                      "",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                  ),
                                                  maxLines: 2,
                                                ),

                                                model.pptySearchList[Index].price != null
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
                                                                '${model.pptySearchList[Index].price}',
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
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          map_view()));
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Image.asset(
                                                "assets/images/smallmap.png",
                                                height: 30.0,
                                                width: 30.0,
                                                fit: BoxFit.scaleDown,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Image.asset(
                                                  "assets/images/bed.png",
                                                  height: 15.0,
                                                  width: 20.0,
                                                  fit: BoxFit.scaleDown,
                                                ),
                                                Text(
                                                    model.pptySearchList[Index]
                                                                ?.bed !=
                                                            null
                                                        ? model
                                                                .pptySearchList[
                                                                    Index]
                                                                ?.bed ??
                                                            0
                                                        : "0",
                                                    style: new TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10.0,
                                                        fontWeight:
                                                            FontWeight.normal)),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Image.asset(
                                                  "assets/images/hall.png",
                                                  height: 15.0,
                                                  width: 20.0,
                                                  fit: BoxFit.scaleDown,
                                                ),
                                                Text(
                                                    model.pptySearchList[Index]
                                                                ?.living !=
                                                            null
                                                        ? model
                                                                .pptySearchList[
                                                                    Index]
                                                                ?.living ??
                                                            0
                                                        : "0",
                                                    style: new TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10.0,
                                                        fontWeight:
                                                            FontWeight.normal)),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Image.asset(
                                                  "assets/images/bathroom.png",
                                                  height: 15.0,
                                                  width: 20.0,
                                                  fit: BoxFit.scaleDown,
                                                ),
                                                Text(
                                                    model.pptySearchList[Index]
                                                                ?.shower !=
                                                            null
                                                        ? model
                                                                .pptySearchList[
                                                                    Index]
                                                                ?.shower ??
                                                            0
                                                        : "0",
                                                    style: new TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10.0,
                                                        fontWeight:
                                                            FontWeight.normal)),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Image.asset(
                                                  "assets/images/kitchen.png",
                                                  height: 15.0,
                                                  width: 20.0,
                                                  fit: BoxFit.scaleDown,
                                                ),
                                                Text(
                                                    model.pptySearchList[Index]
                                                                ?.kitchen !=
                                                            null
                                                        ? model
                                                                .pptySearchList[
                                                                    Index]
                                                                ?.kitchen ??
                                                            0
                                                        : "0",
                                                    style: new TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10.0,
                                                        fontWeight:
                                                            FontWeight.normal)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        model.pptySearchList[Index]
                                                ?.description ??
                                            "",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CollegedetailsView(
                                  id: Index,
                                  getToolbarname: model.pptySearchList[Index]
                                          .property_name.isEmpty
                                      ? " "
                                      : model.pptySearchList[Index]
                                                  .property_name !=
                                              null
                                          ? model
                                              .pptySearchList[Index].property_name
                                          : " ",
                                  isfromSearach: true,
                                )));
                      },
                    );
                  })
              : model.pptySearchList.isEmpty &&
                      model.response == Response.Success
                  ? ListView(
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Center(
                            child: Text("No Data"),
                          ),
                        ),
                      ],
                      padding: EdgeInsets.all(10),
                    )
                  : Loading();
        }),
      ),
    );
  }
}

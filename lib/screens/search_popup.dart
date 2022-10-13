// @dart=2.9

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../network/shared_preference_helper.dart';
import '../view_models/user_view_model.dart';
import '../widgets/OpenFlutterButton.dart';
import 'home_screen.dart';


class SearchPage extends StatefulWidget {
  //const SplashScreen() : super(key: key);
  int newCountryValue;

  SearchPage({this.newCountryValue});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();
  TextEditingController _searchQueryController;
  String _searchKeyword;
  int newCollageValue, newCampusValue, newCityValue;

  @override
  Widget build(BuildContext context) {
    final widthMax = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.green.shade50,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          width: widthMax * .8,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            color: Color.fromRGBO(142, 142, 147, .15),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Theme(
                              child: TextField(
                                autofocus: true,
                                textInputAction: TextInputAction.search,
                                onChanged: (value) {
                                  _searchKeyword = value;
                                },
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Search",
                                    hintStyle: TextStyle(fontSize: 12),
                                    prefixIcon:
                                        Icon(Icons.search, color: Colors.blue)),
                              ),
                              data: Theme.of(context).copyWith(
                                primaryColor: Colors.black12,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        child: AnimatedOpacity(
                          opacity: 1.0,
                          curve: Curves.easeIn,
                          duration: Duration(milliseconds: 0),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            width: MediaQuery.of(context).size.width * .2,
                            child: Container(
                              color: Colors.transparent,
                              child: Center(
                                child: Text("Cancel"),
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Container(),
            ),
            Expanded(child:
                Consumer<UserViewModel>(builder: (contextModel, model, child) {
              return Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        //background color of dropdown button
                        border: Border.all(color: Colors.black12, width: 1),
                        //border of dropdown button
                        borderRadius: BorderRadius.circular(
                            10), //border raiuds of dropdown button
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 30, right: 30),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            isExpanded: true,
                            hint: const Text(
                              "Select Collage",
                              style: TextStyle(
                                fontSize: 13.0,
                              ),
                            ),
                            onChanged: (int changedValue) {
                              newCollageValue = changedValue;
                              setState(() {
                                newCollageValue;
                                print(newCollageValue);
                              });
                            },
                            value: newCollageValue,
                            items: model.collageList.map((CollegeData) {
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
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          //background color of dropdown button
                          border: Border.all(color: Colors.black12, width: 1),
                          //border of dropdown button
                          borderRadius: BorderRadius.circular(
                              10), //border raiuds of dropdown button
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          child: new DropdownButtonHideUnderline(
                            child: new DropdownButton(
                              isExpanded: true,
                              hint: Text(
                                "Select Campus",
                                style: TextStyle(
                                  fontSize: 13.0,
                                ),
                              ),
                              onChanged: (int changedValue) {
                                newCampusValue = changedValue;
                                setState(() {
                                  newCampusValue;
                                  print(newCampusValue);
                                });
                              },
                              value: newCampusValue,
                              items: model.campusList.map((CampusData) {
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
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          //background color of dropdown button
                          border: Border.all(color: Colors.black12, width: 1),
                          //border of dropdown button
                          borderRadius: BorderRadius.circular(
                              10), //border raiuds of dropdown button
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          child: new DropdownButtonHideUnderline(
                            child: new DropdownButton(
                              isExpanded: true,
                              hint: Text(
                                "Select City",
                                style: TextStyle(
                                  fontSize: 13.0,
                                ),
                              ),
                              onChanged: (int changedValue) {
                                newCityValue = changedValue;
                                setState(() {
                                  newCityValue;
                                  print(newCityValue);
                                });
                              },
                              value: newCityValue,
                              items: model.cityList.map((CityData) {
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
                        ),
                      ),
                    ),
                  ],
                ),
              );
            })),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: OpenFlutterButton(
                title: 'Discard',
                onPressed: () {
                  Navigator.of(context).pop();
                },
                backgroundColor: Colors.white,
                borderColor: Colors.black,
                textColor: Colors.black,
              ),
            ),
            Expanded(
              child: OpenFlutterButton(
                title: 'Apply',
                backgroundColor: Colors.white,
                borderColor: Colors.black,
                textColor: Colors.black,
                onPressed: () async {
                  sharedPreferenceHelper.searchPopUpValue("true");
                  WidgetsBinding.instance.addPostFrameCallback((_) =>
                      Provider.of<UserViewModel>(context, listen: false)
                          .getSearchList(
                              _searchKeyword,
                              widget.newCountryValue,
                              newCollageValue,
                              newCityValue,
                              newCampusValue,
                              null,
                              null,
                              null));
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomeScreen(1)));
                },
                //onPressed: GoSearch(context,newCollageValue,newCityValue,newCampusValue,_searchKeyword),
              ),
            )
          ],
        ),
      ),
    );
  }
}

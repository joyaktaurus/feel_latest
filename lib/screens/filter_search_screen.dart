// @dart=2.9

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../network/shared_preference_helper.dart';
import '../view_models/user_view_model.dart';
import '../widgets/OpenFlutterButton.dart';
import 'home_screen.dart';


class FiltersScreen extends StatefulWidget {

  int newCountryValue;
  String sort;

  FiltersScreen(this.newCountryValue,this.sort);
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();
  String dropdownValue = 'All';
  String dropdownValue1 = 'All';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.grey,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Filter",
          style: TextStyle(
              color: Colors.black,
              fontSize: 15.5,
              fontWeight: FontWeight.normal),
        ),
        centerTitle: false,
        backgroundColor: Colors.green.shade50,
       // backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 10,left: 10, right: 10),
                child: FilterLabelLiving),
          ]  +[
            Container(
              margin: EdgeInsets.only(top: 5,left: 10, right: 10),
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
                  child: DropdownButtonHideUnderline(
                    child:DropdownButton<String>(
                      isExpanded: true,
                      value: dropdownValue,
                      // Step 4.
                      items: <String>['All', '1', '2', '3','4','5','6','7','8','9','10']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(fontSize: 15),
                          ),
                        );
                      }).toList(),
                      // Step 5.
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          ]+[
            Container(
                margin: EdgeInsets.only(top: 15,left: 10, right: 10),
                child: FilterLabelKitch),
          ]  +
              [
                Container(
                  margin: EdgeInsets.only(top: 5,left: 10, right: 10),
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
                      child: DropdownButtonHideUnderline(
                        child:DropdownButton<String>(
                          isExpanded: true,
                          // Step 3.
                          value: dropdownValue1,
                          // Step 4.
                          items: <String>['All', 'yes', 'no']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(fontSize: 15),
                              ),
                            );
                          }).toList(),
                          // Step 5.
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue1 = newValue;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
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
                  String TempdropdownValue1;
                  String TempdropdownValue2;
                  print(dropdownValue);
                  print(dropdownValue1);
                  if(dropdownValue1=='All'){
                    TempdropdownValue1=null;
                  }else{
                    TempdropdownValue1=dropdownValue1;
                  }
                  if(dropdownValue=='All'){
                    TempdropdownValue2=null;
                  }else{
                    TempdropdownValue2=dropdownValue;
                  }
                  sharedPreferenceHelper.searchPopUpValue("true");
                  WidgetsBinding.instance.addPostFrameCallback((_) =>
                      Provider.of<UserViewModel>(context, listen: false).getSearchList(
                          null,
                          widget.newCountryValue,
                          null,
                          null,
                          null,
                          widget.sort,
                          TempdropdownValue1,
                          TempdropdownValue2));
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
  final FilterLabelLiving = Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 1),
        child: Text("Living Rooms",
            style: TextStyle(
                fontFamily: 'Roboto', color: Colors.black, fontSize: 15)),
      ),
    ],
  );
  final FilterLabelKitch= Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 1),
        child: Text("Kitchen",
            style: TextStyle(
                fontFamily: 'Roboto', color: Colors.black, fontSize: 15)),
      ),
    ],
  );
}


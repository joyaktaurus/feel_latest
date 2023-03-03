// @dart=2.9
import 'package:carousel_slider/carousel_slider.dart';
import 'package:feelathomeproject/model/collage_model.dart';
import 'package:feelathomeproject/model/propertyListingModel.dart';
import 'package:feelathomeproject/util/customform.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../util/styles.dart';
import '../util/widgets.dart';
import '../view_models/base_view_model.dart';
import '../view_models/user_view_model.dart';
import 'MapPage.dart';
import 'map_view.dart';

class CollegedetailsView extends StatefulWidget {
  int id;
  bool isfromSearach = false;
  String getToolbarname = " ";
  bool dropuniv = false;

  CollegedetailsView({this.id, this.getToolbarname, this.isfromSearach});

  @override
  _CollegedetailsViewState createState() => _CollegedetailsViewState();
}

class _CollegedetailsViewState extends State<CollegedetailsView> {
  static String _username,
      _phone,
      _email,
      _noppl,
      _message,
      _city,
      _university,
      _campus,
      _intake,
      _date,
      _u_other,
      _c_other,
      _travel_date;
  final formKey = new GlobalKey<FormState>();
  UserViewModel _userViewModel;
  String itemName;
  String location;
  String catName;
  int currentPos = 0;

  @override
  void initState() {
    super.initState();
    _userViewModel = Provider.of<UserViewModel>(context, listen: false);
  }

  String university_id = "Select University";

  String campus_id = "Select Campus";

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  bool _isVisible = false;
  static String _summary,_comp_title=" ";
  ///////////////////////////

  // List<String> complaint_type_dropdownValue = [
  //   'Select issue type',
  //   'Other'
  // ];

  // List<String> complaint_type = [
  //   'Select issue type',
  //   'Other'
  // ];

  /////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.grey,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            widget.getToolbarname,
            style: TextStyle(
                color: Colors.black,
                fontSize: 15.5,
                fontWeight: FontWeight.normal),
          ),
          centerTitle: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.green.shade50,
        body: Container(
          child: SingleChildScrollView(
            // shrinkWrap: true,
            child: Container(
                child: Form(
              key: formKey,
              child: Consumer<UserViewModel>(
                  builder: (contextModel, model, child) {
                if (model.response == Response.Success &&
                    model.pptySearchList != null &&
                    model.pptySearchList.isNotEmpty) {
                  return Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            CarouselSlider.builder(
                              itemCount: model.pptySearchList[widget.id].image
                                          ?.length !=
                                      null
                                  ? model.pptySearchList[widget.id].image.length
                                  : 1,
                              options: CarouselOptions(
                                  autoPlay: false,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      var currentPos = index;
                                    });
                                  }),
                              itemBuilder:
                                  (BuildContext context, int index, _) {
                                return MyImageView(model
                                            .pptySearchList[widget.id]
                                            .image
                                            ?.length !=
                                        null
                                    ? model.pptySearchList[widget.id]
                                                    .image[index] !=
                                                null ||
                                            model.pptySearchList[widget.id]
                                                    .image[index] !=
                                                "null"
                                        ? model.pptySearchList[widget.id]
                                            .image[index]
                                        : null
                                    : null);
                              },
                            ),
                          ],
                        ),
                      ),
                      getBody(),
                    ],
                  );
                } else {
                  return model.pptySearchList.isNotEmpty &&
                          model.response == Response.Success
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Center(
                            child: Text("No Data"),
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Center(
                            child: Text("No Data"),
                          ),
                        );
                }
              }),
            )),
          ),
        ));
  }

  Widget getBody() {
    return Container(
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        child: Consumer<UserViewModel>(builder: (contextModel, model, child) {
          return model.response == Response.Success &&
                  model.pptySearchList != null &&
                  model.pptySearchList.isNotEmpty
              ? Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Column(
                              children: <Widget>[
                                Row(
                                  children: [
                                    Text(
                                      model.pptySearchList[widget.id]
                                          .property_name,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        model.pptySearchList[widget.id].lat !=
                                                    null &&
                                                model.pptySearchList[widget.id]
                                                        .lng !=
                                                    null
                                            ? Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        // HomePage(num.tryParse(model.pptySearchList[widget.id]
                                                        //     .lat)?.toDouble(),num.tryParse(model.pptySearchList[widget.id]
                                                        //     .lng)?.toDouble())))
                                                        MapPage(
                                                            num.tryParse(model
                                                                    .pptySearchList[
                                                                        widget
                                                                            .id]
                                                                    .lat)
                                                                ?.toDouble(),
                                                            num.tryParse(model
                                                                    .pptySearchList[
                                                                        widget
                                                                            .id]
                                                                    .lng)
                                                                ?.toDouble())))
                                            : showToast(
                                                'Location Not Available',
                                                color: Colors.red);
                                      },
                                      child: Image.asset(
                                        "assets/images/smallmap.png",
                                        height: 30.0,
                                        width: 30.0,
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(children: [
                                    Row(children: [
                                      Text(
                                        "From",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        " "
                                        '${model.pptySearchList[widget.id].currency_code}',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: GreenBottom,
                                        ),
                                      ),
                                      Text(
                                        " "
                                        '${model.pptySearchList[widget.id].price}',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: GreenBottom,
                                        ),
                                      ),
                                    ]),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 25),
                                      child: Row(children: [
                                        Text(
                                          " \/"
                                          '${model.pptySearchList[widget.id].price_per_pr}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          " \/"
                                          '${model.pptySearchList[widget.id].price_per}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ]),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    model.pptySearchList[widget.id]
                                                .description !=
                                            null
                                        ? model.pptySearchList[widget.id]
                                            .description
                                        : " ",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: GreenBottom,
                        padding: EdgeInsets.all(20),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/images/bed.png",
                                    height: 15.0,
                                    width: 20.0,
                                    color: Colors.white,
                                    fit: BoxFit.scaleDown,
                                  ),
                                  Text("Bed Rooms",
                                      style: new TextStyle(
                                          color: Colors.white,
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.normal)),
                                  Text(
                                      model.pptySearchList[widget.id].bed !=
                                              null
                                          ? model.pptySearchList[widget.id].bed
                                          : "0",
                                      style: new TextStyle(
                                          color: Colors.white,
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.normal)),
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/images/hall.png",
                                    height: 15.0,
                                    width: 20.0,
                                    color: Colors.white,
                                    fit: BoxFit.scaleDown,
                                  ),
                                  Text("living Rooms",
                                      style: new TextStyle(
                                          color: Colors.white,
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.normal)),
                                  Text(
                                      model.pptySearchList[widget.id].living !=
                                              null
                                          ? model
                                              .pptySearchList[widget.id].living
                                          : "0",
                                      style: new TextStyle(
                                          color: Colors.white,
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.normal)),
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/images/bathroom.png",
                                    height: 15.0,
                                    width: 20.0,
                                    color: Colors.white,
                                    fit: BoxFit.scaleDown,
                                  ),
                                  Text("Full Washrooms",
                                      style: new TextStyle(
                                          color: Colors.white,
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.normal)),
                                  Text(
                                      model.pptySearchList[widget.id].shower !=
                                              null
                                          ? model
                                              .pptySearchList[widget.id].shower
                                          : "0",
                                      style: new TextStyle(
                                          color: Colors.white,
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.normal)),
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/images/bathroom.png",
                                    height: 15.0,
                                    width: 20.0,
                                    color: Colors.white,
                                    fit: BoxFit.scaleDown,
                                  ),
                                  Text("Half Washrooms",
                                      style: new TextStyle(
                                          color: Colors.white,
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.normal)),
                                  Text(
                                      model.pptySearchList[widget.id]
                                                  .shower_half !=
                                              null
                                          ? model.pptySearchList[widget.id]
                                              .shower_half
                                          : "0",
                                      style: new TextStyle(
                                          color: Colors.white,
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.normal)),
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/images/kitchen.png",
                                    height: 15.0,
                                    width: 20.0,
                                    color: Colors.white,
                                    fit: BoxFit.scaleDown,
                                  ),
                                  Text("Kitchen",
                                      style: new TextStyle(
                                          color: Colors.white,
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.normal)),
                                  Text(
                                      model.pptySearchList[widget.id].kitchen !=
                                              null
                                          ? model
                                              .pptySearchList[widget.id].kitchen
                                          : "No",
                                      style: new TextStyle(
                                          color: Colors.white,
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.normal)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: colorAccent,
                        padding: EdgeInsets.all(20),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/furnished.png",
                                        height: 15.0,
                                        width: 20.0,
                                        color: Colors.white,
                                        fit: BoxFit.scaleDown,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 5.0),
                                        child: Text("Fully furnished ",
                                            style: new TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0,
                                                fontWeight: FontWeight.normal)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/laundary.png",
                                        height: 15.0,
                                        width: 20.0,
                                        color: Colors.white,
                                        fit: BoxFit.scaleDown,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 5.0),
                                        child: Text("Communal laundry",
                                            style: new TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0,
                                                fontWeight: FontWeight.normal)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/car.png",
                                        height: 15.0,
                                        width: 20.0,
                                        color: Colors.white,
                                        fit: BoxFit.scaleDown,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 5.0),
                                        child: Text("Car Parking",
                                            style: new TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0,
                                                fontWeight: FontWeight.normal)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/no_smoke.png",
                                        height: 15.0,
                                        width: 20.0,
                                        color: Colors.white,
                                        fit: BoxFit.scaleDown,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 5.0),
                                        child: Text("No Smoking",
                                            style: new TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0,
                                                fontWeight: FontWeight.normal)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/tv.png",
                                        height: 15.0,
                                        width: 20.0,
                                        color: Colors.white,
                                        fit: BoxFit.scaleDown,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 5.0),
                                        child: Text("Entertainment Room",
                                            style: new TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0,
                                                fontWeight: FontWeight.normal)),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: SizedBox(
                                      width: 45,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 5),
                          width: 350,
                          padding: new EdgeInsets.all(5.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Colors.white,
                            elevation: 10,
                            child: Column(
                              children: [
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, top: 20, bottom: 10),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text.rich(
                                        TextSpan(
                                            text: "QUICK",
                                            style: TextStyle(
                                                color: Colors.lightBlue,
                                                fontSize: 18.5,
                                                fontWeight: FontWeight.normal),
                                            children: [
                                              TextSpan(
                                                text: " ENQUIRY",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18.5,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16.0, right: 8.0, left: 8.0),
                                    child: NameField),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16.0, right: 8.0, left: 8.0),
                                    child: PhoneField),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16.0, right: 8.0, left: 8.0),
                                    child: MailField),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16.0, right: 8.0, left: 8.0),
                                    child: CityField),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16.0, right: 8.0, left: 8.0),
                                    child: NopplField),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16.0, right: 8.0, left: 8.0),
                                    child: UnivList()),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16.0, right: 8.0, left: 8.0),
                                  child: Visibility(
                                    visible: _isVisible,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        height: 50,
                                        width: 400,
                                        color: LightGrey,
                                        child: TextFormField(

                                          keyboardType: TextInputType.name,
                                          onSaved: (value) => _comp_title = value,
                                          onChanged: (value) {
                                            _comp_title = value;
                                          },
                                          decoration: InputDecoration(border: InputBorder.none,
                                            labelText: '  Type Other University',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16.0, right: 8.0, left: 8.0),
                                    child: CamList()),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16.0, right: 8.0, left: 8.0),
                                  child: Visibility(
                                    visible: _isVisible,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        height: 50,
                                        width: 400,
                                        color: LightGrey,
                                        child: TextFormField(

                                          keyboardType: TextInputType.name,
                                          onSaved: (value) => _summary = value,
                                          onChanged: (value) {
                                            _summary = value;
                                          },
                                          decoration: InputDecoration(border: InputBorder.none,
                                            labelText: '  Type Other Campus',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16.0, right: 8.0, left: 8.0),
                                    child: Intake),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16.0, right: 8.0, left: 8.0),
                                    child: DatePick()),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16.0, right: 8.0, left: 8.0),
                                  child: MesssageBox(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 40.0,
                                      left: 40.0,
                                      top: 10.0,
                                      bottom: 10),
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 10.0),
                                    padding: const EdgeInsets.only(
                                        left: 50.0, right: 50.0),
                                    child: new Row(
                                      children: <Widget>[
                                        new Expanded(
                                          child: TextButton(
                                            style: ButtonStyle(
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(10.0))),
                                              overlayColor:
                                                  MaterialStateProperty.all(
                                                      GreenHi),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      GreenBottom),
                                            ),
                                            child: new Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                new Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5.0,
                                                          bottom: 5.0),
                                                  child: Text("SUBMIT",
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.white,
                                                          fontSize: 20)),
                                                ),
                                              ],
                                            ),
                                            onPressed: () async {
                                              if (formKey.currentState
                                                  .validate()) {
                                                var res = false;
                                                res = await _userViewModel.PostEnquiry(
                                                    model
                                                                .pptySearchList[
                                                                    widget.id]
                                                                .id !=
                                                            null
                                                        ? num.tryParse(model
                                                                .pptySearchList[
                                                                    widget.id]
                                                                .id)
                                                            ?.toInt()
                                                        : 1,
                                                    _username,
                                                    _phone,
                                                    _email,
                                                    _message,
                                                    _city,
                                                    _noppl,
                                                    _university,
                                                    _campus,
                                                    _intake,
                                                    _date,
                                                    _u_other,
                                                    _c_other,
                                                    _travel_date);
                                                if (res) {
                                                  formKey.currentState.reset();
                                                }
                                              }
                                            },
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
                      ),
                    ],
                  ),
                )
              : model.pptySearchList.isNotEmpty &&
                      model.response == Response.Success
                  ? Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Center(
                        child: Text("No Data"),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Center(
                        child: Text("No Data"),
                      ),
                    );
        }));
  }
  Widget UnivList() {
    return Consumer<UserViewModel>(builder: (contextModel, model, child) {
      if(model.collageList.first.college_name!='Select university'){
        model.collageList.insert(
            0, CollegeData(college_name: 'Select university'));
        model.collageList.insert(1, CollegeData(college_name: 'other'));}
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: LightGrey,
          child: DropdownButtonHideUnderline(
            child: Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: new DropdownButton<String>(
                isExpanded: true,
                hint: Text(
                  university_id,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                onChanged: (String change) {
                  //  university_id = change;
                  setState(() {
                    university_id = change;
                    university_id;
                    if (change == "other") {
                      setState(() {
                        _isVisible = true;
                      });
                    } else {
                      setState(() {
                        _isVisible = false;
                      });
                    }
                    print(university_id);
                    print(model.collageList.length);
                  });
                },
                items: model.collageList.map((CustomerProperties) {
                  return DropdownMenuItem<String>(
                    child: Text(
                      CustomerProperties.college_name,
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    value: CustomerProperties.college_name,
                  );
                }).toList(),
                value: model.collageList.length == null ? university_id : null,
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget DatePick() {
    return GestureDetector(
        onTap: () => _selectDate(context),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: LightGrey),
          width: 400,
          height: 50,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Icon(
                Icons.calendar_month_outlined,
                color: Colors.grey,
              ),
              SizedBox(width: 10),
              Text(
                "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}",
                style: TextStyle(color: Colors.black54, fontSize: 16),
              ),
            ]),
          ),
        ));
  }

  final date = TextFormField(
    autofocus: false,
    //validator: validateEmail,
    onSaved: (value) => _date = value,
    onChanged: (value) {
      _date = value;
    },
    validator: (value) {
      if (value.isEmpty) {
        return "Enter Date";
      } else {
        return null;
      }
    },
    //decoration: buildInputDecoration("Username", Icons.email),
    decoration:
        buildInputDecorationDetails("Date", Icons.calendar_month_outlined),
  );

  Widget CamList() {
    return Consumer<UserViewModel>(builder: (contextModel, model, child) {
      if(model.campusList.first.campus_name!='Select university'){
        model.campusList.insert(
            0, CampusData(campus_name: 'Select university'));
        model.campusList.insert(1, CampusData(campus_name: 'other'));}
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: LightGrey,
          child: DropdownButtonHideUnderline(
            child: Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: new DropdownButton<String>(
                isExpanded: true,
                hint: Text(
                  campus_id,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),

                onChanged: (String change) {
                  campus_id = change;
                  setState(() {
                    campus_id = change;
                    campus_id;
                    if (change == "other") {
                      setState(() {
                        _isVisible = true;
                      });
                    } else {
                      setState(() {
                        _isVisible = false;
                      });
                    }
                    print(campus_id);
                    print(model.campusList.length);
                  });
                },
                //value: customerproperty_id,
                items: model.campusList.map((CustomerProperties) {
                  return DropdownMenuItem<String>(
                    child: Text(
                      CustomerProperties.campus_name,
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    value: CustomerProperties.campus_name,
                  );
                }).toList(),
                value: model.campusList.length == null ? campus_id : null,
              ),
            ),
          ),
        ),
      );
    });
  }

  //
  Widget MesssageBox() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFormField(
          minLines: 2,
          maxLines: 5,
          keyboardType: TextInputType.multiline,
          onSaved: (value) => _message = value,
          onChanged: (value) {
            _message = value;
          },
          validator: (value) {
            if (value.isEmpty) {
              return "Enter Message";
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: LightGrey,
            prefixIcon: Icon(Icons.message, color: Colors.grey),
            labelText: 'Enter A Message Here',
            hintStyle: TextStyle(color: Colors.grey),
            enabledBorder: myinputborder(),
            focusedBorder: myfocusborder(),
            border: OutlineInputBorder(
                //Outline border type for TextFeild
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(
                  color: Colors.redAccent,
                  width: 1,
                )),
          ),
        ),
      ],
    );
  }

  final NameField = TextFormField(
    autofocus: false,
    //validator: validateEmail,
    onSaved: (value) => _username = value,
    onChanged: (value) {
      _username = value;
    },
    validator: (value) {
      if (value.length < 3) {
        return "Invalid Name";
      } else {
        return null;
      }
    },
    //decoration: buildInputDecoration("Username", Icons.email),
    decoration: buildInputDecorationDetails("Name", Icons.person),
  );
  final PhoneField = TextFormField(
    autofocus: false,
    //validator: validateEmail,
    onSaved: (value) => _phone = value,
    onChanged: (value) {
      _phone = value;
    },
    validator: (value) {
      if (value.isEmpty) {
        return "Invalid phone number";
      } else {
        return null;
      }
    },
    //decoration: buildInputDecoration("Username", Icons.email),
    decoration: buildInputDecorationDetails("Phone", Icons.phone),
  );
  final MailField = TextFormField(
    autofocus: false,
    //validator: validateEmail,
    onSaved: (value) => _email = value,
    onChanged: (value) {
      _email = value;
    },
    validator: (value) {
      if (value.isEmpty) {
        return "Invalid email";
      } else {
        return null;
      }
    },
    //decoration: buildInputDecoration("Username", Icons.email),
    decoration: buildInputDecorationDetails("Mail", Icons.mail_outline),
  );
  final CityField = TextFormField(
    autofocus: false,
    //validator: validateEmail,
    onSaved: (value) => _city = value,
    onChanged: (value) {
      _city = value;
    },
    validator: (value) {
      if (value.isEmpty) {
        return "Invalid City";
      } else {
        return null;
      }
    },
    //decoration: buildInputDecoration("Username", Icons.email),
    decoration: buildInputDecorationDetails("City", Icons.location_city),
  );
  final NopplField = TextFormField(
    autofocus: false,
    //validator: validateEmail,
    onSaved: (value) => _noppl = value,
    onChanged: (value) {
      _noppl = value;
    },
    validator: (value) {
      if (value.isEmpty) {
        return "Enter Number of peoples";
      } else {
        return null;
      }
    },
    //decoration: buildInputDecoration("Username", Icons.email),
    decoration: buildInputDecorationDetails("Number of Peoples", Icons.people),
  );
  final SunivField = TextFormField(
    autofocus: false,
    //validator: validateEmail,
    onSaved: (value) => _university = value,
    onChanged: (value) {
      _university = value;
    },
    validator: (value) {
      if (value.isEmpty) {
        return "Select Univercity";
      } else {
        return null;
      }
    },
    //decoration: buildInputDecoration("Username", Icons.email),
    decoration:
        buildInputDecorationDetails("Select Univercity", Icons.school_outlined),
  );
  final ScamField = TextFormField(
    autofocus: false,
    //validator: validateEmail,
    onSaved: (value) => _campus = value,
    onChanged: (value) {
      _campus = value;
    },
    validator: (value) {
      if (value.isEmpty) {
        return "Select Campus";
      } else {
        return null;
      }
    },
    //decoration: buildInputDecoration("Username", Icons.email),
    decoration: buildInputDecorationDetails("Select Campus", Icons.school),
  );
  final Intake = TextFormField(
    autofocus: false,
    //validator: validateEmail,
    onSaved: (value) => _intake = value,
    onChanged: (value) {
      _intake = value;
    },
    validator: (value) {
      if (value.isEmpty) {
        return "Enter Intake";
      } else {
        return null;
      }
    },
    //decoration: buildInputDecoration("Username", Icons.email),
    decoration: buildInputDecorationDetails("Intake", Icons.people),
  );
// final date = TextFormField(
//   autofocus: false,
//   //validator: validateEmail,
//   onSaved: (value) => _date = value,
//   onChanged: (value) {
//     _date = value;
//   },
//   validator: (value) {
//     if (value.isEmpty) {
//       return "Enter Date";
//     } else {
//       return null;
//     }
//   },
//   //decoration: buildInputDecoration("Username", Icons.email),
//   decoration:
//       buildInputDecorationDetails("Date", Icons.calendar_month_outlined),
// );
}

class MyImageView extends StatelessWidget {
  String imgPath;

  MyImageView(this.imgPath);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: FittedBox(
          fit: BoxFit.fill,
          child: imgPath != null
              ? Image.network(
                  "https://seowebdesign.in/feelathome/site/images/1/"
                  '${imgPath}',
                  fit: BoxFit.cover)
              : Image.asset("assets/images/nia.jpg", fit: BoxFit.fitHeight),
        ));
  }
}

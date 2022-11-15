// @dart=2.9
import 'package:carousel_slider/carousel_slider.dart';
import 'package:feelathomeproject/model/propertyListingModel.dart';
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

  CollegedetailsView({this.id, this.getToolbarname, this.isfromSearach});

  @override
  _CollegedetailsViewState createState() => _CollegedetailsViewState();
}

class _CollegedetailsViewState extends State<CollegedetailsView> {
  static String _username, _phone, _email, _noppl, _message, _city;
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
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
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
                                itemCount: 3,
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
                                              .image !=
                                          null
                                      ? model
                                      .pptySearchList[widget.id]
                                      .image[index]
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
            ],
          ),
          /* SingleChildScrollView(
                 child: Container(
                     child: Form(
                       key: formKey,
                       child: Consumer<UserViewModel>(
                           builder: (contextModel, model, child) {
                             if (widget.isfromSearach) {
                               if (model.response == Response.Success &&
                                   model.pptySearchList != null &&
                                   model.pptySearchList.isNotEmpty) {
                                 return Column(
                                   children: [
                                     Column(
                                       children: [
                                         Container(
                                           margin: EdgeInsets.only(
                                               left: 10, right: 10, top: 20),
                                           width: MediaQuery.of(context).size.width,
                                           height: 220,
                                           decoration:
                                           new BoxDecoration(color: Colors.white),
                                           child: Column(
                                             children: [
                                               SizedBox(
                                                 height: 10,
                                               ),
                                               Container(
                                                 margin: EdgeInsets.only(
                                                     left: 10, right: 10),
                                                 child: Column(
                                                   children: [
                                                     CarouselSlider.builder(
                                                       itemCount: 3,
                                                       options: CarouselOptions(
                                                           autoPlay: false,
                                                           onPageChanged:
                                                               (index, reason) {
                                                             setState(() {
                                                               var currentPos = index;
                                                             });
                                                           }),
                                                       itemBuilder:
                                                           (BuildContext context,
                                                           int index, _) {
                                                         return MyImageView(model
                                                             .pptySearchList[
                                                         widget.id]
                                                             .image !=
                                                             null
                                                             ? model
                                                             .pptySearchList[
                                                         widget.id]
                                                             .image
                                                             : null);
                                                       },
                                                     ),
                                                   ],
                                                 ),
                                               ),
                                             ],
                                           ),
                                         ),
                                       ],
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
                             } else {
                               if (model.response == Response.Success &&
                                   model.propertyList != null &&
                                   model.propertyList.isNotEmpty) {
                                 return Column(
                                   children: [
                                     Column(
                                       children: [
                                         Container(
                                           margin: EdgeInsets.only(
                                               left: 10, right: 10, top: 50),
                                           width: MediaQuery.of(context).size.width,
                                           height: 220,
                                           decoration:
                                           new BoxDecoration(color: Colors.white),
                                           child: Column(
                                             children: [
                                               SizedBox(
                                                 height: 10,
                                               ),
                                               Container(
                                                 margin: EdgeInsets.only(
                                                     left: 10, right: 10),
                                                 child: Column(
                                                   children: [
                                                     CarouselSlider.builder(
                                                       itemCount: 3,
                                                       options: CarouselOptions(
                                                           autoPlay: false,
                                                           onPageChanged:
                                                               (index, reason) {
                                                             setState(() {
                                                               var currentPos = index;
                                                             });
                                                           }),
                                                       itemBuilder:
                                                           (BuildContext context,
                                                           int index, _) {
                                                         return MyImageView(model
                                                             .propertyList[
                                                         widget.id]
                                                             .image !=
                                                             null
                                                             ? model
                                                             .propertyList[
                                                         widget.id]
                                                             .image
                                                             : null);
                                                       },
                                                     ),
                                                   ],
                                                 ),
                                               ),
                                             ],
                                           ),
                                         ),
                                       ],
                                     ),
                                     getBody(),
                                   ],
                                 );
                               } else {
                                 return model.propertyList.isNotEmpty &&
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
                             }
                           }),
                     )),
               ),*/
        ));
  }

  Widget getBody() {
    return Container(
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        child: Consumer<UserViewModel>(builder: (contextModel, model, child) {
          return model.response == Response.Success &&
                  model.pptySearchList != null &&
                  model.pptySearchList.isNotEmpty
              ? Column(
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
                                                                      widget.id]
                                                                  .lat)
                                                              ?.toDouble(),
                                                          num.tryParse(model
                                                                  .pptySearchList[
                                                                      widget.id]
                                                                  .lng)
                                                              ?.toDouble())))
                                          : showToast('Location Not Available',
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
                                              '${model.pptySearchList[widget.id].price}',
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
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  model.pptySearchList[widget.id].description !=
                                          null
                                      ? model
                                          .pptySearchList[widget.id].description
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
                                    model.pptySearchList[widget.id].bed != null
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
                                        ? model.pptySearchList[widget.id].living
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
                                Text("Shower Rooms",
                                    style: new TextStyle(
                                        color: Colors.white,
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.normal)),
                                Text(
                                    model.pptySearchList[widget.id].shower !=
                                            null
                                        ? model.pptySearchList[widget.id].shower
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      padding: const EdgeInsets.only(left: 5.0),
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
                                      padding: const EdgeInsets.only(left: 5.0),
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
                                      padding: const EdgeInsets.only(left: 5.0),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      padding: const EdgeInsets.only(left: 5.0),
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
                                      padding: const EdgeInsets.only(left: 5.0),
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
                    Container(
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
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10, bottom: 10),
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
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ]),
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
                                                      new BorderRadius.circular(
                                                          10.0))),
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
                                              padding: const EdgeInsets.only(
                                                  top: 5.0, bottom: 5.0),
                                              child: Text("SUBMIT",
                                                  style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      color: Colors.white,
                                                      fontSize: 20)),
                                            ),
                                          ],
                                        ),
                                        onPressed: () async {
                                          if (formKey.currentState.validate()) {
                                            var res = false;
                                            res = await _userViewModel
                                                .PostEnquiry(
                                                model
                                                    .pptySearchList[widget.id]
                                                    .id !=null
                                                    ? num.tryParse(   model
                                                    .pptySearchList[widget.id]
                                                    .id)?.toInt()
                                                    : 1,
                                                    _username,
                                                    _phone,
                                                    _email,
                                                    _message,
                                                    _city,
                                                    _noppl);
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
                  ],
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

/*  final SubmitButton = Container(
    margin: const EdgeInsets.only(top: 10.0),
    padding: const EdgeInsets.only(left: 50.0, right: 50.0),
    child: new Row(
      children: <Widget>[
        new Expanded(
          child: TextButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0))),
              overlayColor: MaterialStateProperty.all(GreenHi),
              backgroundColor: MaterialStateProperty.all(GreenBottom),
            ),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: Text("SUBMIT",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.white,
                          fontSize: 20)),
                ),
              ],
            ),
            onPressed: () async {
              var res = false;
              res = await _userViewModel.PostEnquiry();
              if (res) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => HomeScreen(0)),
                        (Route<dynamic> route) => false);
              }
            },
          ),
        ),
      ],
    ),
  );*/
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
              : Image.asset("assets/images/no_image.jpg",
                  fit: BoxFit.fitHeight),
        ));
  }
}

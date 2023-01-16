// @dart=2.9
import 'package:feelathomeproject/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../util/styles.dart';
import '../view_models/base_view_model.dart';
import '../view_models/user_view_model.dart';
import '../widgets/loading_widget.dart';

class BasicInformations extends StatefulWidget {
  @override
  _BasicInformationsState createState() => _BasicInformationsState();
}

class _BasicInformationsState extends State<BasicInformations> {
  static String _Name, _NameLat, _email, _phn;
  final formKey = new GlobalKey<FormState>();
  UserViewModel _userViewModel;
  @override
  void initState() {
    super.initState();
    _userViewModel = Provider.of<UserViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Provider.of<UserViewModel>(context, listen: false).getbasicInfo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: Container(
        child: Column(
          children: [
            Container(child: getHeader()),
            Expanded(
              child: getBody(),
            ),
          ],
        ),
      ),
    );
  }

  Widget getHeader() {
    return Container(
      width: MediaQuery.of(context).size.width,
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
                    text: "BASIC INFORMATION",
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
        ],
      ),
    );
  }

  Widget getBody() {
    return Card(
      elevation: 10,
      margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: formKey,
            child:Consumer<UserViewModel>(builder: (contextModel, model, child) {
              return model.response == Response.Success &&
                  model.baiscinfoList != null
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 1.0,
                  ),
                  TextFormField(
                    autofocus: false,
                    //validator: validateEmail,
                    onSaved: (value) => _Name = value,
                    controller:
                    TextEditingController(text: model.baiscinfoList?.name ?? ""),
                    onChanged: (value) {
                      model.baiscinfoList?.name=value;
                    },
                    validator: (value) {
                      if (value.length < 3) {
                        return "Invalid Name";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: "eg : Jhony",
                      labelText: 'First Name',
                    ),
                  ),
                  SizedBox(
                    height: 1.0,
                  ),
                  TextFormField(
                    autofocus: false,
                    //validator: validateEmail,
                    onSaved: (value) => _NameLat = value,
                    controller:
                    TextEditingController(text:" "),
                    onChanged: (value) {
                      _NameLat = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return null;
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: "eg : Marcos",
                      labelText: 'Last Name',
                    ),
                  ),
                  SizedBox(
                    height: 1.0,
                  ),
                  TextFormField(
                    autofocus: false,
                    //validator: validateEmail,
                    onSaved: (value) => _email = value,
                    controller:
                    TextEditingController(text: model.baiscinfoList?.email?? ""),
                    onChanged: (value) {
                      model.baiscinfoList?.email=value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Invalid Email";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "eg : Marcos@gmail.com",
                      labelText: 'Email Address',
                    ),
                  ),
                  SizedBox(
                    height: 1.0,
                  ),
                  TextFormField(
                    autofocus: false,
                    //validator: validateEmail,
                    onSaved: (value) => _phn = value,
                    controller:
                    TextEditingController(text: model.baiscinfoList?.phone?? ""),
                    onChanged: (value) {
                      model.baiscinfoList?.phone=value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Invalid Mobile";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: "eg : 83869869286",
                      labelText: 'Phone',
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 100,
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
                              child: Text("SAVE",
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
                                .PostBasicInfo();
                          }
                        },
                      ),
                    ),
                  ),
                 /* TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      hintText: "***********",
                      labelText: 'Password',
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      hintText: "***********",
                      labelText: 'Confirm Password',
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _presentDatePicker(); // Call Function that has showDatePicker()
                    },
                    child: IgnorePointer(
                      child: new TextFormField(
                        decoration: new InputDecoration(hintText: 'DOB'),
                        // validator: validateDob,
                        onSaved: (String val) {},
                      ),
                    ),
                  ),
                  DropdownButton<String>(
                    isExpanded: true,
                    value: dropdownValue,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    underline: Container(
                      height: 2,
                      color: Colors.blue,
                    ),
                    onChanged: (String data) {
                      setState(() {
                        dropdownValue = data;
                      });
                    },
                    items: actorsName.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  Container(
                    width: double.infinity,
                    margin: new EdgeInsets.only(top: 10.0, bottom: 10.0, right: 3.0),
                    color: Colors.white,
                    child: new TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                          contentPadding: const EdgeInsets.all(12.0),
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(
                                  color: const Color(0xFFE0E0E0), width: 0.1)),
                          fillColor: Colors.white,
                          prefixIcon: countryDropDown,
                          hintText: 'Phone Number',
                          labelText: 'Phone Number'),
                    ),
                  ),*/
                ],
              )
              : LoadingAnimation();
            }),
          ),
        ),
      ),
    );
  }
}

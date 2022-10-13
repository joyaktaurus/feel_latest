// @dart=2.9
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../util/styles.dart';
import '../view_models/user_view_model.dart';

class ComplaintRegistration extends StatefulWidget {
  @override
  _ComplaintRegistrationState createState() => _ComplaintRegistrationState();
}

class _ComplaintRegistrationState extends State<ComplaintRegistration> {
  String _selectedCountryCode;
  final formKey = new GlobalKey<FormState>();
  static String _comp_title, _summary;
  List<String> _countryCodes = ['+91', '+23'];
  var countryDropDown;
  DateTime _selectedDate;
  UserViewModel _userViewModel;
  String dropdownValue = 'Fire';
  String dropdownValue1 = 'Low';

  // To show Selected Item in Text.
  String holder = '';
  String holder1 = '';

  List<String> actorsName = [
    'Fire',
    'Accident',
    'Theft',
    'Others',
  ];
  List<String> actorsName1 = [
    'High',
    'Medium',
    'Low',
  ];

  void getDropDownItem() {
    setState(() {
      holder = dropdownValue;
    });
  }

  void getDropDownItem1() {
    setState(() {
      holder1 = dropdownValue1;
    });
  }

  @override
  void initState() {
    super.initState();
    _userViewModel = Provider.of<UserViewModel>(context, listen: false);
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
                    text: "COMPLAINT REGISTRATION",
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 1.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Request Type",
                    style: TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 15.0),
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
                  items:
                      actorsName.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 1.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Priority",
                    style: TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 15.0),
                  ),
                ),
                DropdownButton<String>(
                  isExpanded: true,
                  value: dropdownValue1,
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
                      dropdownValue1 = data;
                    });
                  },
                  items:
                      actorsName1.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 1.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  onSaved: (value) => _comp_title = value,
                  onChanged: (value) {
                    _comp_title = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Enter Message";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Complaint Title',
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Complaint Summary",
                    style: TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 15.0),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      minLines: 2,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      onSaved: (value) => _summary = value,
                      onChanged: (value) {
                        _summary = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter Message";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      )),
                    ),
                  ],
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
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0))),
                        overlayColor: MaterialStateProperty.all(GreenHi),
                        backgroundColor: MaterialStateProperty.all(GreenBottom),
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Padding(
                            padding:
                                const EdgeInsets.only(top: 5.0, bottom: 5.0),
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
                          res = await _userViewModel.PostComplaint(
                              _comp_title, _summary, dropdownValue);
                          if (res) {
                            formKey.currentState.reset();
                          }
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
            ),
          ),
        ),
      ),
    );
  }
}

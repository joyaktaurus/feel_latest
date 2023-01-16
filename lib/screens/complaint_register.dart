// @dart=2.9
import 'package:feelathomeproject/screens/complaint_list.dart';
import 'package:feelathomeproject/util/widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:provider/provider.dart';

import '../camera/cameraawesome.dart';
import '../util/styles.dart';
import '../view_models/user_view_model.dart';

class ComplaintRegistration extends StatefulWidget {

  @override
  _ComplaintRegistrationState createState() => _ComplaintRegistrationState();
}

class _ComplaintRegistrationState extends State<ComplaintRegistration> {
  String _selectedCountryCode;
  final formKey = new GlobalKey<FormState>();
  static String _summary,_comp_title=" ";
  List<String> _countryCodes = ['+91', '+23'];
  var countryDropDown;
  DateTime _selectedDate;
  UserViewModel _userViewModel;
  String complaint_type_dropdownValue = 'Select issue type';
  String complaint_priority_level_dropdownValue = 'Priority Level';
  String fileName;
  var _image;
  String filename = "Attach your image";
  bool _isVisible = false;
  // To show Selected Item in Text.
  String holder = '';
  String holder1 = '';
  int customerproperty_id=0;

  List<String> complaint_type = [
    'Select issue type',
    'Clogging(Sink, bathroom etc)',
    'Water Leakage',
    'Heater / AC not working',
    'Power Disconnection',
    'Inspection from city / Council',
    'kitchen Appliances not working',
    'Door lock damage',
    'Furniture damage',
    'Other',
  ];
  List<String> complaint_priority = [
    'Priority Level',
    'High Priority',
    'High Priority',
    'High Priority',
    'High Priority',
    'High Priority',
    'Medium Priority',
    'Medium Priority',
    'Low Priority',
    'Low Priority',
  ];


  void getDropDownItem() {
    setState(() {
      holder = complaint_type_dropdownValue;
    });
  }

  void getDropDownItem1() {
    setState(() {
      holder1 = complaint_priority_level_dropdownValue;
    });
  }

  Future getImage(ImgSource source) async {
    var image = await ImagePickerGC.pickImage(
      enableCloseButton: true,
      closeIcon: const Icon(
        Icons.close,
        color: Colors.red,
        size: 12,
      ),
      context: context,
      source: source,
      barrierDismissible: true,
      cameraIcon: const Icon(
        Icons.camera_alt,
        color: Colors.red,
      ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
    );
    setState(() {
      this.fileName = image.path.toString();
      _image = image;
      filename = image.path.toString();
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
              child: const Text.rich(
                TextSpan(
                    text: "SUPPORT TICKET",
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
                  height: 5.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Issue Type",
                    style: TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 18.0),
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
                          2), //border raiuds of dropdown button
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: new DropdownButtonHideUnderline(
                        child: new DropdownButton(
                          isExpanded: true,
                          onChanged: (String data) {
                            setState(() {
                              complaint_type_dropdownValue = data;
                              int index = complaint_type.indexOf(data);
                              complaint_priority_level_dropdownValue =
                                  complaint_priority[index];
                              if(data=="Other"){
                                setState(() {
                                  _isVisible =true;
                                });
                              }else{
                                setState(() {
                                  _isVisible =false;
                                });
                              }
                            });
                          },
                          value: complaint_type_dropdownValue,
                          items: complaint_type
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                  fontSize: 15.0,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Visibility(
                  visible: _isVisible,
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    onSaved: (value) => _comp_title = value,
                    onChanged: (value) {
                      _comp_title = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Issue Title',
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Description",
                    style: TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 18.0),
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
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: Colors.black12), //<-- SEE HERE
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Attachments",
                    style: TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 18.0),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(15)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    side: BorderSide(color: Colors.black12)))),
                    onPressed: () async {
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SimpleDialog(
                                title: Text('Pick image from'),
                                children: [
                                  ListTile(
                                    onTap: () async {
                                      var result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => CamAwesome(
                                                  sellerId: 8734,
                                                  fromPage: 'listUpload')));

                                      setState(() {
                                        if (result != null) {
                                          this.fileName = result.toString();
                                          filename = result.toString();
                                        }
                                      });
                                      Navigator.pop(context);
                                    },
                                    title: Text('Camera'),
                                  ),
                                  ListTile(
                                    onTap: () async {
                                      getImage(ImgSource.Gallery);
                                      Navigator.pop(context);
                                    },
                                    title: Text('Gallery'),
                                  ),
                                ]);
                          });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(filename,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  fontSize: 15.0),
                              overflow: TextOverflow.ellipsis),
                        ),
                        Icon(Icons.attach_file, color: Colors.black, size: 30),
                      ],
                    )),
                SizedBox(
                  height: 20.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Property name",
                    style: TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 18.0),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Consumer<UserViewModel>(builder: (contextModel, model, child) {
                  return Container(
                    margin: EdgeInsets.only(top: 10),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        //background color of dropdown button
                        border: Border.all(color: Colors.black12, width: 1),
                        //border of dropdown button
                        borderRadius: BorderRadius.circular(
                            2), //border raiuds of dropdown button
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: new DropdownButtonHideUnderline(
                          child: new DropdownButton(
                            isExpanded: true,
                            hint: Text(
                              "Select property name",
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                            onChanged: (int changedValue) {
                              customerproperty_id = changedValue;
                              setState(() {
                                customerproperty_id;
                                print(customerproperty_id);
                              });
                            },
                            value: null,
                            //customerproperty_id,
                            items: model.customerPrtyList.map((CustomerProperties) {
                              return DropdownMenuItem(
                                child: Text(
                                  CustomerProperties.propertyName,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                                value: CustomerProperties.id,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  );
                 }),
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
                        print("customerproperty_id");
                        print(customerproperty_id);
                        if (complaint_type_dropdownValue ==
                            "Select complaint type") {
                          showToast('please select issue type',
                              color: Colors.red);
                        } else
                          if (customerproperty_id ==
                            0) {
                          showToast('please select your property',
                              color: Colors.red);
                        }else  {
                          if (formKey.currentState.validate()) {
                            var res = false;
                            res = await Provider.of<UserViewModel>(context,
                                    listen: false)
                                .submitComplaintRequestwithFile(context,_comp_title,_summary,
                                    complaint_type_dropdownValue,complaint_priority_level_dropdownValue,
                                    file: fileName);

                            // WidgetsBinding.instance.addPostFrameCallback((_) =>
                            //     Provider.of<UserViewModel>(context, listen: false).getComplaintList());
                            // res = await _userViewModel.PostComplaint(
                            // _comp_title, _summary, dropdownValue,fileName);
                            if (res) {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => ComplaintList()));
                            }
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

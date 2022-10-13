// @dart=2.9
import 'package:feelathomeproject/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../util/styles.dart';
import '../view_models/base_view_model.dart';
import '../view_models/user_view_model.dart';

class My_Rooms extends StatefulWidget {
  @override
  _My_RoomsState createState() => _My_RoomsState();
}

class _My_RoomsState extends State<My_Rooms> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Provider.of<UserViewModel>(context, listen: false).getRoomsList());
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
      margin: EdgeInsets.only(left: 10, right: 10, top: 50),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                        child: Text(
                      'MY ROOMS',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: colorAccent),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getBody() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Container(
        child: Consumer<UserViewModel>(builder: (contextModel, model, child) {
          return model.response == Response.Success &&
                  model.roomsList != null &&
                  model.roomsList.isNotEmpty
              ? new ListView.builder(
                  itemCount: model.roomsList.length,
                  itemBuilder: (BuildContext ctxt, int Index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 5.0,
                        ),
                        Card(
                          elevation: 4,
                          margin: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 100,
                                    height: 120,
                                    child: model.roomsList[Index].propertyImg != null
                                        ? Image.network(
                                        "https://seowebdesign.in/feelathome/site/images/1/"
                                            '${model.roomsList[Index].propertyImg}',
                                        fit: BoxFit.fitHeight)
                                        : Image.asset("assets/images/no_image.jpg",
                                        fit: BoxFit.fitHeight),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          model.roomsList[Index].propertyName,
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "\$"
                                          '${model.roomsList[Index].price}'
                                          "/month",
                                          style: TextStyle(color: colorAccent),
                                        ),
                                        Text("Starting Date: "
                                            '${DateFormat('dd-MM-yyyy').format(model.roomsList[Index].propertyStartDate)}'),
                                        Text("Ending Date: "
                                            '${DateFormat('dd-MM-yyyy').format(model.roomsList[Index].propertyEndDate)}'),
                                        Text(
                                          "Tenure: "
                                              '${(model.roomsList[Index].tenure_in_days)}'" Days",
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  })
              : model.roomsList.isEmpty && model.response == Response.Success
                  ? Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Center(
                        child: Text("No Data"),
                      ),
                    )
                  : Loading();
        }),
      ),
    );
  }
}

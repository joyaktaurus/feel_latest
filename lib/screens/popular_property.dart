// @dart=2.9
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../util/styles.dart';
import '../view_models/base_view_model.dart';
import '../view_models/user_view_model.dart';
import 'CollegedetailsView.dart';

class PopularPropertyList extends StatefulWidget {
  const PopularPropertyList({Key key}) : super(key: key);

  @override
  _PopularPropertyListState createState() => _PopularPropertyListState();
}

class _PopularPropertyListState extends State<PopularPropertyList> {
  UserViewModel _userViewModel;
  var validFormat = DateFormat('yyyy-MM-dd');
  var time;
  var validTime = DateFormat('HH:MM');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 110,
              decoration: BoxDecoration(color: Colors.white70),
              child: Padding(
                padding: const EdgeInsets.only(top: 42, bottom: 6),
                child: ListTile(
                  dense: true,
                  title: Text("Popular Properties",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: GreenBottom)),
                  leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back)),
                ),
              ),
            ),
            Container(
              transform: Matrix4.translationValues(0.0, -10.0, 0.0),
              decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Consumer<UserViewModel>(
                      builder: (contextModel, model, child) {
                        return model.response == Response.Success &&
                            model.pptySearchList != null &&
                            model.pptySearchList.isNotEmpty
                        ? GridView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 15.0,
                                    mainAxisSpacing: 15.0,
                                    childAspectRatio: 2 / 3),
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: model.pptySearchList.length,
                            itemBuilder: (contextList, index) {
                              print("EXECUTEDE");
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => CollegedetailsView(id:index,getToolbarname:model.pptySearchList[index].property_name.isEmpty
                                          ? " "
                                          : model.pptySearchList[index].property_name !=
                                          null
                                          ? model.pptySearchList[index].property_name
                                          : " ", isfromSearach: false,)));
                                },
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
                                          child: model.pptySearchList[index].image != null
                                              ? Image.network(
                                              "https://seowebdesign.in/feelathome/site/images/1/"
                                                  '${model.pptySearchList[index].image}',
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
                                                  model.pptySearchList[index].property_name,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                  ),
                                                  maxLines: 2,
                                                )),
                                            model.pptySearchList[index].price != null
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
                                                            '${model.pptySearchList[index].price}',
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
                              );
                            })
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
                  })),
            )
          ],
        ),
      ),
    );
  }
}

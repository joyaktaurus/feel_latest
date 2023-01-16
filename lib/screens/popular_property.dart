// @dart=2.9
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../util/styles.dart';
import '../util/widgets.dart';
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
      backgroundColor: Colors.green.shade50,
      body: Container(
        child: SingleChildScrollView(
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
              Column(
                children: [

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
                                      child:                     Card(
                                        clipBehavior: Clip.antiAlias,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            model.pptySearchList[index].image != null
                                                ? StreamBuilder<Object>(
                                                  stream: null,
                                                  builder: (context, snapshot) {
                                                    return SizedBox(
                                                      height: 140,
                                                      child: Image.network(
                                                      "https://seowebdesign.in/feelathome/site/images/1/"
                                                          '${model.pptySearchList[index].image[0]}',
                                                      fit: BoxFit.fitWidth
                                                      ),
                                                    );
                                                  }
                                                )
                                                : SizedBox(
                                                   height:140,
                                                  child: Image.asset("assets/images/nia.jpg",
                                                  fit: BoxFit.fitWidth),
                                                ),
                                            Padding(
                                              padding: const EdgeInsets.all(7.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  SizedBox(
                                                      child: Text(
                                                        CheckIsNotNull(
                                                            model.pptySearchList[index].property_name)
                                                            ? model.pptySearchList[index].property_name
                                                            : " ",
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                        ),
                                                        maxLines: 2,
                                                      )),
                                                  model.pptySearchList[index].price != null
                                                      ? SizedBox(
                                                    child: Expanded(
                                                      child: Column(
                                                        children : [
                                                          Row (
                                                        children : [
                                                        Text(
                                                             "From",
                                                            style: const TextStyle(
                                                              fontSize: 12,
                                                              color: Colors.grey,
                                                            ),),
                                                              Text(
                                                                " "
                                                                    '${model.pptySearchList[index].currency_code}',
                                                                style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight: FontWeight.w600,
                                                                  color: GreenBottom,
                                                                ),
                                                              ),
                                                              Text(
                                                               " "
                                                                '${model.pptySearchList[index].price}',
                                                                style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight: FontWeight.w600,
                                                                  color: GreenBottom,
                                                                ),
                                                              ),]),
                                                              Padding(
                                                                padding: const EdgeInsets.only(left: 25),
                                                                child: Row(
                                                                 children : [
                                                                Text(
                                                                    " \/"
                                                                      '${model.pptySearchList[index].price_per_pr}',
                                                                  style: TextStyle(
                                                                    fontSize: 12,
                                                                    color: Colors.grey,
                                                                  ),
                                                                ),
                                                                Text(
                                                                   " \/"
                                                                      '${model.pptySearchList[index].price_per}',
                                                                  style: TextStyle(
                                                                    fontSize: 12,
                                                                    color: Colors.grey,
                                                                  ),
                                                                ),
                                                            ]
                                                        ),
                                                              ),
                                                   ] ),
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
            ],
          ),
        ),
      ),
    );
  }
}

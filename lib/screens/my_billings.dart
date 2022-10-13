// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../util/styles.dart';
import 'map_view.dart';

class MyBillingsList extends StatefulWidget {
  //const SplashScreen() : super(key: key);
  @override
  _MyBillingsListState createState() => _MyBillingsListState();
}

class _MyBillingsListState extends State<MyBillingsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: Container(
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
                      text: "MY BILLINGS",
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
            getHeader(),
            Expanded(
              child: getBody(),
            ),
          ],
        ),
      ),
    );
  }

  Widget getHeader() {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 25, top: 10, bottom: 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: GreenBottom),
            child: Text("East Court,Toranto",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.white)),
          ),
          Container(
              padding: EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: 8,
                    )
                  ],
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Amount: ',
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 24),
                                    child: Text(
                                      '130',
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Deposit: ',
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 24),
                                    child: Text(
                                      '130',
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Starting Date: ',
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 24),
                                    child: Text(
                                      '12/03/2022',
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Ending Date: ',
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 24),
                                    child: Text(
                                      '12/03/2025',
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Tenure: ',
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 24),
                                    child: Text(
                                      '2 M',
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Next Pay Amount: ',
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 24),
                                    child: Text(
                                      'Due 14/09/11',
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget getBody() {
    return ListView(
      children: <Widget>[
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, top: 2, right: 10),
              padding: EdgeInsets.only(left: 25, top: 5, bottom: 5),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: colorAccent),
              child: Text("Saturday April 23 2022",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15.0,
                      color: Colors.white)),
            ),
            Card(
              elevation: 4,
              margin: EdgeInsets.all(10),
              child: Container(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          blurRadius: 8,
                        )
                      ],
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 5.0),
                                      child: Icon(Icons.monetization_on,color: Colors.green,),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Container(
                                            child: Text(
                                              "MVCN6527625/PAY",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal, fontSize: 15.0),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 2),
                                            child: Container(
                                              child:Text(
                                                "11:09 AM",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.normal, fontSize: 15.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: Text(
                                  "\$ 130.00",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal, fontSize: 15.0),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          ],
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, top: 2, right: 10),
              padding: EdgeInsets.only(left: 25, top: 5, bottom: 5),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: colorAccent),
              child: Text("Saturday April 23 2022",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15.0,
                      color: Colors.white)),
            ),
            Card(
              elevation: 4,
              margin: EdgeInsets.all(10),
              child: Container(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          blurRadius: 8,
                        )
                      ],
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 5.0),
                                      child: Icon(Icons.monetization_on,color: Colors.green,),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Container(
                                            child: Text(
                                              "MVCN6527625/PAY",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal, fontSize: 15.0),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 2),
                                            child: Container(
                                              child:Text(
                                                "11:09 AM",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.normal, fontSize: 15.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: Text(
                                  "\$ 130.00",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal, fontSize: 15.0),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          ],
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, top: 2, right: 10),
              padding: EdgeInsets.only(left: 25, top: 5, bottom: 5),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: colorAccent),
              child: Text("Saturday April 23 2022",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15.0,
                      color: Colors.white)),
            ),
            Card(
              elevation: 4,
              margin: EdgeInsets.all(10),
              child: Container(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          blurRadius: 8,
                        )
                      ],
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 5.0),
                                      child: Icon(Icons.monetization_on,color: Colors.green,),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Container(
                                            child: Text(
                                              "MVCN6527625/PAY",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal, fontSize: 15.0),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 2),
                                            child: Container(
                                              child:Text(
                                                "11:09 AM",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.normal, fontSize: 15.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: Text(
                                  "\$ 130.00",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal, fontSize: 15.0),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          ],
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, top: 2, right: 10),
              padding: EdgeInsets.only(left: 25, top: 5, bottom: 5),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: colorAccent),
              child: Text("Saturday April 23 2022",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15.0,
                      color: Colors.white)),
            ),
            Card(
              elevation: 4,
              margin: EdgeInsets.all(10),
              child: Container(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          blurRadius: 8,
                        )
                      ],
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 5.0),
                                      child: Icon(Icons.monetization_on,color: Colors.green,),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Container(
                                            child: Text(
                                              "MVCN6527625/PAY",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal, fontSize: 15.0),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 2),
                                            child: Container(
                                              child:Text(
                                                "11:09 AM",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.normal, fontSize: 15.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: Text(
                                  "\$ 130.00",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal, fontSize: 15.0),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ],
    );
  }
}

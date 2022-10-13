// @dart=2.9
import 'package:feelathomeproject/screens/BasicInformations.dart';
import 'package:flutter/material.dart';

import '../util/styles.dart';

class My_details extends StatefulWidget {
  @override
  _My_detailsState createState() => _My_detailsState();
}

class _My_detailsState extends State<My_details> {
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
                      'MY DETAILS',
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
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 5.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => BasicInformations()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 1, right: 1, top: 10),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/edit.png",
                                  height: 15.0,
                                  width: 20.0,
                                  color: Colors.green,
                                  fit: BoxFit.scaleDown,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text("Basic Informations"),
                              ],
                            ),
                            Icon(Icons.chevron_right)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

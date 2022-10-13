// @dart=2.9
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  int value;
  Loading({this.value});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(36),
      child: Align(
        alignment: Alignment.center,
        child: Center(
            child: Container(
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    value == 1
                        ? SizedBox(
                            height: 100,
                            width: 100,
                            child: CircularProgressIndicator(
                              color: Colors.amber,
                            ),
                          )
                        : CircularProgressIndicator(
                            color: Colors.amber,
                          ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: const Text(
                        'Loading',
                        style: TextStyle(color: Colors.amber),
                      ),
                    )
                  ],
                ))),
        heightFactor: 0,
      ),
    );
  }
}

// @dart=2.9
import 'package:feelathomeproject/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingAnimation extends StatelessWidget {
  int value;
  LoadingAnimation({this.value});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: Alignment.center,
        child: SpinKitCircle(size: 60.0, color:GreenBottom),
        heightFactor: 0,
      ),
    );
  }
}

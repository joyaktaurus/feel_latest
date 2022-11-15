import 'package:flutter/material.dart';

class backgroundHomeDash extends StatelessWidget {
  const backgroundHomeDash({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Align(
        alignment: Alignment.topRight,
        child:Container(
          margin: EdgeInsets.only(right: 10,top: 10),
          child: Image.asset(
            "assets/images/home_png.png",
            height: 100.0,
            width: 150.0,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

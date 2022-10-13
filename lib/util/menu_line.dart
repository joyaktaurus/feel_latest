// @dart=2.9
import 'package:flutter/material.dart';


class OpenFlutterMenuLine extends StatelessWidget {
  final String title;
  final String assetImage;
  final VoidCallback onTap;

  const OpenFlutterMenuLine(
      {this.title,this.assetImage, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        leading: Container(
          height: 22.0,
          width: 20.0,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.scaleDown,
                  image: AssetImage(assetImage))),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Icon(Icons.chevron_right),
      ),
      onTap: onTap,
    );
  }
}

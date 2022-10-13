import 'package:flutter/material.dart';


class ButtonField extends StatelessWidget {
  final String text;
  final Function onpressed;

  const ButtonField({
    Key? key,
    required this.text,
    required this.onpressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.teal,
          onPrimary: Colors.white,
          fixedSize: const Size(250, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        onPressed: onpressed(),
        child: Text(
          text,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ));
  }
}
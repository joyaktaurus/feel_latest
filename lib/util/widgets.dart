// @dart=2.9
import 'package:feelathomeproject/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


label(String title) => Text(title);

InputDecoration buildInputDecoration(String hintText, IconData icon) {
  return InputDecoration(
    filled: true,
    fillColor: GreenLoh,
    prefixIcon: Icon(icon, color:Colors.blue),
    hintText: hintText,
    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    enabledBorder: myinputborder(),
    focusedBorder: myfocusborder(),
    border: OutlineInputBorder( //Outline border type for TextFeild
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color:Colors.redAccent,
          width: 1,
        )
    ),
  );
}
InputDecoration buildInputDecorationDetails(String hintText, IconData icon) {
  return InputDecoration(
    filled: true,
    fillColor: LightGrey,
    prefixIcon: Icon(icon, color:Colors.grey),
    hintText: hintText,
    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    enabledBorder: myinputborder(),
    focusedBorder: myfocusborder(),
    border: OutlineInputBorder( //Outline border type for TextFeild
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color:Colors.redAccent,
          width: 1,
        )
    ),
  );
}
OutlineInputBorder myinputborder(){ //return type is OutlineInputBorder
  return OutlineInputBorder( //Outline border type for TextFeild
      borderRadius: BorderRadius.all(Radius.circular(50)),
      borderSide: BorderSide(
        color: Colors.white60,
        style:BorderStyle.none,
        width: 1,
      )
  );
}
InputDecoration getInputDecoration(
    {String hint,Color errorColor}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    fillColor:Colors.black54,
    hintText: hint,
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(color: Colors.black, width: 2.0)),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: errorColor),
      borderRadius: BorderRadius.circular(25.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: errorColor),
      borderRadius: BorderRadius.circular(25.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade200),
      borderRadius: BorderRadius.circular(25.0),
    ),
  );
}
OutlineInputBorder myfocusborder(){
  return OutlineInputBorder( //Outline border type for TextFeild
      borderRadius: BorderRadius.all(Radius.circular(50)),
      borderSide: BorderSide(
        color: Colors.blue.shade50,
        width: 1,
      )
  );

}
showToast(String message, {Color color}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: color == null ? ToastGravity.TOP : ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color ?? Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}
CheckIsNotNull(var fromvalue) {
  bool isnull=false;
    if (fromvalue != null||fromvalue!="null"||fromvalue!=" "||fromvalue!="") {
      isnull=true;
      return isnull;
    }
  return isnull;
}

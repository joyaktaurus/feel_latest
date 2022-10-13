// @dart=2.9
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../network/api_client.dart';
import '../network/network_exceptions.dart';
import '../network/shared_preference_helper.dart';


class BaseViewModel with ChangeNotifier, DiagnosticableTreeMixin {
  SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();
  ApiClient apiClient;
  Response response = Response.Loading;
  BaseViewModel() {
    apiClient = ApiClient();
  }

  onException(NetworkException e) {
    print("${e.code}");
    setError();
  }

  setLoading() {
    response = Response.Loading;
    notifyListeners();
  }

  setSuccess() {
    response = Response.Success;
    notifyListeners();
  }

  setError() {
    response = Response.Success;
    notifyListeners();
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
}

enum Response { Loading, Error, Success }

// @dart=2.9
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/user_model.dart';

class SharedPreferenceHelper {
  FlutterSecureStorage _sharedPreference = FlutterSecureStorage();

  initSharedPreference() async {
    _sharedPreference = FlutterSecureStorage();
  }

  saveUser(String data) {
    _sharedPreference.write(key: "profile", value: data);
  }

  saveisLoggedInVale(String LoginValue) {
    _sharedPreference.write(key: "isLoggedIn", value: LoginValue);
  }

  searchPopUpValue(String SearchPopUpValue) {
    _sharedPreference.write(key: "isFrompop", value: SearchPopUpValue);
  }

  NotificationValue(String SearchPopUpValue) {
    _sharedPreference.write(key: "notii", value: SearchPopUpValue);
  }

  saveAddress(String address) {
    _sharedPreference.write(key: "address", value: address);
  }

  removeAll() async {
    await _sharedPreference.deleteAll();
  }

  Future<UserModel> getUser() async {
    var data = await _sharedPreference.read(key: "profile");
    if (data != null) {
      return UserModel.fromJson(jsonDecode(data));
    } else {
      return null;
    }
  }

  Future<String> getsearchPopUpValue() async {
    var data = await _sharedPreference.read(key: "isFrompop");
    if (data != null) {
      return data;
    } else {
      return null;
    }
  }

  Future<String> getnotifValue() async {
    var data = await _sharedPreference.read(key: "notii");
    if (data != null) {
      return data;
    } else {
      return null;
    }
  }

  Future<String> getisLoggedInVale() async {
    var data = await _sharedPreference.read(key: "isLoggedIn");
    if (data != null) {
      return data;
    } else {
      return null;
    }
  }
  Future<String> getAddress() async {
    var data = await _sharedPreference.read(key: "address");
    if (data != null) {
      return data;
    } else {
      return null;
    }
  }

/* Future<CompanyLocation> getCompany() async {
    var data = await _sharedPreference.read(key: "location");
    if (data != null) {
      return CompanyLocation.fromJson(jsonDecode(data));
    } else {
      return null;
    }
  }
}*/
}

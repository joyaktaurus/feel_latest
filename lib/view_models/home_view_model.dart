// @dart=2.9
import 'dart:convert';

import 'base_view_model.dart';


class HomeViewModel extends BaseViewModel {
  bool _isFromSearchPopDark;

  bool get isFromSearchPopDark => _isFromSearchPopDark;

  ThemeModel() {
    _isFromSearchPopDark = false;


  }

  set isFromSearchPopDark(bool value) {
    _isFromSearchPopDark = value;
    notifyListeners();
  }

  getPreferences() async {

    notifyListeners();
  }

}

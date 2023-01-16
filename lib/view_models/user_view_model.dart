import 'dart:convert';
import 'package:feelathomeproject/model/BasicInfo.dart';
import 'package:feelathomeproject/model/countries_model.dart';
import 'package:feelathomeproject/model/rooms_model.dart';
import 'package:feelathomeproject/model/support_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../model/About.dart';
import '../model/HelpData.dart';
import '../model/collage_model.dart';
import '../model/notification_model.dart';
import '../model/propertyListingModel.dart';
import '../model/propertySearchModel.dart';
import '../model/user_model.dart';
import '../network/endpoints.dart';
import '../network/network_exceptions.dart';
import 'base_view_model.dart';
import 'package:http/http.dart' as http;

class UserViewModel extends BaseViewModel {
  var hidePhone = false;
  var isLoggedIn = false;
  PostResponse postresponse = PostResponse.Starting;
  UserModel userModel = UserModel(customer: Customer());
  late AboutDataModel aboutDataModel = AboutDataModel();
  late NotificationListModel notifDataModel = NotificationListModel();
  List<PropertyListingData> propertyList = [];
  late BasicInfoData baiscinfoList = BasicInfoData();
  List<RoomsListData> roomsList = [];
  List<FaqData> faqList = [];
  List<SupportTicketData> supportList = [];
  List<History> historyList = [];
  List<CustomerProperties> customerPrtyList = [];
  List<NotificationsData> notificationList = [];
  List<CountryData> countryList = [];
  // List<CountryData> currencyList = [];
  List<CollegeData> collageList = [];
  List<CityData> cityList = [];
  List<CampusData> campusList = [];
  List<Datavalues> pptySearchList = [];

  getPropertyList() async {
    propertyList.clear();
    setLoading();
    try {
      await apiClient.get("${EndPoints.getPropertieslist}").then((value) {
        setSuccess();
        propertyList = PropertyListingModel.fromJson(value).data.toList();
      });
    } on NetworkException catch (e) {
      propertyList = [];
      onException(e);
      setSuccess();
    }
  }

  getRoomsList() async {
    roomsList.clear();
    setLoading();
    // print("get chats URL :${EndPoints.getTextMessage}$id");
    try {
      await apiClient.getWithHeader("${EndPoints.getRoomsList}").then((value) {
        setSuccess();
        roomsList = RoomsListModel.fromJson(value).data.toList();
      });
    } on NetworkException catch (e) {
      roomsList = [];
      onException(e);
      setSuccess();
    }
  }

  getbasicInfo() async {
    baiscinfoList;
    setLoading();
    //print("get chats URL :${EndPoints.getTextMessage}$id");
    try {
      await apiClient
          .getWithHeader("${EndPoints.get_profile_details}")
          .then((value) {
        setSuccess();
        baiscinfoList = BasicInfoDataModel.fromJson(value).data;
      });
    } on NetworkException catch (e) {
      onException(e);
      setSuccess();
    }
  }

  gethelpList() async {
    faqList.clear();
    setLoading();
    //print("get chats URL :${EndPoints.getTextMessage}$id");
    try {
      await apiClient.getWithHeader("${EndPoints.get_help_list}").then((value) {
        setSuccess();
        faqList = HelpDataModel.fromJson(value).faq.toList();
      });
    } on NetworkException catch (e) {
      faqList = [];
      onException(e);
      setSuccess();
    }
  }

  getComplaintList() async {
    print("complaints");
    supportList.clear();
    customerPrtyList.clear();
    setLoading();
    //print("get chats URL :${EndPoints.getTextMessage}$id");
    try {
      await apiClient
          .getWithHeader("${EndPoints.get_complaint_list}")
          .then((value) {
        setSuccess();
        supportList = SupportTicketListModel.fromJson(value).tickets.toList();
        customerPrtyList =
            SupportTicketListModel.fromJson(value).customerProperties.toList();
      });
    } on NetworkException catch (e) {
      supportList = [];
      customerPrtyList = [];
      onException(e);
      setSuccess();
    }
  }

  getNotificationList() async {
    notificationList.clear();
    setLoading();
    //print("get chats URL :${EndPoints.getTextMessage}$id");
    try {
      await apiClient
          .getWithHeader("${EndPoints.get_notificatons_list}")
          .then((value) {
        setSuccess();
        notifDataModel = NotificationListModel.fromJson(value);
        notificationList = NotificationListModel.fromJson(value).notif.toList();
      });
    } on NetworkException catch (e) {
      notificationList = [];
      onException(e);
      setSuccess();
    }
  }

  void toggleNotification(bool bool) {
    if (bool) {
      this.notifDataModel.notification_status = "1";
    } else {
      this.notifDataModel.notification_status = "0";
    }
    notifyListeners();
  }

  getAboutList() async {
    setLoading();
    //print("get chats URL :${EndPoints.getTextMessage}$id");
    try {
      await apiClient
          .getWithHeader("${EndPoints.get_about_list}")
          .then((value) {
        setSuccess();
        aboutDataModel = AboutDataModel.fromJson(value);
      });
    } on NetworkException catch (e) {
      onException(e);
      setSuccess();
    }
  }

  getCountryList(int getClgid) async {
    countryList.clear();
    collageList.clear();
    campusList.clear();
    cityList.clear();
    var lstOfCities = countryList;

    lstOfCities.add(new CountryData(
        id: 1, cname: "CANADA", country_photo: "assets/images/ca.png"));
    lstOfCities.add(new CountryData(
        id: 2, cname: "UK", country_photo: "assets/images/gb.png"));
    lstOfCities.add(new CountryData(
        id: 3, cname: "IRELAND", country_photo: "assets/images/ie.png"));
    lstOfCities.add(new CountryData(
        id: 4, cname: "AUSTRALIA", country_photo: "assets/images/au.png"));
    getCollageList(getClgid);
    setSuccess();
    return true;
  }

  // getCurrencyList(int getClgid) async {
  //   currencyList.clear();
  //   countryList.clear();
  //   collageList.clear();
  //   campusList.clear();
  //   cityList.clear();
  //   var lstOfCurnames = currencyList;
  //
  //   lstOfCurnames.add(new CountryData(
  //       id: 1, cname: "CANADA", currency_name: "CAD"));
  //   lstOfCurnames.add(new CountryData(
  //       id: 2, cname: "UK", currency_name: "UK"));
  //   lstOfCurnames.add(new CountryData(
  //       id: 3, cname: "IRELAND", currency_name: "IRE"));
  //   lstOfCurnames.add(new CountryData(
  //       id: 4, cname: "AUSTRALIA", currency_name: "AUS"));
  //   getCollageList(getClgid);
  //   setSuccess();
  //   return true;
  // }

  Future getCollageList(int getid) async {
    setLoading();
    collageList.clear();
    campusList.clear();
    cityList.clear();
    //print("get chats URL :${EndPoints.getTextMessage}$id");
    try {
      Map body = {
        "country_id": getid,
      };
      var data =
          await apiClient.post("${EndPoints.get_college_list}", body: body);
      collageList = CollageListModel.fromJson(data).collegeData.toList();
      campusList = CollageListModel.fromJson(data).campusData.toList();
      cityList = CollageListModel.fromJson(data).cityData.toList();
      setSuccess();
      return true;
    } on NetworkException catch (e) {
      collageList = [];
      campusList = [];
      cityList = [];
      onException(e);
      setError();
      return false;
    }
  }

  Future getSearchList(
      String property_name,
      int country_id,
      int fk_collage,
      int fk_city,
      int fk_campus,
      String price_filter,
      String kitchen,
      String living) async {
    setLoading();
    pptySearchList.clear();
    //print("get chats URL :${EndPoints.getTextMessage}$id");
    try {
      Map body;
      body = {
        "property_name": property_name,
        "country_id": country_id,
        "fk_collage": fk_collage,
        "fk_city": fk_city,
        "fk_campus": fk_campus,
        "sort_by": price_filter,
        "kitchen": kitchen,
        "living": living,
      };

      var data = await apiClient.post("${EndPoints.post_property_with_search}",
          body: body);
      pptySearchList =
          propertySearchModel.fromJson(data).propertydata.data.toList();
      setSuccess();
      return true;
    } on NetworkException catch (e) {
      pptySearchList = [];
      onException(e);
      setError();
      return false;
    }
  }
  changeHide(bool value) {
    hidePhone = value;
    notifyListeners();
  }
  setPostSatrting() {
    postresponse = PostResponse.Starting;
    notifyListeners();
  }

  setPostLoading() {
    postresponse = PostResponse.Loading;
    notifyListeners();
  }

  setPostSuccess() {
    postresponse = PostResponse.Success;
    notifyListeners();
  }

  setPostError() {
    postresponse = PostResponse.Error;
    notifyListeners();
  }
  Future<bool> login() async {
    setLoading();
    setPostLoading();
    var res = false;
    sharedPreferenceHelper.saveisLoggedInVale("false");
    var fcmToken = await FirebaseMessaging.instance.getToken();
    try {
      Map body = {
        "email": userModel.customer.name,
        "password": userModel.customer.password,
        "device_id": fcmToken,
      };
      Map<String, dynamic> data =
          await apiClient.post("${EndPoints.login}", body: body);
      if (data['status'] == "Unauthorised") {
        showToast("Unauthorised", color: Colors.red);
        setSuccess();
        setPostSuccess();
        res = false;
        return false;
      } else if (data['status'] == "Authorised") {
        sharedPreferenceHelper.saveUser(jsonEncode(data));
        sharedPreferenceHelper.saveisLoggedInVale("true");
        userModel = UserModel.fromJson(data);
        isLoggedIn = true;
        String message = (data['message']) as String;
        showToast(message, color: Colors.green);
        // var isSave = await saveVisit();
        setSuccess();
        setPostSuccess();
        res = true;
        return true;
      }
      return res;
    } on NetworkException catch (e) {
      setError();
      setPostSuccess();
      showToast('${e}' 'NetworkException', color: Colors.red);
      onException(e);
      return false;
    }
  }

  Future<bool> forgot(String _email) async {
    var res = false;
    try {
      Map body = {
        "email": _email,
      };
      Map<String, dynamic> data =
          await apiClient.post("${EndPoints.forgot}", body: body);
      if (data['status'] == "Failed") {
        String message = (data['message']) as String;
        showToast(message, color: Colors.red);
        res = false;
        return false;
      } else if (data['status'] == "Success") {
        String message = (data['message']) as String;
        showToast(message, color: Colors.green);
        setSuccess();
        res = true;
        return true;
      }
      return res;
    } on NetworkException catch (e) {
      showToast('${e}' 'NetworkException', color: Colors.red);
      onException(e);
      return false;
    }
  }

  Future<bool> PostEnquiry(int id, String name, String phone, String email,
      String msg, String city, String nppl) async {
    var res = false;
    try {
      Map body = {
        "property_id": id,
        "city": city,
        "country": 1,
        "name": name,
        "phone": phone,
        "email": email,
        "msg": msg,
        "no_of_people": nppl,
      };
      Map<String, dynamic> data =
          await apiClient.post("${EndPoints.submit_enquiry}", body: body);
      if (data['status'] == "Success") {
        String message = (data['message']) as String;
        showToast(message, color: Colors.green);
        setSuccess();
        res = true;
        return true;
      } else {
        String message = (data['message']) as String;
        showToast(message, color: Colors.red);
        setSuccess();
        res = false;
        return false;
      }
      return res;
    } on NetworkException catch (e) {
      showToast('${e}' 'NetworkException', color: Colors.red);
      onException(e);
      return false;
    }
  }

  Future<bool> PostRating(
      int complaint_id, double noOfStars, String comments) async {
    var res = false;
    try {
      Map body = {
        "complaint_id": complaint_id,
        "noOfStars": noOfStars,
        "comments": comments,
      };
      Map<String, dynamic> data = await apiClient
          .postWithHeader("${EndPoints.post_star_rating}", body: body);
      if (data['status'] == "Success") {
        String message = (data['message']) as String;
        showToast(message, color: Colors.green);
        setSuccess();
        res = true;
      } else {
        String message = (data['message']) as String;
        showToast(message, color: Colors.red);
        setSuccess();
        res = false;
      }
      return res;
    } on NetworkException catch (e) {
      showToast('${e}' 'NetworkException', color: Colors.red);
      onException(e);
      return false;
    }
  }

  Future<bool> PostComplaint(
      String title, String description, String issue_type, var file) async {
    var res = false;
    try {
      Map body = {
        "title": title,
        "description": description,
        "fk_country_id": 1,
        "issue_type": issue_type,
        "files": file,
      };
      Map<String, dynamic> data = await apiClient
          .postWithHeader("${EndPoints.submit_support_ticket}", body: body);
      if (data['status'] == "Success") {
        String message = (data['message']) as String;
        showToast(message, color: Colors.green);
        setSuccess();
        res = true;
      } else {
        String message = (data['message']) as String;
        showToast(message, color: Colors.red);
        setSuccess();
        res = false;
      }
      return res;
    } on NetworkException catch (e) {
      showToast('${e}' 'NetworkException', color: Colors.red);
      onException(e);
      return false;
    }
  }

  Future<bool> PostReply(
      String name, String content, int support_ticket_id) async {
    var res = false;
    try {
      Map body = {
        "name": name,
        "content": content,
        "support_ticket_id": support_ticket_id,
      };
      Map<String, dynamic> data = await apiClient
          .postWithHeader("${EndPoints.submit_support_reply}", body: body);
      if (data['status'] == "Success") {
        String message = (data['message']) as String;
        showToast(message, color: Colors.green);
        setSuccess();
        res = true;
      } else {
        String message = (data['message']) as String;
        showToast(message, color: Colors.red);
        setSuccess();
        res = false;
      }
      return res;
    } on NetworkException catch (e) {
      showToast('${e}' 'NetworkException', color: Colors.red);
      onException(e);
      return false;
    }
  }

  Future<bool> PostNotificationStatus(int status) async {
    var res = false;
    try {
      Map body = {
        "status": status,
      };
      Map<String, dynamic> data = await apiClient
          .postWithHeader("${EndPoints.post_update_notification}", body: body);
      if (data['status'] == "Success") {
        String message = (data['message']) as String;
        showToast(message, color: Colors.green);
        setSuccess();
        res = true;
      } else {
        String message = (data['message']) as String;
        showToast(message, color: Colors.red);
        setSuccess();
        res = false;
      }
      return res;
    } on NetworkException catch (e) {
      showToast('${e}' 'NetworkException', color: Colors.red);
      onException(e);
      return false;
    }
  }

  Future<bool> PostBasicInfo() async {
    var res = false;
    try {
      Map body = {
        "name": baiscinfoList.name,
        "phone": baiscinfoList.phone,
        "email": baiscinfoList.email,
      };
      Map<String, dynamic> data = await apiClient
          .postWithHeader("${EndPoints.post_profile_details}", body: body);
      if (data['status'] == "Success") {
        String message = (data['message']) as String;
        showToast(message, color: Colors.green);
        setSuccess();
        res = true;
      } else {
        String message = (data['message']) as String;
        showToast(message, color: Colors.red);
        setSuccess();
        res = false;
      }
      return res;
    } on NetworkException catch (e) {
      showToast('${e}' 'NetworkException', color: Colors.red);
      onException(e);
      return false;
    }
  }
  void addItem(int id, History item) {
    historyList.add(item);
    notifyListeners();
  }

  Future<bool> submitComplaintRequestwithFile(BuildContext context,String title, String description,
      String issue_type, String issue_priority,
      {var file, var flag}) async {
    setLoading();
    bool res = false;
    if (file == null) {
      showToast('please attach your image', color: Colors.red);
      return res;
    }
    try {
      await apiClient.multipartRequest(context,"${EndPoints.submit_support_ticket}",
          headers: {
            'Content-Type': 'multipart/form-data',
            'Charset': 'utf-8',
            // 'Content-Disposition': 'attachment; filename =$file'
          },
          body: {
            "title": title,
            "description": description,
            "fk_country_id": '1',
            "issue_type": issue_type,
            "priority": issue_priority,
          },
          filePath: file,
          field: 'files');
      setSuccess();
      res = true;
    } on NetworkException catch (e) {
      res = false;
      onException(e);
    }
    return res;
  }
}
enum PostResponse {Starting,Loading, Error, Success }
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

  UserModel userModel = UserModel(customer: Customer());
  late AboutDataModel aboutDataModel;
  late NotificationListModel notifDataModel;
  List<PropertyListingData> propertyList = [];
  List<BasicInfoData> baiscinfoList = [];
  List<RoomsListData> roomsList = [];
  List<FaqData> faqList = [];
  List<SupportTicketData> supportList = [];
  List<NotificationsData> notificationList = [];
  List<CountryData> countryList = [];
  List<CollegeData> collageList = [];
  List<CityData> cityList = [];
  List<CampusData> campusList = [];
  List<Datavalues> pptySearchList = [];

  getPropertyList() async {
    propertyList.clear();
    setLoading();
    print("get property URL :${EndPoints.getPropertieslist}");
    //print("get chats URL :${EndPoints.getTextMessage}$id");
    try {
      await apiClient.get("${EndPoints.getPropertieslist}").then((value) {
        setSuccess();
        propertyList =
            PropertyListingModel.fromJson(value).data.toList();
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
    print("get property URL :${EndPoints.getRoomsList}");
    //print("get chats URL :${EndPoints.getTextMessage}$id");
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
    baiscinfoList.clear();
    setLoading();
    print("get property URL :${EndPoints.get_profile_details}");
    //print("get chats URL :${EndPoints.getTextMessage}$id");
    try {
      await apiClient
          .getWithHeader("${EndPoints.get_profile_details}")
          .then((value) {
        setSuccess();
        baiscinfoList =
            BasicInfoDataModel.fromJson(value).data.toList();
      });
    } on NetworkException catch (e) {
      baiscinfoList = [];
      onException(e);
      setSuccess();
    }
  }

  gethelpList() async {
    faqList.clear();
    setLoading();
    print("get property URL :${EndPoints.get_help_list}");
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
    supportList.clear();
    setLoading();
    print("get property URL :${EndPoints.get_complaint_list}");
    //print("get chats URL :${EndPoints.getTextMessage}$id");
    try {
      await apiClient
          .getWithHeader("${EndPoints.get_complaint_list}")
          .then((value) {
        setSuccess();
        supportList =
            SupportTicketListModel.fromJson(value).tickets.toList();
      });
    } on NetworkException catch (e) {
      supportList = [];
      onException(e);
      setSuccess();
    }
  }
  getNotificationList() async {
    notificationList.clear();
    setLoading();
    print("get property URL :${EndPoints.get_notificatons_list}");
    //print("get chats URL :${EndPoints.getTextMessage}$id");
    try {
      await apiClient
          .getWithHeader("${EndPoints.get_notificatons_list}")
          .then((value) {
        setSuccess();
        notifDataModel = NotificationListModel.fromJson(value);
        notificationList =
            NotificationListModel.fromJson(value).notif.toList();
      });
    } on NetworkException catch (e) {
      notificationList = [];
      onException(e);
      setSuccess();
    }
  }
  void toggleNotification(bool bool) {
    if(bool){
      this.notifDataModel.notification_status = "1";
    }else{
      this.notifDataModel.notification_status = "0";
    }
    notifyListeners();
  }

  getAboutList() async {
    setLoading();
    print("get property URL :${EndPoints.get_about_list}");
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

    lstOfCities
        .add(new CountryData(id: 1, cname: "CANADA", country_photo: "assets/images/ca.png"));
    lstOfCities
        .add(new CountryData(id: 2, cname: "UK", country_photo: "assets/images/gb.png"));
    lstOfCities
        .add(new CountryData(id: 2, cname: "IRELAND", country_photo: "assets/images/ie.png"));
    lstOfCities
        .add(new CountryData(id: 2, cname: "AUSTRALIA", country_photo: "assets/images/au.png"));
    getCollageList(getClgid);
    setSuccess();
    return true;
  }

  Future getCollageList(int getid) async {
    setLoading();
    collageList.clear();
    campusList.clear();
    cityList.clear();
    print("get property URL :${EndPoints.get_college_list}");
    //print("get chats URL :${EndPoints.getTextMessage}$id");
    try {
      Map body = {
        "country_id": getid,
      };
      var data = await apiClient.postWithHeader("${EndPoints.get_college_list}", body: body);
      collageList =
          CollageListModel.fromJson(data).collegeData.toList();
      campusList =
          CollageListModel.fromJson(data).campusData.toList();
      cityList =
          CollageListModel.fromJson(data).cityData.toList();
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

  Future getSearchList(String property_name,int country_id,int fk_collage,int fk_city,int fk_campus,String price_filter,String kitchen,String living) async {
    setLoading();
    pptySearchList.clear();
    print("get property URL :${EndPoints.post_property_with_search}");
    //print("get chats URL :${EndPoints.getTextMessage}$id");
    try {
      Map body;
         body = {
          "property_name": property_name,
          "country_id": country_id,
          "fk_collage": fk_collage,
          "fk_city": fk_city,
          "fk_campus": fk_campus,
          "price_filter": price_filter,
          "kitchen": kitchen,
          "living": living,
        };

      var data = await apiClient.postWithHeader("${EndPoints.post_property_with_search}", body: body);
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
  Future<bool> login() async {
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
        print(data);
        String message = (data['message']) as String;
        showToast(message, color: Colors.red);
        setSuccess();
        res = false;
        return false;
      } else if (data['status'] == "Authorised") {
        sharedPreferenceHelper.saveUser(jsonEncode(data));
        sharedPreferenceHelper.saveisLoggedInVale("true");
        userModel = UserModel.fromJson(data);
        print(data);
        print(userModel);
        isLoggedIn = true;
        String message = (data['message']) as String;
        showToast(message, color: Colors.green);
        // var isSave = await saveVisit();
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
  Future<bool> forgot(String _email) async {
    var res = false;
    try {
      Map body = {
        "email": _email,
      };
      Map<String, dynamic> data =
      await apiClient.post("${EndPoints.forgot}", body: body);
      if (data['status'] == "Failed") {
        print(data);
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

  Future<bool> PostRating(int complaint_id, double noOfStars, String comments) async {
    var res = false;
    try {
      Map body = {
        "complaint_id": complaint_id,
        "noOfStars": noOfStars,
        "comments": comments,
      };
      Map<String, dynamic> data =
      await apiClient.postWithHeader("${EndPoints.post_star_rating}", body: body);
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
  Future<bool> PostComplaint(String title, String description, String issue_type) async {
    var res = false;
    try {
      Map body = {
        "title": title,
        "description": description,
        "fk_country_id": 1,
        "issue_type": issue_type,
      };
      Map<String, dynamic> data =
      await apiClient.postWithHeader("${EndPoints.submit_support_ticket}", body: body);
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
      Map<String, dynamic> data =
      await apiClient.postWithHeader("${EndPoints.post_update_notification}", body: body);
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
        "name": baiscinfoList[0].name,
        "phone": baiscinfoList[0].phone,
        "email": baiscinfoList[0].email,
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

/*
  Future addAddress(String address) async {
    var userId = userModel.user.id;
    var body = {"customer_id": '$userId', "address": '$address'};
    try {
      setLoading();
      var addressData =
          await apiClient.post("${EndPoints.addAddress}", body: body);
      addressModel = AddressModel.fromJson(addressData).data;
      sharedPreferenceHelper.saveAddress(address);
      showToast('Registration Successful, Place Order', color: Colors.green);
      setSuccess();
      modelAddress = await sharedPreferenceHelper.getAddress();
    } on NetworkException catch (e) {
      setSuccess();
      onException(e);
    }
  }

  getDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(now);
  }

  getTime() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('HH:mm:s');
    return formatter.format(now);
  }*/

/*
  Future sendFile(var sellerId, {var file, var flag}) async {
    setLoading();
    if (file == null) {
      showToast('No file chosen');
      return;
    }
    try {
      await apiClient.multipartRequest(EndPoints.upload,
          headers: {
            'Content-Type': 'multipart/form-data',
            'Charset': 'utf-8',
            // 'Content-Disposition': 'attachment; filename =$file'
          },
          body: {
            'customer_id': '${userModel.user.id}',
            'seller_id': '$sellerId',
            'call_type': 'customer',
            'picture_flag': '$flag'
          },
          filePath: file,
          field: 'file');
      setSuccess();
      getChats(sellerId);
    } on NetworkException catch (e) {
      onException(e);
    }
  }

  Future sendMessage(var sellerId, {var flag, String message}) async {
    if (message == "" || message == null || message.length < 1) {
      showToast('Enter a valid message');
      return;
    }

    try {
      await apiClient.post(EndPoints.upload, body: {
        'customer_id': userModel.user.id,
        'seller_id': sellerId,
        'call_type': 'customer',
        'document_message': message,
        'picture_flag': '$flag'
      });
      getChats(sellerId);
    } on NetworkException catch (e) {
      onException(e);
    }
  }

  // PHOTO SHOPPING
  getItemCategory(int sellerId) {
    setLoading();
    print(
        "get ItemCategory URL :${EndPoints.getItemCategory}?seller_id=$sellerId");
    categoryItemList.clear();
    categoryTypes.clear();
    try {
      apiClient
          .get("${EndPoints.getItemCategory}?seller_id=$sellerId")
          .then((value) {
        categoryItemList = CategoryItem.fromJson(value).data.toList();
        for (int i = 0; i < categoryItemList.length; i++) {
          if (categoryItemList[i].sellerItems.isEmpty) {
            categoryItemList.removeAt(i);
          }
        }
        categoryItemList.sort((a, b) => a.name.compareTo(b.name));
        for (int i = 0; i < categoryItemList.length; i++) {
          if (categoryItemList[i].sellerItems.isNotEmpty) {
            categoryTypes.add(categoryItemList[i].name);
          }
        }
        categoryTypes = categoryTypes.toSet().toList();
        setSuccess();
      });
    } on NetworkException catch (e) {
      categoryItemList = [];
      setSuccess();
      onException(e);
    }
  }

  createOrderDocument({sellerId, orderId, filepath, orderMess}) {
    var body = {
      'seller_id': '$sellerId',
      'customer_id': '${userModel.user.id}',
      'order_number': '$orderId',
      'order_message': '$orderMess',
      'picture_flag': '0'
    };
    try {
      apiClient.multipartRequest("${EndPoints.createOrder}",
          body: body, field: "image", filePath: filepath);
    } on NetworkException catch (e) {
      setSuccess();
      onException(e);
    }
  }

  createOrderDraft({sellerId, orderId, filepath, sellerItemId}) async {
    // List<String> filepath = [];

    // for (int i = 0; i < imagefiles.length; i++) {
    //   filepath.add(imagefiles[i].path);
    // }
    var body = {
      'order_number': '$orderId',
      'order_date_time': '${DateTime.now()}',
      'seller_id': '$sellerId',
      'customer_id': '${userModel.user.id}',
      'seller_item_id': '$sellerItemId',
      'order_status': 'Draft',
      'del_status': '0'
    };
    try {
      await apiClient.multipartRequest("${EndPoints.getOrders}",
          body: body, field: "s3_img_id", filePath: filepath);
      getCustomerOrders();
    } on NetworkException catch (e) {
      setSuccess();
      onException(e);
    }
  }

  confirmOrder({orderId}) {
    var body = {'order_number': '$orderId', 'order_status': 'Order'};
    try {
      apiClient.post("${EndPoints.confirmOrder}", body: body);
    } on NetworkException catch (e) {
      setSuccess();
      onException(e);
    }
  }

  getCustomerOrders() {
    var userId = userModel.user.id;
    setLoading();
    print("get Vieitors URL :${EndPoints.getOrders}?customer_id=$userId");
    try {
      apiClient.get("${EndPoints.getOrders}?customer_id=$userId").then((value) {
        myOrders = CustomerOrders.fromJson(value).data.reversed.toList();

        setSuccess();
      });
    } on NetworkException catch (e) {
      visitorList = [];
      setSuccess();
      onException(e);
    }
  }

  deleteOrders(int id) async {
    try {
      await apiClient.delete('${EndPoints.getOrders}/$id', headers: {
        "Content-Type": "application/json",
      });
      await getCustomerOrders();
    } on NetworkException catch (e) {
      onException(e);
    }
  }

  getProductDetails({int sellerId, int catItemId}) async {
    try {
      await apiClient
          .get(
              '${EndPoints.getItemProduct}?seller_id=$sellerId&seller_item_id=$catItemId')
          .then((value) {
        productData = ProductDetails.fromJson(value).data.toList();
      });
    } on NetworkException catch (e) {
      onException(e);
    }
  }

  Future sendPhotoshopOrder({sellerId, orderId, orderDetList}) async {
    var body = {
      'order_number': '$orderId',
      'order_date_time': '${DateTime.now()}',
      'seller_id': '$sellerId',
      'customer_id': '${userModel.user.id}',
      // 'seller_item_id': '$sellerItemId',
      'order_status': 'Draft',
      'del_status': '0',
      "orderDetails": orderDetList
    };
    try {
      await apiClient.post('${EndPoints.sendPhotoshopOrder}', body: body);
      showToast("Your Order is Successfully placed, Refresh to view your Order",
          color: Colors.green);
    } on NetworkException catch (e) {
      onException(e);
    }
  }

  Future getPhotoOrders() async {
    var userId = userModel.user.id;
    photoOrderItemList = [];
    setLoading();
    try {
      await apiClient
          .get("${EndPoints.getPhotoOrdersList}$userId")
          .then((value) {
        photoOrderItemList = PhotoOrderModel.fromJson(value).data ?? [];
        setSuccess();
      });
    } on NetworkException catch (e) {
      onException(e);
      setError();
    }
  }

  Future getPhotoOrderDetails(int orderId) async {
    // var userId = userModel.user.id;
    photoOrderDetailsList = [];
    setLoading();
    try {
      await apiClient
          .get("${EndPoints.getPhotoOrderDetails}$orderId")
          .then((value) {
        photoOrderDetailsList = PhotoOrderDetails.fromJson(value).data ?? [];
        setSuccess();
      });
    } on NetworkException catch (e) {
      onException(e);
      setError();
    }
  }

  Future getOrderChats(orderId) async {
    orderChatList = [];
    setLoading();
    print("get chats URL :${EndPoints.orderChat}?seller_order_id=$orderId");
    try {
      await apiClient
          .get("${EndPoints.orderChat}?seller_order_id=$orderId")
          .then((value) {
        orderChatList = OrderChat.fromJson(value).data.toList();
        setSuccess();
      });
    } on NetworkException catch (e) {
      orderChatList = [];
      onException(e);
      setSuccess();
    }
  }

  Future sendOrderChatFile(var orderId, {var file, var flag}) async {
    if (file == null) {
      showToast('No file chosen');
      return;
    }
    setLoading();
    try {
      await apiClient.multipartRequest(EndPoints.orderChat,
          headers: {
            'Content-Type': 'multipart/form-data',
            'Charset': 'utf-8',
            // 'Content-Disposition': 'attachment; filename =$file'
          },
          body: {
            'seller_order_id': '$orderId',
            'type': 'customer',
            'picture_flag': '$flag'
          },
          filePath: file,
          field: 'file');
      setSuccess();
      getOrderChats(orderId);
    } on NetworkException catch (e) {
      onException(e);
    }
  }

  sendPush(String deviceToken, String shopName) async {
    String firebaseKey =
        "key=AAAA5qP61F4:APA91bF20da4kANdL-t3tL73gNN8EP9qLjyEvEKg-OrdFAkV2-vzPoaRGJo0fqr6s7EkwItOz1kiM9qcHZX62-4kOi3Umt-c7R9-shzUOCGBsH3rfnwv9K9Q-fgiG5VBvIZepwb5dsyI";
    var nameCustomer = userModel.user.name;
    print("*********Sending Notification**********");
    print("$nameCustomer : $deviceToken");
    setLoading();
    try {
      var data =
          await apiClient.post("https://fcm.googleapis.com/fcm/send", headers: {
        "Content-Type": "application/json",
        "authorization": firebaseKey
      }, body: {
        "to": deviceToken,
        "notification": {
          "body": "$nameCustomer has sent you an order.",
          "OrganizationId": "2",
          "content_available": true,
          "priority": "high",
          "subtitle": "Elementary School",
          "title": "Hello $shopName",
          "sound": "cellphonenotif.mp3",
          "android_channel_id": "high_importance_channel"
        },
        "data": {
          "body": "New Announcement assigned",
          "organization": "Elementary school"
        }
      });
    } on NetworkException catch (e) {
      onException(e);
      setError();
      return false;
    }
  }

  Future sendMessageOrder(var orderId, {var flag, String message}) async {
    if (message == "" || message == null || message.length < 1) {
      showToast('Enter a valid message');
      return;
    }

    try {
      await apiClient.post(EndPoints.orderChat, body: {
        'seller_order_id': '$orderId',
        'picture_flag': '$flag',
        'type': 'customer',
        'document_message': message,
      });
      getOrderChats(orderId);
    } on NetworkException catch (e) {
      onException(e);
    }
  }

  removeDialog(int index) {
    if (dupList.length >= 1) {
      dupList.removeAt(index);
      notifyListeners();
    }
  }

  nextDigit() {
    if (increment <= 99) {
      increment++;
    } else {
      increment = 10;
      print(increment);
    }
    // notifyListeners();
    return increment;
  }

  setHeading(String newValue) {
    categoryHeading = newValue;
    notifyListeners();
  }*/
}

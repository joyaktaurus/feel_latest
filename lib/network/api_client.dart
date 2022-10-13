// @dart=2.9
import 'dart:collection';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:feelathomeproject/network/shared_preference_helper.dart';
import 'package:feelathomeproject/util/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'network_exceptions.dart';

class ApiClient {
  SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();
  // SharedPreferenceHelper _sharedPreferenceHelper;
  static final ApiClient _singleton = ApiClient._internal();

  factory ApiClient() {
    return _singleton;
  }

  ApiClient._internal() {
    // _sharedPreferenceHelper = SharedPreferenceHelper();
  }

  //instantiate json decoder for json serialization

  final JsonDecoder _decoder = JsonDecoder();

//Get
  Future<dynamic> get(String url) async {
    // var accessToken = await _sharedPreferenceHelper.authToken;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      showToast('Network Not available, Please check connection', color: Colors.red);
      throw NetworkException(
          message: "Network Not available, Please check connection", code: 999);

    }
    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    print("URLLL==$url");
    return http
        .get(Uri.parse(url), headers: header)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      print("RESPONSE==${response.body}");

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw NetworkException(
            message: "Error fetching data from server", code: statusCode);
      }

      return _decoder.convert(res);
    });
  }
  //Get
  Future<dynamic> getWithHeader(String url) async {
    var userModel = await sharedPreferenceHelper.getUser();
    String customeapiToken = userModel.customer.api_token;
    // var accessToken = await _sharedPreferenceHelper.authToken;
     var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      showToast('Network Not available, Please check connection', color: Colors.red);
     throw NetworkException(
        message: "Network Not available, Please check connection", code: 999);

    }
    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'token': customeapiToken,
    };
    print("URLLL==$url");
    print("URLLL==$header");

    return http
        .get(Uri.parse(url), headers: header)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      print("RESPONSE==${response.body}");

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw NetworkException(
            message: "Error fetching data from server", code: statusCode);
      }
      return _decoder.convert(res);
    });
  }

//Post
  Future<dynamic> post(String url,
      {Map<String, String> headers,
        Map<dynamic, dynamic> body,
        encoding}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      showToast('Network Not available, Please check connection', color: Colors.red);
      throw NetworkException(
          message: "Network Not available, Please check connection", code: 999);

    }
    if (headers == null) {
      headers = HashMap<String, String>();
      headers['Content-Type'] = 'application/json';
    }
    var bodyData = jsonEncode(body);
    print(jsonDecode(bodyData));
    print("URLLL==$url");
    return http
        .post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    ).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      print("RESPONSE==${response.body}");
      if(statusCode==401){

      }
      else if (statusCode < 200 || statusCode > 400 || json == null) {
        throw NetworkException(
            message: "Error fetching data from server", code: statusCode);
      } else if (_decoder.convert(res)['error'] != null) {
        throw NetworkException(
            error: _decoder.convert(res),
            message: _decoder.convert(res)['errorMessage']);
      } else if (_decoder.convert(res)['code'] != null &&
          _decoder.convert(res)['code'] != 0) {
        throw NetworkException(
            code: _decoder.convert(res)['code'],
            error: _decoder.convert(res),
            message: _decoder.convert(res)['message']);
      }
      return _decoder.convert(res);
    });
  }
//Post With Header
  Future<dynamic> postWithHeader(String url,
      {Map<String, String> headers,
        Map<dynamic, dynamic> body,
        encoding}) async {
    var userModel = await sharedPreferenceHelper.getUser();
    String customeapiToken = userModel.customer.api_token;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      showToast('Network Not available, Please check connection', color: Colors.red);
      throw NetworkException(
          message: "Network Not available, Please check connection", code: 999);
    }
    print("URLLL==$url");
    if (headers == null) {
      headers = HashMap<String, String>();
      headers['Content-Type'] = 'application/json';
      headers['token'] = customeapiToken;
    }
    var bodyData = jsonEncode(body);
    print(jsonDecode(bodyData));
    return http
        .post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json",
        "token": customeapiToken},
      body: jsonEncode(body),
    ).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      print("RESPONSE==${response.body}");
      if(statusCode==401){

      }
      else if (statusCode < 200 || statusCode > 400 || json == null) {
        throw NetworkException(
            message: "Error fetching data from server", code: statusCode);
      } else if (_decoder.convert(res)['error'] != null) {
        throw NetworkException(
            error: _decoder.convert(res),
            message: _decoder.convert(res)['errorMessage']);
      } else if (_decoder.convert(res)['code'] != null &&
          _decoder.convert(res)['code'] != 0) {
        throw NetworkException(
            code: _decoder.convert(res)['code'],
            error: _decoder.convert(res),
            message: _decoder.convert(res)['message']);
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> put(String url,
      {Map<String, String> headers, body, encoding}) async {
    if (headers == null) {
      headers = HashMap<String, String>();
      headers['Content-Type'] = 'application/json';
    }
    var bodyData = jsonEncode(body);
    print(jsonDecode(bodyData));
    return http
        .put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    )
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      print("STATUS CODE: $statusCode");
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw NetworkException(
            message: "Error fetching data from server", code: statusCode);
      } else if (_decoder.convert(res)['error'] != null) {
        throw NetworkException(
            error: _decoder.convert(res),
            message: _decoder.convert(res)['errorMessage']);
      } else if (_decoder.convert(res)['code'] != null &&
          _decoder.convert(res)['code'] != 0) {
        throw NetworkException(
            code: _decoder.convert(res)['code'],
            error: _decoder.convert(res),
            message: _decoder.convert(res)['message']);
      }
      return _decoder.convert(res);
    });
  }

  // ignore: missing_return
  Future<http.StreamedResponse> multipartRequest(String url,
      {Map<String, String> headers,
        Map<String, String> body,
        filePath,
        String field,
        length}) async {
    if (headers == null) {
      headers = HashMap<String, String>();
      headers['Content-Type'] = 'multipart/form-data';
    }

    // var bodyData = jsonEncode(body);
    // print(jsonDecode(bodyData));
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath("$field", filePath));
      request.headers.addAll(headers);
      request.fields.addAll(body);
      var response = request.send();
      return response;
    } on NetworkException catch (e) {
      print(e);
    }
  }

  Future<http.StreamedResponse> multiplepartRequest(String url,
      {Map<String, String> headers,
        Map<String, String> body,
        List<String> filePath,
        String field,
        length}) async {
    List<http.MultipartFile> newList = [];
    for (var path in filePath) {
      var multipartFile = await http.MultipartFile.fromPath('$field', path);
      newList.add(multipartFile);
    }
    if (headers == null) {
      headers = HashMap<String, String>();
      headers['Content-Type'] = 'multipart/form-data';
    }
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.addAll(newList);
      request.headers.addAll(headers);
      request.fields.addAll(body);
      var response = request.send();
      return response;
    } on NetworkException catch (e) {
      print(e);
    }
  }

  Future<dynamic> delete(String url, {Map<String, String> headers}) async {

    if (headers == null) {
      headers = HashMap<String, String>();
      headers['Content-Type'] = 'application/json';
    }

    return http
        .delete(Uri.parse(url), headers: headers)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      print("RESPONSE==${response.body}");

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw NetworkException(
            message: "Error fetching data from server", code: statusCode);
      }
      return _decoder.convert(res);
    });
  }
}

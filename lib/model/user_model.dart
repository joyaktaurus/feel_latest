// @dart=2.9


class UserModel {
  Customer customer;
  String message;
  String token;

  UserModel({this.customer, this.message,this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    customer = json['customer'] != null ? new Customer.fromJson(json['customer']) : null;
    message = json['message'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['message'] = this.message;
    if (this.customer != null) {
      data['customer'] = this.customer.toJson();
    }
    return data;
  }
}

class Customer {
  String name;
  String phoneNumber;
  String email;
  String password;
  String api_token;
  String profile_photo;

  Customer(
      {this.name,
      this.phoneNumber,
      this.email,
      this.password,
      this.api_token,
      this.profile_photo});

  Customer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phone'];
    email = json['email'];
    api_token = json['api_token'];
    profile_photo = json['profile_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phoneNumber;
    data['email'] = this.email;
    data['api_token'] = this.api_token;
    data['profile_photo'] = this.profile_photo;
    return data;
  }

}

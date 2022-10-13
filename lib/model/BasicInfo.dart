// @dart=2.9
class BasicInfoDataModel {
  String message;
  List<BasicInfoData> data;

  BasicInfoDataModel({this.message, this.data});

  BasicInfoDataModel.fromJson(Map<String, dynamic> json) {
    message = json['status'];
    if (json['data'] != null) {
      data = <BasicInfoData>[];
      json['data'].forEach((v) {
        data.add(new BasicInfoData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BasicInfoData {
  String name;
  String phone;
  String email;

  BasicInfoData(
      {this.name,
        this.phone,
        this.email});

  BasicInfoData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name']=this.name;
    data['phone']=this.phone;
    data['email']=this.email;
    return data;
  }
}


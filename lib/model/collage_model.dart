// @dart=2.9
class CollageListModel {
  String message;
  List<CollegeData> collegeData;
  List<CityData> cityData;
  List<CampusData> campusData;

  CollageListModel({this.message, this.collegeData,cityData,this.campusData});

  CollageListModel.fromJson(Map<String, dynamic> json) {
    message = json['status'];
    if (json['college'] != null) {
      collegeData = <CollegeData>[];
      json['college'].forEach((v) {
        collegeData.add(new CollegeData.fromJson(v));
      });
    }
    if (json['city'] != null) {
      cityData = <CityData>[];
      json['city'].forEach((v) {
        cityData.add(new CityData.fromJson(v));
      });
    }
    if (json['campus'] != null) {
      campusData = <CampusData>[];
      json['campus'].forEach((v) {
        campusData.add(new CampusData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.message;
    if (this.collegeData != null) {
      data['college'] = this.collegeData.map((v) => v.toJson()).toList();
    }
    if (this.cityData != null) {
      data['city'] = this.cityData.map((v) => v.toJson()).toList();
    }
    if (this.campusData != null) {
      data['campus'] = this.campusData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CollegeData {
  int id;
  String college_name;

  CollegeData(
      {this.id,
        this.college_name
      });

  CollegeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    college_name = json['college_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id']=this.id;
    data['college_name']=this.college_name;
    return data;
  }
}
class CityData {
  int id;
  String province_name;

  CityData(
      {this.id,
        this.province_name
      });

  CityData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    province_name = json['province_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id']=this.id;
    data['province_name']=this.province_name;
    return data;
  }
}
class CampusData {
  int id;
  String campus_name;

  CampusData(
      {this.id,
        this.campus_name
      });

  CampusData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    campus_name = json['campus_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id']=this.id;
    data['campus_name']=this.campus_name;
    return data;
  }
}

// @dart=2.9
class RoomsListModel {
  String message;
  List<RoomsListData> data;

  RoomsListModel({this.message, this.data});

  RoomsListModel.fromJson(Map<String, dynamic> json) {
    message = json['status'];
    if (json['properties'] != null) {
      data = <RoomsListData>[];
      json['properties'].forEach((v) {
        data.add(new RoomsListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.message;
    if (this.data != null) {
      data['property'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RoomsListData {
  String id;
  String propertyName;
  String fkCountry;
  String fkProvince;
  String fkCollege;
  String fkCampus;
  String description;
  String price;
  String pricePer;
  String propertyImg;
  String bedSpace;
  String bedRate;
  String bedRatePer;
  String lat;
  String lng;
  String tenure_in_days;
  DateTime propertyEndDate;
  DateTime propertyStartDate;
  String rentOut;
  String town;
  String postCode;
  String propertyType;
  String propertyQuality;
  String termsAndCond;
  String propertyId;

  RoomsListData(
      {this.id,
        this.propertyName,
        this.fkCountry,
        this.fkProvince,
        this.fkCollege,
        this.fkCampus,
        this.description,
        this.price,
        this.pricePer,
        this.propertyImg,
        this.bedSpace,
        this.bedRate,
        this.bedRatePer,
        this.lat,
        this.lng,
        this.tenure_in_days,
        this.propertyEndDate,
        this.propertyStartDate,
        this.rentOut,
        this.town,
        this.postCode,
        this.propertyType,
        this.propertyQuality,
        this.termsAndCond,
        this.propertyId});

  RoomsListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    propertyName = json['property_name'];
    description = json['description'];
    price = json['price'];
    fkCountry = json['cname'];
    pricePer = json['price_per'];
    propertyImg = json['property_img'];
    tenure_in_days = json['tenure_in_days'];
    propertyEndDate = DateTime.parse(json['start_date']);
    propertyStartDate = DateTime.parse(json['end_date']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id']=this.id;
    data['property_name']=this.propertyName;
    data['description']=this.description;
    data['price']=this.price;
    data['cname']=this.fkCountry;
    data['price_per']=this.pricePer;
    data['property_img']=this.propertyImg;
    data['tenure_in_days']=this.tenure_in_days;
    data['start_date']=this.propertyEndDate;
    data['end_date']=this.propertyStartDate;
    return data;
  }
}


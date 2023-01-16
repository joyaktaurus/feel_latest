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
  String currency_code;
  String price;
  String pricePer;
  String price_per_pr;
  String propertyImg;
  String bedSpace;
  String bedRate;
  String bedRatePer;
  String lat;
  String lng;
  String bed_allotted;
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
      this.currency_code,
      this.price,
      this.pricePer,
      this.price_per_pr,
      this.propertyImg,
      this.bedSpace,
      this.bedRate,
      this.bedRatePer,
      this.lat,
      this.lng,
      this.bed_allotted,
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
    currency_code = json['currency_code'];
    price = json['price'];
    fkCountry = json['cname'];
    pricePer = json['price_per'];
    price_per_pr = json['price_per_pr'];
    propertyImg = json['property_img'];
    tenure_in_days = json['tenure_in_days'];
    bed_allotted = json['bed_allotted'];
    propertyEndDate = DateTime.parse(json['start_date']);
    propertyStartDate = DateTime.parse(json['end_date']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['property_name'] = this.propertyName;
    data['description'] = this.description;
    data['currency_code'] = this.currency_code;
    data['price'] = this.price;
    data['cname'] = this.fkCountry;
    data['price_per'] = this.pricePer;
    data['price_per_pr'] = this.price_per_pr;
    data['property_img'] = this.propertyImg;
    data['tenure_in_days'] = this.tenure_in_days;
    data['bed_allotted'] = this.bed_allotted;
    data['start_date'] = this.propertyEndDate;
    data['end_date'] = this.propertyStartDate;
    return data;
  }
}

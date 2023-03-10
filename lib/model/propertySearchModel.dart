// @dart=2.9
class propertySearchModel {
  String message;
  PropertySearchListingData propertydata;

  propertySearchModel({this.message, this.propertydata});

  propertySearchModel.fromJson(Map<String, dynamic> json) {
    message = json['status'];
    propertydata = json['property'] != null
        ? new PropertySearchListingData.fromJson(json['property'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.message;
    if (this.propertydata != null) {
      data['property'] = this.propertydata.toJson();
    }
    return data;
  }
}

class PropertySearchListingData {
  int current_page;
  List<Datavalues> data;

  PropertySearchListingData({this.current_page, this.data});

  PropertySearchListingData.fromJson(Map<String, dynamic> json) {
    current_page = json['current_page'];
    if (json['data'] != null) {
      data = <Datavalues>[];
      json['data'].forEach((v) {
        data.add(new Datavalues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.current_page;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Datavalues {
  String id;
  String property_name;
  String description;
  String price;
  String price_per;
  String price_per_pr;
  String currency_code;
  String living;
  String shower;
  String shower_half;
  int bed;
  String kitchen;
  String parking;
  String lat;
  String lng;
  List<String> image=[];

  Datavalues(
      {this.id,
      this.property_name,
      this.description,
      this.price,
      this.price_per,
      this.price_per_pr,
      this.currency_code,
      this.living,
      this.shower,
      this.shower_half,
      this.bed,
      this.kitchen,
      this.parking,
      this.lat,
      this.lng,
      this.image});

  Datavalues.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    property_name = json['property_name'];
    description = json['description'];
    price = json['price'];
    price_per = json['price_per'];
    price_per_pr = json['price_per_pr'];
    currency_code = json['currency_code'];
    living = json['living'];
    shower = json['shower'];
    shower_half = json['shower_half'];
    bed = json['bed'];
    kitchen = json['kitchen'];
    parking = json['parking'];
    lat = json['lat'];
    lng = json['lng'];
    var array = json['property_img'] != null ? (json['property_img']) : null;
    if (array == null) {
      image = null;
    } else {
      image = new List<String>.from(array);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['property_name'] = this.property_name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['price_per'] = this.price_per;
    data['price_per_pr'] = this.price_per_pr;
    data['currency_code'] = this.currency_code;
    data['living'] = this.living;
    data['shower'] = this.shower;
    data['shower_half'] = this.shower_half;
    data['bed'] = this.bed;
    data['kitchen'] = this.kitchen;
    data['parking'] = this.parking;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    if (this.image != null) {
      data['property_img'] = this.image;
    }
    return data;
  }
}

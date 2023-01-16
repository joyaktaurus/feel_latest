// @dart=2.9
class PropertyListingModel {
  String message;
  List<PropertyListingData> data;

  PropertyListingModel({this.message, this.data});

  PropertyListingModel.fromJson(Map<String, dynamic> json) {
    message = json['status'];
    if (json['property'] != null) {
      data = <PropertyListingData>[];
      json['property'].forEach((v) {
        data.add(new PropertyListingData.fromJson(v));
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

class PropertyListingData {
  int id;
  String property_name;
  String description;
  String price;
  String price_per;
  String price_per_pr;
  String currency_code;
  String living;
  String shower;
  String shower_half;
  String kitchen;
  String parking;
  String nearest_facility;
  String fully_furnished;
  String no_smoking;
  String entertaintment;
  String communal_laundry;
  String total_capacity;
  String bed;
  String remaining;
  String wifi;
  String lat;
  String lng;
  String town;
  String post_code;
  String property_type;
  List<String> collegelist;
  String image;

  PropertyListingData(
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
      this.kitchen,
      this.parking,
      this.nearest_facility,
      this.fully_furnished,
      this.no_smoking,
      this.entertaintment,
      this.communal_laundry,
      this.total_capacity,
      this.collegelist,
      this.bed,
      this.remaining,
      this.wifi,
      this.lat,
      this.lng,
      this.town,
      this.post_code,
      this.property_type,
      this.image});

  PropertyListingData.fromJson(Map<String, dynamic> json) {
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
    kitchen = json['kitchen'];
    parking = json['parking'];
    nearest_facility = json['nearest_facility'];
    fully_furnished = json['fully_furnished'];
    no_smoking = json['no_smoking'];
    entertaintment = json['entertaintment'];
    communal_laundry = json['communal_laundry'];
    total_capacity = json['total_capacity'];
    bed = json['bed'];
    remaining = json['remaining'];
    wifi = json['wifi'];
    lat = json['lat'];
    lng = json['lng'];
    town = json['town'];
    post_code = json['post_code'];
    property_type = json['property_type'];
    var array = json['college_list']; // array is now List<dynamic>
    collegelist = List<String>.from(array);
   /* collegelist = json['college_list'] != null
        ? json['college_list']
        : null;*/
    image = json['property_img'] != null
        ? (json['property_img'])
        : null;
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
    data['kitchen'] = this.kitchen;
    data['parking'] = this.parking;
    data['nearest_facility'] = this.nearest_facility;
    data['fully_furnished'] = this.fully_furnished;
    data['no_smoking'] = this.no_smoking;
    data['entertaintment'] = this.entertaintment;
    data['communal_laundry'] = this.communal_laundry;
    data['total_capacity'] = this.total_capacity;
    data['college_list']= this.collegelist;
    data['bed']=this.bed;
    data['remaining'] = this.remaining;
    data['wifi'] = this.wifi;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['town'] = this.town;
    data['post_code'] = this.post_code;
    data['property_type'] = this.property_type;
    if (this.image != null) {
      data['image'] = this.image;
    }
    return data;
  }
}

class PropertyImages {
  List<String> image;
  var streetsFromJson;

  PropertyImages({this.image});

  PropertyImages.fromJson(Map<String, dynamic> json) {
    // image = json['filename'];
    streetsFromJson = json['filename'];
    image = new List<String>.from(streetsFromJson);
    print(image);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['filename'] = this.image;
    return data;
  }
}

// @dart=2.9
class AboutDataModel {
  String message;
  String about;
  String terms_and_conditions;
  String privacy_policy;


  AboutDataModel({this.message,this.about, this.terms_and_conditions,this.privacy_policy});

  AboutDataModel.fromJson(Map<String, dynamic> json) {
    message = json['status'];
    about = json['about'];
    terms_and_conditions = json['terms_and_conditions'];
    privacy_policy = json['privacy_policy'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.message;
    data['about'] = this.about;
    data['terms_and_conditions'] = this.terms_and_conditions;
    data['privacy_policy'] = this.privacy_policy;
    return data;
  }
}



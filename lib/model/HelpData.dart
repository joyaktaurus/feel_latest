// @dart=2.9
class HelpDataModel {
  String message;
  String email;
  List<FaqData> faq;

  HelpDataModel({this.message,this.email, this.faq});

  HelpDataModel.fromJson(Map<String, dynamic> json) {
    message = json['status'];
    email = json['email'];
    if (json['faq'] != null) {
      faq = <FaqData>[];
      json['faq'].forEach((v) {
        faq.add(new FaqData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.message;
    data['email'] = this.email;
    if (this.faq != null) {
      data['faq'] = this.faq.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FaqData {
  int id;
  String question;
  String answer;


  FaqData(
      {this.id,
      this.question,
        this.answer});

  FaqData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id']=this.id;
    data['question']=this.question;
    data['answer']=this.answer;
    return data;
  }
}


// @dart=2.9
//formerly known as complaints
class SupportTicketListModel {
  String message;
  List<SupportTicketData> tickets;

  SupportTicketListModel({this.message, this.tickets});

  SupportTicketListModel.fromJson(Map<String, dynamic> json) {
    message = json['status'];
    if (json['data'] != null) {
      tickets = <SupportTicketData>[];
      json['data'].forEach((v) {
        tickets.add(new SupportTicketData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.message;
    if (this.tickets != null) {
      data['data'] = this.tickets.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SupportTicketData {
  int id;
  String title;
  String description;
  String file;
  String created_on;
  String status="false";
  String fk_customer_id;
  String rating;
  String comments;
  String issue_type;
  List<History> history;

  SupportTicketData(
      {this.id,
        this.title,
        this.description,
        this.file,
        this.created_on,
        this.status,
        this.fk_customer_id,
        this.rating,
        this.comments,
        this.issue_type,
        this.history});

  SupportTicketData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    file = json['file'];
    created_on = json['created_on'];
    status = json['status'];
    fk_customer_id = json['fk_customer_id'];
    rating = json['rating'];
    comments = json['comments'];
    issue_type = json['issue_type'];
    if (json['history'] != null) {
      history = <History>[];
      json['history'].forEach((v) {
        history.add(new History.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id']=this.id;
    data['title']=this.title;
    data['description']=this.description;
    data['file']=this.file;
    data['created_on']=this.created_on;
    data['status']=this.status;
    data['fk_customer_id']=this.fk_customer_id;
    data['rating']=this.rating;
    data['comments']=this.comments;
    data['issue_type']=this.issue_type;
    if (this.history != null) {
      data['history'] = this.history.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class History {
  int id;
  String content;
  String support_ticket_id;
  String fk_assignee_id;
  String name;
  String is_customer;
  String replied_on;


  History(
      {this.id,
        this.content,
        this.support_ticket_id,
        this.fk_assignee_id,
        this.name,
        this.is_customer,
        this.replied_on});

  History.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    support_ticket_id = json['support_ticket_id'];
    name = json['name'];
    fk_assignee_id = json['fk_assignee_id'];
    is_customer = json['is_customer'];
    replied_on = json['replied_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['support_ticket_id'] = this.support_ticket_id;
    data['name'] = this.name;
    data['fk_assignee_id'] = this.fk_assignee_id;
    data['is_customer'] = this.is_customer;
    data['replied_on'] = this.replied_on;
    return data;
  }
}
// @dart=2.9
//formerly known as complaints
class NotificationListModel {
  String message;
  String notification_status='0';
  List<NotificationsData> notif;

  NotificationListModel({this.message,this.notification_status="0",this.notif});

  NotificationListModel.fromJson(Map<String, dynamic> json) {
    message = json['status'];
    notification_status = json['notification_status'];
    if (json['data'] != null) {
      notif = <NotificationsData>[];
      json['data'].forEach((v) {
        notif.add(new NotificationsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.message;
    data['notification_status'] = this.notification_status;
    if (this.notif != null) {
      data['data'] = this.notif.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationsData {
  int id;
  String sender;
  String description;
  String type;
  String receiver;
  String received_on;
  String is_seen;

  NotificationsData(
      {this.id,
        this.sender,
        this.description,
        this.type,
        this.receiver,
        this.received_on,
        this.is_seen});

  NotificationsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sender = json['sender'];
    description = json['description'];
    type = json['type'];
    receiver = json['receiver'];
    received_on = json['received_on'];
    is_seen = json['is_seen'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id']=this.id;
    data['sender']=this.sender;
    data['description']=this.description;
    data['type']=this.type;
    data['receiver']=this.receiver;
    data['received_on']=this.received_on;
    data['is_seen']=this.is_seen;
    return data;
  }
}


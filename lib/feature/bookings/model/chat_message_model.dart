class ChatMessageModel {
  bool? success;
  int? statusCode;
  String? message;
  Meta? meta;
  List<ChatMessageData>? data;

  ChatMessageModel({
    this.success,
    this.statusCode,
    this.message,
    this.meta,
    this.data,
  });

  ChatMessageModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <ChatMessageData>[];
      json['data'].forEach((v) {
        data!.add(ChatMessageData.fromJson(v));
      });
    }
  }
}

class Meta {
  int? page;
  int? limit;
  int? total;
  int? totalPage;

  Meta({this.page, this.limit, this.total, this.totalPage});

  Meta.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    totalPage = json['totalPage'];
  }
}

class ChatMessageData {
  String? sId;
  String? text;
  List<String>? imageUrl;
  bool? seen;
  Sender? sender;
  String? createdAt;

  ChatMessageData({
    this.sId,
    this.text,
    this.imageUrl,
    this.seen,
    this.sender,
    this.createdAt,
  });

  ChatMessageData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    text = json['text'];
    imageUrl = json['imageUrl']?.cast<String>();
    seen = json['seen'];
    sender = json['sender'] != null ? Sender.fromJson(json['sender']) : null;
    createdAt = json['createdAt'];
  }
}

class Sender {
  String? sId;
  String? firstName;
  String? lastName;
  String? photoUrl;

  Sender({this.sId, this.firstName, this.lastName, this.photoUrl});

  Sender.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    photoUrl = json['photoUrl'];
  }
}

// lib/feature/discover/model/comment_model.dart

class CommentResponseModel {
  bool? success;
  int? statusCode;
  String? message;
  CommentMeta? meta;
  List<CommentItem>? data;

  CommentResponseModel({
    this.success,
    this.statusCode,
    this.message,
    this.meta,
    this.data,
  });

  CommentResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    meta = json['meta'] != null ? CommentMeta.fromJson(json['meta']) : null;
    data = json['data'] != null
        ? (json['data'] as List).map((e) => CommentItem.fromJson(e)).toList()
        : [];
  }
}

class CommentMeta {
  int? page;
  int? limit;
  int? total;
  int? totalPage;

  CommentMeta({this.page, this.limit, this.total, this.totalPage});

  CommentMeta.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    totalPage = json['totalPage'];
  }
}

class CommentItem {
  String? sId;
  CommentUser? user;
  String? comment;
  List<ReplyItem>? reply;
  String? updatedAt;
  bool? isDeletable;

  CommentItem({
    this.sId,
    this.user,
    this.comment,
    this.reply,
    this.updatedAt,
    this.isDeletable,
  });

  CommentItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'] != null ? CommentUser.fromJson(json['user']) : null;
    comment = json['comment'];
    reply = json['reply'] != null
        ? (json['reply'] as List).map((e) => ReplyItem.fromJson(e)).toList()
        : [];
    updatedAt = json['updatedAt'];
    isDeletable = json['isDeletable'];
  }
}

class ReplyItem {
  String? sId;
  CommentUser? user;
  String? replyRef;
  String? comment;
  String? updatedAt;
  bool? isDeletable;

  ReplyItem({
    this.sId,
    this.user,
    this.replyRef,
    this.comment,
    this.updatedAt,
    this.isDeletable,
  });

  ReplyItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'] != null ? CommentUser.fromJson(json['user']) : null;
    replyRef = json['replyRef'];
    comment = json['comment'];
    updatedAt = json['updatedAt'];
    isDeletable = json['isDeletable'];
  }
}

class CommentUser {
  String? sId;
  String? firstName;
  String? lastName;
  String? photoUrl;

  CommentUser({this.sId, this.firstName, this.lastName, this.photoUrl});

  String get fullName => '${firstName ?? ''} ${lastName ?? ''}'.trim();

  CommentUser.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    photoUrl = json['photoUrl'];
  }
}

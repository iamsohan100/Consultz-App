class ContentModel {
  bool? success;
  int? statusCode;
  String? message;
  Meta? meta;
  Data? data;

  ContentModel({
    this.success,
    this.statusCode,
    this.message,
    this.meta,
    this.data,
  });

  ContentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  int? activeFeed;
  int? restrictFeed;
  List<FeedList>? feedList;

  Data({this.activeFeed, this.restrictFeed, this.feedList});

  Data.fromJson(Map<String, dynamic> json) {
    activeFeed = json['activeFeed'];
    restrictFeed = json['restrictFeed'];
    if (json['feedList'] != null) {
      feedList = <FeedList>[];
      json['feedList'].forEach((v) {
        feedList!.add(FeedList.fromJson(v));
      });
    }
  }
}

class FeedList {
  String? sId;
  Author? author;
  List<String>? content;
  String? description;
  ContentMeta? contentMeta;
  String? status;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  bool? isLiked;

  FeedList({
    this.sId,
    this.author,
    this.content,
    this.description,
    this.contentMeta,
    this.status,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.isLiked,
  });

  FeedList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    content = json['content'].cast<String>();
    description = json['description'];
    contentMeta = json['contentMeta'] != null
        ? ContentMeta.fromJson(json['contentMeta'])
        : null;
    status = json['status'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isLiked = json['isLiked'];
  }
}

class Author {
  String? sId;
  String? firstName;
  String? lastName;
  String? photoUrl;
  String? headline;

  Author({
    this.sId,
    this.firstName,
    this.lastName,
    this.photoUrl,
    this.headline,
  });

  Author.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    photoUrl = json['photoUrl'];
    headline = json['headline'];
  }
}

class ContentMeta {
  String? sId;
  int? like;
  List<String>? likeBy;
  int? comment;

  ContentMeta({this.sId, this.like, this.likeBy, this.comment});

  ContentMeta.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    like = json['like'];
    if (json['likeBy'] != null) {
      likeBy = <String>[];
      json['likeBy'].forEach((v) {
        likeBy!.add(v as String);
      });
    }
    comment = json['comment'];
  }
}

// ignore_for_file: file_names

class ContentMetaResponseModel {
  bool? success;
  int? statusCode;
  String? message;
  ContentMetaData? data;

  ContentMetaResponseModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  ContentMetaResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? ContentMetaData.fromJson(json['data']) : null;
  }
}

class ContentMetaData {
  String? sId;
  int? like;
  List<String>? likeBy;
  int? comment;
  String? createdAt;
  String? updatedAt;
  String? content;

  ContentMetaData({
    this.sId,
    this.like,
    this.likeBy,
    this.comment,
    this.createdAt,
    this.updatedAt,
    this.content,
  });

  ContentMetaData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    like = json['like'];
    likeBy = json['likeBy'] != null ? List<String>.from(json['likeBy']) : [];
    comment = json['comment'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    content = json['content'];
  }
}

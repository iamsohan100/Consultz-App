class BlockedUserModel {
  bool? success;
  int? statusCode;
  String? message;
  Meta? meta;
  List<BlockedUserData>? data;

  BlockedUserModel(
      {this.success, this.statusCode, this.message, this.meta, this.data});

  BlockedUserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <BlockedUserData>[];
      json['data'].forEach((v) {
        data!.add(BlockedUserData.fromJson(v));
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

class BlockedUserData {
  String? sId;
  String? firstName;
  String? lastName;
  String? photoUrl;
  List<String>? expertise;

  BlockedUserData(
      {this.sId, this.firstName, this.lastName, this.photoUrl, this.expertise});

  BlockedUserData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    photoUrl = json['photoUrl'];
    expertise = json['expertise'].cast<String>();
  }


}

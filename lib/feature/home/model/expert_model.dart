class ExpertModel {
  bool? success;
  int? statusCode;
  String? message;
  Meta? meta;
  List<ExpertData>? data;

  ExpertModel({
    this.success,
    this.statusCode,
    this.message,
    this.meta,
    this.data,
  });

  ExpertModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <ExpertData>[];
      json['data'].forEach((v) {
        data!.add(ExpertData.fromJson(v));
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

class ExpertData {
  String? sId;
  String? firstName;
  String? lastName;
  String? headline;
  String? photoUrl;
  int? followers;
  dynamic avgRating;
  int? ratingCount;
  int? totalBookings;
bool? isFollowing;
  ExpertData({
    this.sId,
    this.firstName,
    this.lastName,
    this.headline,
    this.photoUrl,
    this.followers,
    this.avgRating,
    this.ratingCount,
    this.totalBookings,
    this.isFollowing,
  });

  ExpertData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    headline = json['headline'];
    photoUrl = json['photoUrl'];
    followers = json['followers'];
    avgRating = json['avgRating'];
    ratingCount = json['ratingCount'];
    totalBookings = json['totalBookings'];
    isFollowing = json['isFollowing'];
  }
}

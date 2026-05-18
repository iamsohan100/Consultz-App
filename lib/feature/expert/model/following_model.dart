import 'package:consultz/feature/expert/model/follower_and_following_data.dart';

class FollowingModel {
  bool? success;
  int? statusCode;
  String? message;
  Meta? meta;
  List<FollowerAndFollowingData>? followingData;

  FollowingModel({
    this.success,
    this.statusCode,
    this.message,
    this.meta,
    this.followingData,
  });

  FollowingModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      followingData = <FollowerAndFollowingData>[];
      json['data'].forEach((v) {
        followingData!.add(FollowerAndFollowingData.fromJson(v));
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



import 'package:consultz/feature/expert/model/follower_and_following_data.dart';

class FollowerModel {
  bool? success;
  int? statusCode;
  String? message;
  Meta? meta;
  List<FollowerAndFollowingData>? followerData;

  FollowerModel({
    this.success,
    this.statusCode,
    this.message,
    this.meta,
    this.followerData,
  });

  FollowerModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      followerData = <FollowerAndFollowingData>[];
      json['data'].forEach((v) {
        followerData!.add(FollowerAndFollowingData.fromJson(v));
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

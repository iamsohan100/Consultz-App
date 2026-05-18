// lib/feature/expert/model/withdraw_model.dart

class WithdrawResponseModel {
  bool? success;
  int? statusCode;
  String? message;
  WithdrawMeta? meta;
  WithdrawData? data;

  WithdrawResponseModel({
    this.success,
    this.statusCode,
    this.message,
    this.meta,
    this.data,
  });

  WithdrawResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    meta = json['meta'] != null ? WithdrawMeta.fromJson(json['meta']) : null;
    data = json['data'] != null ? WithdrawData.fromJson(json['data']) : null;
  }
}

class WithdrawMeta {
  int? page;
  int? limit;
  int? total;
  int? totalPage;

  WithdrawMeta({this.page, this.limit, this.total, this.totalPage});

  WithdrawMeta.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    totalPage = json['totalPage'];
  }
}

class WithdrawData {
  num? thisMonthWithdraw;
  List<WithdrawOverview>? withdrawOverview;
  List<WithdrawItem>? withdrawList;

  WithdrawData({
    this.thisMonthWithdraw,
    this.withdrawOverview,
    this.withdrawList,
  });

  WithdrawData.fromJson(Map<String, dynamic> json) {
    thisMonthWithdraw = json['thisMonthWithdraw'];
    if (json['withdrawOverview'] != null) {
      withdrawOverview = <WithdrawOverview>[];
      json['withdrawOverview'].forEach((v) {
        withdrawOverview!.add(WithdrawOverview.fromJson(v));
      });
    }
    if (json['withdrawList'] != null) {
      withdrawList = <WithdrawItem>[];
      json['withdrawList'].forEach((v) {
        withdrawList!.add(WithdrawItem.fromJson(v));
      });
    }
  }
}

class WithdrawOverview {
  String? month;
  num? amount;

  WithdrawOverview({this.month, this.amount});

  WithdrawOverview.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    amount = json['amount'];
  }
}

class WithdrawItem {
  String? sId;
  String? user;
  WithdrawBooking? booking;
  num? amount;
  String? status;
  String? createdAt;
  String? updatedAt;

  WithdrawItem({
    this.sId,
    this.user,
    this.booking,
    this.amount,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  WithdrawItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    booking = json['booking'] != null
        ? WithdrawBooking.fromJson(json['booking'])
        : null;
    amount = json['amount'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
}

class WithdrawBooking {
  String? sId;
  WithdrawBookingUser? user;
  String? sessionType;

  WithdrawBooking({this.sId, this.user, this.sessionType});

  WithdrawBooking.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'] != null
        ? WithdrawBookingUser.fromJson(json['user'])
        : null;
    sessionType = json['sessionType'];
  }
}

class WithdrawBookingUser {
  String? sId;
  String? firstName;
  String? lastName;

  WithdrawBookingUser({this.sId, this.firstName, this.lastName});

  String get fullName => '${firstName ?? ''} ${lastName ?? ''}'.trim();

  WithdrawBookingUser.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
  }
}

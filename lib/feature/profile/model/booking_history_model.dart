class BookingHistoryModel {
  bool? success;
  int? statusCode;
  String? message;
  Meta? meta;
  List<BookingData>? data;

  BookingHistoryModel(
      {this.success,
      this.statusCode,
      this.message,
      this.meta,
      this.data});

  BookingHistoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <BookingData>[];
      json['data'].forEach((v) {
        data!.add(BookingData.fromJson(v));
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

class BookingData {
  String? sId;
  User? user;
  Consult? consult;
  Slot? slot;
  String? sessionType;
  int? sessionDuration;
  int? price;
  String? timezone;
  String? status;
  String? createdAt;

  BookingData(
      {this.sId,
      this.user,
      this.consult,
      this.slot,
      this.sessionType,
      this.sessionDuration,
      this.price,
      this.timezone,
      this.status,
      this.createdAt});

  BookingData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    consult = json['consult'] != null ? Consult.fromJson(json['consult']) : null;
    slot = json['slot'] != null ? Slot.fromJson(json['slot']) : null;
    sessionType = json['sessionType'];
    sessionDuration = json['sessionDuration'];
    price = json['price'];
    timezone = json['timezone'];
    status = json['status'];
    createdAt = json['createdAt'];
  }

}

class User {
  String? sId;
  String? firstName;
  String? lastName;
  String? photoUrl;

  User({this.sId, this.firstName, this.lastName, this.photoUrl});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    photoUrl = json['photoUrl'];
  }
}

class Consult {
  String? sId;
  String? firstName;
  String? lastName;
  String? photoUrl;

  Consult({this.sId, this.firstName, this.lastName, this.photoUrl});

  Consult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    photoUrl = json['photoUrl'];
  }
}

class Slot {
  String? sId;
  String? date;
  String? time;

  Slot({this.sId, this.date, this.time});

  Slot.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    date = json['date'];
    time = json['time'];
  }

}

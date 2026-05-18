class ExpertReviewModel {
  bool? success;
  int? statusCode;
  String? message;
  Meta? meta;
  Data? data;

  ExpertReviewModel({
    this.success,
    this.statusCode,
    this.message,
    this.meta,
    this.data,
  });

  ExpertReviewModel.fromJson(Map<String, dynamic> json) {
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
  RatingBreakdown? ratingBreakdown;
  List<Reviews>? reviews;

  Data({this.ratingBreakdown, this.reviews});

  Data.fromJson(Map<String, dynamic> json) {
    ratingBreakdown = json['ratingBreakdown'] != null
        ? RatingBreakdown.fromJson(json['ratingBreakdown'])
        : null;
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v));
      });
    }
  }
}

class RatingBreakdown {
  dynamic excellent;
  dynamic veryGood;
  dynamic good;
  dynamic fair;
  dynamic poor;

  RatingBreakdown({
    this.excellent,
    this.veryGood,
    this.good,
    this.fair,
    this.poor,
  });

  RatingBreakdown.fromJson(Map<String, dynamic> json) {
    excellent = json['excellent'];
    veryGood = json['veryGood'];
    good = json['good'];
    fair = json['fair'];
    poor = json['poor'];
  }
}

class Reviews {
  String? sId;
  User? user;
  Booking? booking;
  String? review;
  dynamic rating;
  String? createdAt;

  Reviews({
    this.sId,
    this.user,
    this.booking,
    this.review,
    this.rating,
    this.createdAt,
  });

  Reviews.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    booking = json['booking'] != null
        ? Booking.fromJson(json['booking'])
        : null;
    review = json['review'];
    rating = json['rating'];
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

class Booking {
  String? sId;
  String? sessionType;

  Booking({this.sId, this.sessionType});

  Booking.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sessionType = json['sessionType'];
  }
}

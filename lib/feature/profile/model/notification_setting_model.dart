class NotificationSettingModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  NotificationSettingModel(
      {this.success, this.statusCode, this.message, this.data});

  NotificationSettingModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }


}

class Data {
  PushNotify? pushNotify;
  EmailNotify? emailNotify;
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  String? headline;
  String? photoUrl;
  String? status;
  String? id;
  String? createdAt;

  Data(
      {this.pushNotify,
      this.emailNotify,
      this.sId,
      this.firstName,
      this.lastName,
      this.email,
      this.headline,
      this.photoUrl,
      this.status,
      this.id,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    pushNotify = json['pushNotify'] != null
        ? PushNotify.fromJson(json['pushNotify'])
        : null;
    emailNotify = json['emailNotify'] != null
        ? EmailNotify.fromJson(json['emailNotify'])
        : null;
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    headline = json['headline'];
    photoUrl = json['photoUrl'];
    status = json['status'];
    id = json['id'];
    createdAt = json['createdAt'];
  }


}

class PushNotify {
  bool? bookingAndSchedule;
  bool? scheduleRemainder;
  bool? payment;
  bool? points;
  bool? followers;
  bool? post;
  bool? reviews;

  PushNotify(
      {this.bookingAndSchedule,
      this.scheduleRemainder,
      this.payment,
      this.points,
      this.followers,
      this.post,
      this.reviews});

  PushNotify.fromJson(Map<String, dynamic> json) {
    bookingAndSchedule = json['bookingAndSchedule'];
    scheduleRemainder = json['scheduleRemainder'];
    payment = json['payment'];
    points = json['points'];
    followers = json['followers'];
    post = json['post'];
    reviews = json['reviews'];
  }

}

class EmailNotify {
  bool? booking;
  bool? schedule;
  bool? payment;

  EmailNotify({this.booking, this.schedule, this.payment});

  EmailNotify.fromJson(Map<String, dynamic> json) {
    booking = json['booking'];
    schedule = json['schedule'];
    payment = json['payment'];
  }


}

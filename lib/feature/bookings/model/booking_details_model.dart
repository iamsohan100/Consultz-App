class BookingDetailsModel {
  bool? success;
  int? statusCode;
  String? message;
  BookingDetailsData? data;

  BookingDetailsModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  BookingDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? BookingDetailsData.fromJson(json['data']) : null;
  }
}

class BookingDetailsData {
  String? sId;
  BookingUser? user;
  BookingUser? consult;
  BookingSlot? slot;
  String? sessionType;
  int? sessionDuration;
  int? price;
  String? timezone;
  String? mainQuestion;
  String? challengeQuestion;
  String? backgroundQuestion;
  int? recordDuration;
  String? recordFile;
  String? paymentStatus;
  String? dmCloseTime;
  String? status;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? respondedAt;

  BookingDetailsData({
    this.sId,
    this.user,
    this.consult,
    this.slot,
    this.sessionType,
    this.sessionDuration,
    this.price,
    this.timezone,
    this.mainQuestion,
    this.challengeQuestion,
    this.backgroundQuestion,
    this.recordDuration,
    this.recordFile,
    this.paymentStatus,
    this.dmCloseTime,
    this.status,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.respondedAt,
  });

  BookingDetailsData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'] != null ? BookingUser.fromJson(json['user']) : null;
    consult = json['consult'] != null ? BookingUser.fromJson(json['consult']) : null;
    slot = json['slot'] != null ? BookingSlot.fromJson(json['slot']) : null;
    sessionType = json['sessionType'];
    sessionDuration = json['sessionDuration'];
    price = json['price'];
    timezone = json['timezone'];
    mainQuestion = json['mainQuestion'];
    challengeQuestion = json['challengeQuestion'];
    backgroundQuestion = json['backgroundQuestion'];
    recordDuration = json['recordDuration'];
    recordFile = json['recordFile'];
    paymentStatus = json['paymentStatus'];
    dmCloseTime = json['dmCloseTime'];
    status = json['status'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    respondedAt = json['respondedAt'];
  }
}

class BookingUser {
  String? sId;
  String? firstName;
  String? lastName;
  String? photoUrl;

  BookingUser({this.sId, this.firstName, this.lastName, this.photoUrl});

  BookingUser.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    photoUrl = json['photoUrl'];
  }
}

class BookingSlot {
  String? sId;
  String? date;
  String? time;

  BookingSlot({this.sId, this.date, this.time});

  BookingSlot.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    date = json['date'];
    time = json['time'];
  }
}

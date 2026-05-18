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
  String? dmCloseTime;
  String? sId;
  BookingUser? user;
  BookingConsult? consult;
  BookingSlot? slot;
  String? sessionType;
  int? sessionDuration;
  int? price;
  String? timezone;
  String? mainQuestion;
  String? challengeQuestion;
  String? backgroundQuestion;
  String? paymentStatus;
  String? status;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? recordDuration;
  String? recordFile;

  BookingDetailsData({
    this.dmCloseTime,
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
    this.paymentStatus,
    this.status,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.recordDuration,
    this.recordFile,
  });

  BookingDetailsData.fromJson(Map<String, dynamic> json) {
    dmCloseTime = json['dmCloseTime'];
    sId = json['_id'];
    user = json['user'] != null ? BookingUser.fromJson(json['user']) : null;
    consult =
        json['consult'] != null ? BookingConsult.fromJson(json['consult']) : null;
    slot = json['slot'] != null ? BookingSlot.fromJson(json['slot']) : null;
    sessionType = json['sessionType'];
    sessionDuration = json['sessionDuration'];
    price = json['price'];
    timezone = json['timezone'];
    mainQuestion = json['mainQuestion'];
    challengeQuestion = json['challengeQuestion'];
    backgroundQuestion = json['backgroundQuestion'];
    paymentStatus = json['paymentStatus'];
    status = json['status'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    recordDuration = json['recordDuration'];
    recordFile = json['recordFile'];
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

class BookingConsult {
  String? sId;
  String? firstName;
  String? lastName;
  String? photoUrl;

  BookingConsult({this.sId, this.firstName, this.lastName, this.photoUrl});

  BookingConsult.fromJson(Map<String, dynamic> json) {
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

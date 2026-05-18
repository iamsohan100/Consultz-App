class CreateBookingModel {
  bool? success;
  int? statusCode;
  String? message;
  BookingData? data;

  CreateBookingModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  CreateBookingModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? BookingData.fromJson(json['data']) : null;
  }
}

class BookingData {
  String? user;
  String? consult;
  String? slot;
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
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  BookingData({
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
    this.sId,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  BookingData.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    consult = json['consult'];
    slot = json['slot'];
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
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}

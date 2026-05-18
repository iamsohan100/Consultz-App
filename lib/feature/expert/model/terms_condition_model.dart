// ignore_for_file: unnecessary_new

class TermsConditionModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  TermsConditionModel({this.success, this.statusCode, this.message, this.data});

  TermsConditionModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? sId;
  String? termsAndConditions;
  int? paymentHoldDays;
  int? consultationFee;
  String? updatedAt;

  Data({
    this.sId,
    this.termsAndConditions,
    this.paymentHoldDays,
    this.consultationFee,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    termsAndConditions = json['termsAndConditions'];
    paymentHoldDays = json['paymentHoldDays'];
    consultationFee = json['consultationFee'];
    updatedAt = json['updatedAt'];
  }
}

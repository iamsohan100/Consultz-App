class AddCardResponseModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  AddCardResponseModel({this.success, this.statusCode, this.message, this.data});

  AddCardResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? author;
  String? holderName;
  String? cardNumber;
  String? expiryDate;
  String? cvc;
  bool? setAsDefault;
  bool? isDeleted;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.author,
      this.holderName,
      this.cardNumber,
      this.expiryDate,
      this.cvc,
      this.setAsDefault,
      this.isDeleted,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    holderName = json['holderName'];
    cardNumber = json['cardNumber'];
    expiryDate = json['expiryDate'];
    cvc = json['cvc'];
    setAsDefault = json['setAsDefault'];
    isDeleted = json['isDeleted'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['author'] = author;
    data['holderName'] = holderName;
    data['cardNumber'] = cardNumber;
    data['expiryDate'] = expiryDate;
    data['cvc'] = cvc;
    data['setAsDefault'] = setAsDefault;
    data['isDeleted'] = isDeleted;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

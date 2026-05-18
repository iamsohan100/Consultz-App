class MyCardsResponseModel {
  bool? success;
  int? statusCode;
  String? message;
  Meta? meta;
  List<CardDataModel>? data;

  MyCardsResponseModel(
      {this.success, this.statusCode, this.message, this.meta, this.data});

  MyCardsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <CardDataModel>[];
      json['data'].forEach((v) {
        data!.add(CardDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['limit'] = limit;
    data['total'] = total;
    data['totalPage'] = totalPage;
    return data;
  }
}

class CardDataModel {
  String? sId;
  String? author;
  String? holderName;
  String? cardNumber;
  String? expiryDate;
  String? cvc;
  bool? setAsDefault;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? status;

  CardDataModel(
      {this.sId,
      this.author,
      this.holderName,
      this.cardNumber,
      this.expiryDate,
      this.cvc,
      this.setAsDefault,
      this.isDeleted,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.status});

  CardDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    author = json['author'];
    holderName = json['holderName'];
    cardNumber = json['cardNumber'];
    expiryDate = json['expiryDate'];
    cvc = json['cvc'];
    setAsDefault = json['setAsDefault'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['author'] = author;
    data['holderName'] = holderName;
    data['cardNumber'] = cardNumber;
    data['expiryDate'] = expiryDate;
    data['cvc'] = cvc;
    data['setAsDefault'] = setAsDefault;
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['status'] = status;
    return data;
  }
}

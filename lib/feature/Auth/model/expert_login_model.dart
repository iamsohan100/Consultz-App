class ExpertLoginModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  ExpertLoginModel({this.success, this.statusCode, this.message, this.data});

  ExpertLoginModel.fromJson(Map<String, dynamic> json) {
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
  String? accessToken;
  User? user;

  Data({this.accessToken, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  String? role;
  bool? isProfileSetup;
  String? status;
  String? registerWith;

  User(
      {this.firstName,
      this.lastName,
      this.email,
      this.role,
      this.isProfileSetup,
      this.status,
      this.registerWith,
      });

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    role = json['role'];
    isProfileSetup = json['isProfileSetup'];
    status = json['status'];
    registerWith = json['registerWith'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['role'] = role;
    data['isProfileSetup'] = isProfileSetup;
    data['status'] = status;
    data['registerWith'] = registerWith;
    return data;
  }
}

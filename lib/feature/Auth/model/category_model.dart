// class CategoryModel {
//   bool? success;
//   int? statusCode;
//   String? message;
//   Data? data;

//   CategoryModel({this.success, this.statusCode, this.message, this.data});

//   CategoryModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     statusCode = json['statusCode'];
//     message = json['message'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//   }

// }

// class Data {
//   String? sId;
//   String? title;
//   List<String>? items;
//   int? iV;

//   Data({this.sId, this.title, this.items, this.iV});

//   Data.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     title = json['title'];
//     items = json['items'].cast<String>();
//     iV = json['__v'];
//   }

// }

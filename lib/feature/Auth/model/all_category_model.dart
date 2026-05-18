class AllCategoryModel {
  bool? success;
  int? statusCode;
  String? message;
  List<AllCategoryData>? data;

  AllCategoryModel({this.success, this.statusCode, this.message, this.data});

  AllCategoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AllCategoryData>[];
      json['data'].forEach((v) {
        data!.add(AllCategoryData.fromJson(v));
      });
    }
  }
}

class AllCategoryData {
  String? sId;
  String? title;
  List<String>? items;

  AllCategoryData({this.sId, this.title});

  AllCategoryData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    items = json['items'].cast<String>();
  }
}

class NotificationModel {
  bool? success;
  int? statusCode;
  String? message;
  Meta? meta;
  Data? data;

  NotificationModel(
      {this.success, this.statusCode, this.message, this.meta, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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
      data['data'] = this.data!.toJson();
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

class Data {
  int? unreadMessage;
  List<NotificationData>? notifications;

  Data({this.unreadMessage, this.notifications});

  Data.fromJson(Map<String, dynamic> json) {
    unreadMessage = json['unreadMessage'];
    if (json['notifications'] != null) {
      notifications = <NotificationData>[];
      json['notifications'].forEach((v) {
        notifications!.add(NotificationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unreadMessage'] = unreadMessage;
    if (notifications != null) {
      data['notifications'] = notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationData {
  String? sId;
  Reference? reference;
  String? modelType;
  String? message;
  String? description;
  bool? read;
  String? date;
  String? createdAt;

  NotificationData(
      {this.sId,
      this.reference,
      this.modelType,
      this.message,
      this.description,
      this.read,
      this.date,
      this.createdAt});

  NotificationData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['reference'] != null) {
      if (json['reference'] is Map<String, dynamic>) {
        reference = Reference.fromJson(json['reference']);
      } else if (json['reference'] is String) {
        reference = Reference(sId: json['reference']);
      }
    } else {
      reference = null;
    }
    modelType = json['modelType'];

    message = json['message'];
    description = json['description'];
    read = json['read'];
    date = json['date'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (reference != null) {
      data['reference'] = reference!.toJson();
    }
    data['modelType'] = modelType;
    data['message'] = message;
    data['description'] = description;
    data['read'] = read;
    data['date'] = date;
    data['createdAt'] = createdAt;
    return data;
  }
}

class Reference {
  String? sId;
  String? sessionType;

  Reference({this.sId, this.sessionType});

  Reference.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sessionType = json['sessionType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['sessionType'] = sessionType;
    return data;
  }
}


class ExpertBookingByDateResponse {
  bool? success;
  int? statusCode;
  String? message;
  List<BookingDateGroup>? data;

  ExpertBookingByDateResponse({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  ExpertBookingByDateResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      if (json['data'] is List) {
        data = <BookingDateGroup>[];
        json['data'].forEach((v) {
          data!.add(BookingDateGroup.fromJson(v));
        });
      } else if (json['data'] is Map) {
        data = <BookingDateGroup>[];
        data!.add(BookingDateGroup.fromJson(json['data']));
      }
    }
  }
}

class BookingDateGroup {
  String? date;
  List<BookingItem>? bookingList;

  BookingDateGroup({this.date, this.bookingList});

  BookingDateGroup.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['bookingList'] != null) {
      bookingList = <BookingItem>[];
      json['bookingList'].forEach((v) {
        bookingList!.add(BookingItem.fromJson(v));
      });
    }
  }
}

class BookingItem {
  String? sId;
  BookingUser? user;
  BookingUser? consult;
  BookingSlot? slot;
  String? sessionType;
  int? sessionDuration;
  int? price;
  String? timezone;
  String? status;
  String? createdAt;

  BookingItem({
    this.sId,
    this.user,
    this.consult,
    this.slot,
    this.sessionType,
    this.sessionDuration,
    this.price,
    this.timezone,
    this.status,
    this.createdAt,
  });

  BookingItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['user'] != null) {
      if (json['user'] is Map<String, dynamic>) {
        user = BookingUser.fromJson(json['user']);
      } else {
        user = BookingUser(sId: json['user'].toString());
      }
    }
    if (json['consult'] != null) {
      if (json['consult'] is Map<String, dynamic>) {
        consult = BookingUser.fromJson(json['consult']);
      } else {
        consult = BookingUser(sId: json['consult'].toString());
      }
    }
    slot = json['slot'] != null ? BookingSlot.fromJson(json['slot']) : null;
    sessionType = json['sessionType'];
    sessionDuration = (json['sessionDuration'] as num?)?.toInt();
    price = (json['price'] as num?)?.toInt();
    timezone = json['timezone'];
    status = json['status'];
    createdAt = json['createdAt'];
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

class BookingSlotsResponse {
  bool? success;
  int? statusCode;
  String? message;
  List<BookingSlot>? data;

  BookingSlotsResponse({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  BookingSlotsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BookingSlot>[];
      json['data'].forEach((v) {
        data!.add(BookingSlot.fromJson(v));
      });
    }
  }
}

class BookingSlot {
  String? sId;
  String? date;
  String? time;
  bool? isBooked;

  BookingSlot({this.sId, this.date, this.time, this.isBooked});

  BookingSlot.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    date = json['date'];
    time = json['time'];
    isBooked = json['isBooked'];
  }
}

class ExpertProfileModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  ExpertProfileModel({this.success, this.statusCode, this.message, this.data});

  ExpertProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  String? headline;
  String? bio;
  String? photoUrl;
  String? coverPhoto;
  String? phoneNumber;
  String? timeZone;
  String? priceRange;
  List<String>? expertise;
  bool? isTopExpert;
  List<String>? skills;
  List<String>? languages;
  List<String>? advisingStyles;
  Education? education;
  BankDetails? bankDetails;
  PushNotify? pushNotify;
  EmailNotify? emailNotify;
  int? hourlyRate;
  String? role;
  int? following;
  int? followers;
  int? points;
  int? advisingTime;
  dynamic avgRating;
  String? referredBy;
  String? status;
  String? id;
  List<Availability>? availability;
  List<SocialProfiles>? socialProfiles;
  List<SessionDurations>? sessionDurations;
  String? referralCode;
  String? createdAt;
  int? totalBookings;
  int? profileSetupProgress;
  int? advisingTimeInHours;
  int? avgAttendance;
  bool? isFollowing;
  int? profileViewCount;
  dynamic totalWithdraw;
  dynamic pendingWithdraw;
  dynamic followerGrowthRate;
  Data({
    this.sId,
    this.firstName,
    this.lastName,
    this.email,
    this.headline,
    this.bio,
    this.photoUrl,
    this.coverPhoto,
    this.phoneNumber,
    this.timeZone,
    this.priceRange,
    this.expertise,
    this.isTopExpert,
    this.skills,
    this.languages,
    this.advisingStyles,
    this.bankDetails,
    this.pushNotify,
    this.emailNotify,
    this.hourlyRate,
    this.role,
    this.education,
    this.following,
    this.followers,
    this.points,
    this.advisingTime,
    this.avgRating,
    this.referredBy,
    this.status,
    this.id,
    this.availability,
    this.socialProfiles,
    this.sessionDurations,
    this.referralCode,
    this.createdAt,
    this.totalBookings,
    this.profileSetupProgress,
    this.advisingTimeInHours,
    this.avgAttendance,
    this.isFollowing,
    this.profileViewCount,
    this.totalWithdraw,
    this.pendingWithdraw,
    this.followerGrowthRate,
  });

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    headline = json['headline'];
    bio = json['bio'];
    photoUrl = json['photoUrl'];
    coverPhoto = json['coverPhoto'];
    phoneNumber = json['phoneNumber'];
    timeZone = json['timeZone'];
    priceRange = json['priceRange'];

    expertise = json['expertise'].cast<String>();
    isTopExpert = json['isTopExpert'];

    skills = json['skills'].cast<String>();
    languages = json['languages'].cast<String>();
    advisingStyles = json['advisingStyles'].cast<String>();
    bankDetails = json['bankDetails'] != null
        ? BankDetails.fromJson(json['bankDetails'])
        : null;
    education = json['education'] != null
        ? Education.fromJson(json['education'])
        : null;
    pushNotify = json['pushNotify'] != null
        ? PushNotify.fromJson(json['pushNotify'])
        : null;
    emailNotify = json['emailNotify'] != null
        ? EmailNotify.fromJson(json['emailNotify'])
        : null;
    hourlyRate = json['hourlyRate'];
    role = json['role'];
    following = json['following'];
    followers = json['followers'];
    points = json['points'];
    advisingTime = json['advisingTime'];
    avgRating = json['avgRating'];
    referredBy = json['referredBy'];
    status = json['status'];
    id = json['id'];
    if (json['availability'] != null) {
      availability = <Availability>[];
      json['availability'].forEach((v) {
        availability!.add(Availability.fromJson(v));
      });
    }
    if (json['socialProfiles'] != null) {
      socialProfiles = <SocialProfiles>[];
      json['socialProfiles'].forEach((v) {
        socialProfiles!.add(SocialProfiles.fromJson(v));
      });
    }
    if (json['sessionDurations'] != null) {
      sessionDurations = <SessionDurations>[];
      json['sessionDurations'].forEach((v) {
        sessionDurations!.add(SessionDurations.fromJson(v));
      });
    }
    referralCode = json['referralCode'];
    createdAt = json['createdAt'];
    totalBookings = json['totalBookings'];
    profileSetupProgress = json['profileSetupProgress'];
    advisingTimeInHours = json['advisingTimeInHours'];
    avgAttendance = json['avgAttendance'];
    isFollowing = json['isFollowing'];
    profileViewCount = json['profileViewCount'];
    totalWithdraw = json['totalWithdraw'];
    pendingWithdraw = json['pendingWithdraw'];
    followerGrowthRate = json['followerGrowthRate'];
  }
}

class BankDetails {
  String? bankName;
  int? number;
  String? sortCode;

  BankDetails({this.bankName, this.number, this.sortCode});

  BankDetails.fromJson(Map<String, dynamic> json) {
    bankName = json['bankName'];
    number = json['number'];
    sortCode = json['sortCode'];
  }
}

class Availability {
  String? day;
  List<Slots>? slots;

  Availability({this.day, this.slots});

  Availability.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    if (json['slots'] != null) {
      slots = <Slots>[];
      json['slots'].forEach((v) {
        slots!.add(Slots.fromJson(v));
      });
    }
  }
}

class Slots {
  String? from;
  String? to;

  Slots({this.from, this.to});

  Slots.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
  }
}

class SocialProfiles {
  String? type;
  String? url;

  SocialProfiles({this.type, this.url});

  SocialProfiles.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    url = json['url'];
  }
}

class SessionDurations {
  String? type;
  int? duration;
  dynamic price;
  bool? isOffered;

  SessionDurations({this.type, this.duration, this.price, this.isOffered});

  SessionDurations.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    duration = json['duration'];
    price = json['price'];
    isOffered = json['isOffered'];
  }
}

class PushNotify {
  bool? bookingAndSchedule;
  bool? scheduleRemainder;
  bool? payment;
  bool? points;
  bool? followers;
  bool? post;
  bool? reviews;

  PushNotify({
    this.bookingAndSchedule,
    this.scheduleRemainder,
    this.payment,
    this.points,
    this.followers,
    this.post,
    this.reviews,
  });

  PushNotify.fromJson(Map<String, dynamic> json) {
    bookingAndSchedule = json['bookingAndSchedule'];
    scheduleRemainder = json['scheduleRemainder'];
    payment = json['payment'];
    points = json['points'];
    followers = json['followers'];
    post = json['post'];
    reviews = json['reviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bookingAndSchedule'] = bookingAndSchedule;
    data['scheduleRemainder'] = scheduleRemainder;
    data['payment'] = payment;
    data['points'] = points;
    data['followers'] = followers;
    data['post'] = post;
    data['reviews'] = reviews;
    return data;
  }
}

class EmailNotify {
  bool? booking;
  bool? schedule;
  bool? payment;

  EmailNotify({this.booking, this.schedule, this.payment});

  EmailNotify.fromJson(Map<String, dynamic> json) {
    booking = json['booking'];
    schedule = json['schedule'];
    payment = json['payment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['booking'] = booking;
    data['schedule'] = schedule;
    data['payment'] = payment;
    return data;
  }
}

class Education {
  String? degree;
  List<String>? certificate;
  String? phd;

  Education({this.degree, this.certificate, this.phd});

  Education.fromJson(Map<String, dynamic> json) {
    degree = json['degree'];
    certificate = json['certificate'].cast<String>();
    phd = json['phd'];
  }
}

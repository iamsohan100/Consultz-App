class ExpertSetProfileModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  ExpertSetProfileModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  ExpertSetProfileModel.fromJson(Map<String, dynamic> json) {
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
  List<String>? expertise;
  List<String>? languages;
  List<String>? skills;
  List<String>? advisingStyles;
  BankDetails? bankDetails;
  int? hourlyRate;
  int? following;
  int? followers;
  int? points;
  int? advisingTime;
  dynamic avgRating;
  String? status;
  String? id;
  List<Availability>? availability;
  List<SocialProfiles>? socialProfiles;
  List<SessionDurations>? sessionDurations;
  String? createdAt;
  dynamic profileSetupProgress;

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
    this.expertise,
    this.languages,
    this.skills,
    this.advisingStyles,
    this.bankDetails,
    this.hourlyRate,
    this.following,
    this.followers,
    this.points,
    this.advisingTime,
    this.avgRating,
    this.status,
    this.id,
    this.availability,
    this.socialProfiles,
    this.sessionDurations,
    this.createdAt,
    this.profileSetupProgress,
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
    expertise = json['expertise'].cast<String>();
    languages = json['languages'].cast<String>();
    skills = json['skills'].cast<String>();
    advisingStyles = json['advisingStyles'].cast<String>();
    bankDetails = json['bankDetails'] != null
        ? BankDetails.fromJson(json['bankDetails'])
        : null;
    hourlyRate = json['hourlyRate'];
    following = json['following'];
    followers = json['followers'];
    points = json['points'];
    advisingTime = json['advisingTime'];
    avgRating = json['avgRating'];
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
    createdAt = json['createdAt'];
    profileSetupProgress = json['profileSetupProgress'];
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
  bool? isOffered;

  SessionDurations({this.type, this.duration, this.isOffered});

  SessionDurations.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    duration = json['duration'];
    isOffered = json['isOffered'];
  }
}

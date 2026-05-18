import 'dart:io';

class ExpertProfileSetupModel {
  final List<SocialProfile>? socialProfiles;
  final int? hourlyRate;
  final BankDetails? bankDetails;
  final String? expertise;
  final List<String>? skills;
  final List<String>? advisingStyles;
  final String? bio;
  final String? timeZone;
  final List<SessionDuration>? sessionDurations;
  final List<Availability>? availability;
  final bool? isProfileSetup;
  final File? image;

  ExpertProfileSetupModel({
     this.socialProfiles,
     this.hourlyRate,
     this.bankDetails,
     this.expertise,
     this.skills,
     this.advisingStyles,
     this.bio,
     this.timeZone,
     this.sessionDurations,
     this.availability,
     this.isProfileSetup,
     this.image,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "data": {
        "socialProfiles": socialProfiles?.map((e) => e.toJson()).toList(),
        "hourlyRate": hourlyRate,
        "bankDetails": bankDetails?.toJson(),
        "expertise": expertise,
        "skills": skills,
        "advisingStyles": advisingStyles,
        "bio": bio,
        "timeZone": timeZone,
        "sessionDurations": sessionDurations?.map((e) => e.toJson()).toList(),
        "availability": availability?.map((e) => e.toJson()).toList(),
        "isProfileSetup": isProfileSetup,
      },
    };
  }

  Map<String, File?> fileJson() {
    return <String, File?>{'image': image};
  }
}

class SocialProfile {
   String type;
   String url;

  SocialProfile({required this.type, required this.url});

  Map<String, dynamic> toJson() => {"type": type, "url": url};
}

class BankDetails {
  final String bankName;
  final int number;
  final String sortCode;

  BankDetails({
    required this.bankName,
    required this.number,
    required this.sortCode,
  });

  Map<String, dynamic> toJson() => {
    "bankName": bankName,
    "number": number,
    "sortCode": sortCode,
  };
}

class SessionDuration {
  final String type;
  final int duration;
  final bool isOffered;

  SessionDuration({
    required this.type,
    required this.duration,
    required this.isOffered,
  });

  Map<String, dynamic> toJson() => {
    "type": type,
    "duration": duration,
    "isOffered": isOffered,
  };
}

class Availability {
  final String day;
  final String from;
  final String to;

  Availability({required this.day, required this.from, required this.to});

  Map<String, dynamic> toJson() => {"day": day, "from": from, "to": to};
}

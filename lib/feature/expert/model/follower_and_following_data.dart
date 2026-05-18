class FollowerAndFollowingData {
  String? sId;
  String? firstName;
  String? lastName;
  String? headline;
  String? photoUrl;
  bool? isFollowing;
String? role;
  FollowerAndFollowingData({
    this.sId,
    this.firstName,
    this.lastName,
    this.headline,
    this.photoUrl,
    this.isFollowing,
    this.role,
  });

  FollowerAndFollowingData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    headline = json['headline'];
    photoUrl = json['photoUrl'];
    isFollowing = json['isFollowing'];
    role = json['role'];
  }
}
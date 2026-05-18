import 'package:consultz/core/constants/app_images.dart';

class FollowerData {
  static List<FollowerModel> followerData = [
    FollowerModel(
      image: AppImages.review3,
      name: 'Noah Martinez',
      title: 'Software engineer',
      isFollowing: true,
    ),
    FollowerModel(
      image: AppImages.expert3,
      name: 'Sophia Lee',
      title: 'Marketing manager',
      isFollowing: false,
    ),
    FollowerModel(
      image: AppImages.expert2,
      name: 'Ethan Hernandez',
      title: 'Product manager',
      isFollowing: true,
    ),
    FollowerModel(
      image: AppImages.expert1,
      name: 'Isabella Perez',
      title: 'UX researcher',
      isFollowing: false,
    ),
  ];
  static List<FollowerModel> followingData = [
    FollowerModel(
      image: AppImages.expert2,
      name: 'Ethan Hernandez',
      title: 'Product manager',
      isFollowing: false,
    ),
    FollowerModel(
      image: AppImages.expert1,
      name: 'Isabella Perez',
      title: 'UX researcher',
      isFollowing: true,
    ),
    FollowerModel(
      image: AppImages.review3,
      name: 'Noah Martinez',
      title: 'Software engineer',
      isFollowing: false,
    ),
    FollowerModel(
      image: AppImages.expert3,
      name: 'Sophia Lee',
      title: 'Marketing manager',
      isFollowing: true,
    ),
  ];
}

class FollowerModel {
  String image;
  String name;
  String title;
  bool isFollowing;
  FollowerModel({
    required this.image,
    required this.name,
    required this.title,
    required this.isFollowing,
  });
}

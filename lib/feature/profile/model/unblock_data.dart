import 'package:consultz/core/constants/app_images.dart';

class UnblockData {
  static List<UnblockModel> unblockList = [
    UnblockModel(
      image: AppImages.review3,
      name: 'Noah Martinez',
      title: 'Software engineer',
    ),
    UnblockModel(
      image: AppImages.expert3,
      name: 'Sophia Lee',
      title: 'Marketing manager',
    ),
    UnblockModel(
      image: AppImages.expert2,
      name: 'Ethan Hernandez',
      title: 'Product manager',
    ),
    UnblockModel(
      image: AppImages.expert1,
      name: 'Isabella Perez',
      title: 'UX researcher',
    ),
  ];
}

class UnblockModel {
  String image;
  String name;
  String title;
  UnblockModel({required this.image, required this.name, required this.title});
}

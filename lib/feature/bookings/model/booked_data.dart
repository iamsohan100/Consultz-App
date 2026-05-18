import 'package:consultz/core/constants/app_images.dart';

class BookedData {
  static List<BookedModel> bookedList = [
    BookedModel(
      image: AppImages.expert3,
      title: 'Introduction',
      duration: '15 Minutes',
      status: 'Up next',
      name: 'Sam Jones',
    ),
    BookedModel(
      image: AppImages.expert2,
      title: 'Introduction',
      duration: '15 Minutes',
      status: 'Confirmed',
      name: 'Stella Lee',
    ),
    BookedModel(
      image: AppImages.expert1,
      title: 'Discussion',
      duration: '30 Minutes',
      status: 'Pending',
      name: 'Annika Palmari',
    ),
  ];
}

class BookedModel {
  String image;
  String title;
  String duration;
  String status;
  String name;

  BookedModel({
    required this.image,
    required this.title,
    required this.duration,
    required this.status,
    required this.name,
  });
}

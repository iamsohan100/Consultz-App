import 'package:consultz/core/constants/app_images.dart';

class ReviewData {
  static List<ReviewModel> reviewList = [
    ReviewModel(
      image: AppImages.review1,
      name: 'Lisa P.',
      session: 'Discussion session',
      time: '・Aug 28, 2024',
      review:
          'I was blown away by Kristy’s depth of knowledge in business operations. Her communication is straightforward and warm, making it easy to follow complex topics. I left the session feeling motivated😁',
    ),
    ReviewModel(
      image: AppImages.review2,
      name: 'Stella L.',
      session: 'Deep dive session',
      time: '・Aug 17, 2024',
      review:
          'Clear communication, the hour I spent with Kristy was really insightful. I learned alot!! ',
    ),
    ReviewModel(
      image: AppImages.review3,
      name: 'James B.',
      session: 'Discussion session',
      time: '・Jul 04, 2024',
      review:
          'Working with Kristy has been a highlight in my journey as a small business owner💥🤝',
    ),
  ];
}

class ReviewModel {
  String image;
  String name;
  String session;
  String time;
  String review;

  ReviewModel({
    required this.image,
    required this.name,
    required this.session,
    required this.time,
    required this.review,
  });
}

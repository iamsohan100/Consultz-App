import 'package:consultz/core/constants/app_images.dart';

class BrowseFirstPageModel {
  static List<BrowseModel> browseData = [
    BrowseModel(
      title: "Join as\na consultee",
      features: [
        "✓ Tailored expert advice ",
        "✓ One-to-one consultation",
        "✓ No membership fee",
      ],
      image: AppImages.joinConsultee,
      status: 'consultee',
    ),

    BrowseModel(
      title: "Join as\nan expert",
      features: [
        "To join as an expert, you’ll need a referral link from an existing Consultz expert.",
      ],
      image: AppImages.joinExpert,
      status: 'expert',
    ),
  ];
}

class BrowseModel {
  String title;
  List<String> features;
  String image;
  String status;
  BrowseModel({
    required this.title,
    required this.features,
    required this.image,
    required this.status,
  });
}

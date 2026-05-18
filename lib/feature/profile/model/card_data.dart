import 'package:consultz/core/constants/app_images.dart';

class CardData {
  static List<CardModel> cardList = [
    CardModel(
      cardName: 'VISA Debit (1234)',
      userName: 'Sam Jones',
      cardImage: AppImages.visa,
      exp: 'Exp: 10/28',
      status: 'Default payment method',
    ),
    CardModel(
      cardName: 'AMEX Credit (1234)',
      userName: 'Sam Jones',
      cardImage: AppImages.americanExpress,
      exp: 'Exp: 02/25',
      status: 'This card has expired',
      isExpired: true,
    ),
  ];
}

class CardModel {
  String cardName;
  String userName;
  String cardImage;
  String exp;
  String status;
  bool? isExpired;
  CardModel({
    required this.cardName,
    required this.userName,
    required this.cardImage,
    required this.exp,
    required this.status,
    this.isExpired,
  });
}

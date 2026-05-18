import 'package:get/get.dart';

class SessionData {
  static List<SessionModel> sessionList = [
    SessionModel(title: 'Introduction', duration: 15, amount: '£50.00'),
    SessionModel(title: 'Discussion', duration: 30, amount: '£100.00'),
    SessionModel(title: 'Deep dive', duration: 60, amount: '£200.00'),
  ];
}

class SessionModel {
  String title;
  int duration;
  String amount;
  RxBool isSelected;

  SessionModel({
    required this.title,
    required this.duration,
    required this.amount,
    bool isSelected = false,
  }) : isSelected = isSelected.obs;
}



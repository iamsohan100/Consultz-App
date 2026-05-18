import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/widgets/notification_bell.dart';
import 'package:consultz/feature/Auth/widgets/app_bar_coin.dart';
import 'package:flutter/material.dart';

AppBar bookingsAppBar(
  double height,
  double scaleFactor,
  BuildContext context,
  double width,
  String title,
) {
  return customAppBar(
    context: context,
    isLeading: false,
    title: title,
    fontSize: 24,
    actions: [
      AppBarCoin(),
      SizedBox(width: width * 0.02),
      NotificationBell(),
      SizedBox(width: width * 0.02),
    ],
  );
}

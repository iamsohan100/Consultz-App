import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/widgets/notification_bell.dart';
import 'package:consultz/feature/Auth/widgets/app_bar_coin.dart';
import 'package:flutter/material.dart';


AppBar bookingDetaailsAppBar(BuildContext context) {
  double width = Screen.screenWidth(context);
  // double scaleFactor = width / Screen.designWidth;
  return customAppBar(
    context: context,
    fontSize: 24,
    actions: [
      AppBarCoin(),
      SizedBox(width: width * 0.02),
      NotificationBell(),
      SizedBox(width: width * 0.02),
    ],
  );
}

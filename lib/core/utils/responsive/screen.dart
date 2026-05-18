import 'package:flutter/material.dart';

class Screen {
  static double designHeight = 812;
  static double designWidth = 375;

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
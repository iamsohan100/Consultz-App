import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/feature/bookings/widgets/bookings_appbar.dart';
import 'package:consultz/feature/bookings/widgets/consultee_part.dart';
import 'package:consultz/feature/bookings/widgets/expert_part.dart';
import 'package:consultz/feature/Auth/controller/browse_first_controller.dart';
import 'package:consultz/feature/main/controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final browseFirstController = Get.find<BrowseFirstController>();
    return PopScope(
      canPop: false,
      // ignore: deprecated_member_use
      onPopInvoked: (_) {
        Get.find<MainController>().changeIndex(index: 0);
      },
      child: Scaffold(
        appBar: bookingsAppBar(height, scaleFactor, context, width, 'Bookings'),

        body: SafeArea(
          child: SingleChildScrollView(
            child: Builder(
              builder: (context) {
                if (browseFirstController.isConsultee.value) {
                  return ConsulteePart();
                } else {
                  return ExpertPart();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

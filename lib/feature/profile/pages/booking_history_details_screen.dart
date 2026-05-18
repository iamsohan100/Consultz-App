import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/text/custom_rich_text.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/profile/widgets/booking_detail_container.dart';
import 'package:consultz/feature/Auth/controller/browse_first_controller.dart';
import 'package:consultz/feature/profile/controller/booking_history_details_controller.dart';
import 'package:consultz/feature/expert/controller/pdf_invoice_generator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookingHistoryDetailsScreen extends StatelessWidget {
  const BookingHistoryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    final bookingDetailsController = Get.find<BookingHistoryDetailsController>();
    final browseFirstController = Get.find<BrowseFirstController>();

    return Scaffold(
      appBar: customAppBar(context: context, title: 'Booking history'),
      body: SafeArea(
        child: Obx(() {
          final details = bookingDetailsController.bookingDetails.value;

          if (details == null) {
            return const Center(child: Text("Could not load booking details"));
          }

          bool isConsultee = browseFirstController.isConsultee.value;
          String name = isConsultee
              ? '${details.consult?.firstName ?? ''} ${details.consult?.lastName ?? ''}'
              : '${details.user?.firstName ?? ''} ${details.user?.lastName ?? ''}';
          name = name.trim();

          String sessionTypeDisplay =
              details.sessionType?.replaceAll('_', ' ') ?? '';
          if (sessionTypeDisplay.isNotEmpty) {
            sessionTypeDisplay =
                sessionTypeDisplay[0].toUpperCase() +
                sessionTypeDisplay.substring(1);
          }

          String date = details.slot?.date ?? '';
          if (date.isNotEmpty) {
            try {
              DateTime parsedDate = DateTime.parse(date);
              date = DateFormat('MMM dd').format(parsedDate);
            } catch (e) {
              date = "${date.substring(5, 7)}-${date.substring(8)}";
            }
          }

          String time = details.slot?.time ?? '';

          return SingleChildScrollView(
            child: Column(
              spacing: height * 0.01,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: const Color(0xFFF8F8F8),
                  child: ListTile(
                    leading: Icon(
                      details.status == 'completed'
                          ? Icons.check_circle_rounded
                          : Icons.access_time_filled,
                      color: details.status == 'completed'
                          ? AppColors.green
                          : AppColors.primaryColor,
                      size: scaleFactor * 26,
                    ),
                    title: CustomRichText(
                      text1: name,
                      color1: AppColors.black,
                      fontSize1: 14,
                      fontWeight: FontWeight.w700,
                      text2: ' - $sessionTypeDisplay',
                      color2: AppColors.darkGrey,
                      fontSize2: 14,
                      fontWeight2: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.all(scaleFactor * 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: height * 0.014,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                PdfInvoiceGenerator.generateAndDownloadInvoice(
                                  booking: details,
                                  isConsultee: isConsultee,
                                );
                              },
                              child: BookingDetailContainer(
                                title: '£${details.price ?? 0}',
                                subtitle: isConsultee
                                    ? 'Total paid'
                                    : 'Total recieved',
                                titleColor: AppColors.black,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: width * 0.02,
                                  children: [
                                    CustomText(
                                      text: 'Download invoice',
                                      color: AppColors.darkGrey,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    Image.asset(
                                      AppImages.download,
                                      width: scaleFactor * 9,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: width * 0.03),
                          Expanded(
                            child: BookingDetailContainer(
                              title: details.status != null
                                  ? details.status![0].toUpperCase() +
                                        details.status!.substring(1)
                                  : 'Unknown',
                              subtitle: date,
                              titleColor: AppColors.green,
                              child: CustomText(
                                text: time,
                                color: AppColors.darkGrey,
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

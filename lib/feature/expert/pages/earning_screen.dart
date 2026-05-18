import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/loading.dart/circle_loading.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/core/utils/widgets/no_data.dart';
import 'package:consultz/feature/expert/controller/withdraw_controller.dart';
import 'package:consultz/feature/expert/widgets/earning_chart.dart';
import 'package:consultz/feature/expert/widgets/earning_history_container.dart';
import 'package:consultz/feature/expert/widgets/select_earning_year.dart';
import 'package:consultz/feature/profile/widgets/booking_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EarningScreen extends StatefulWidget {
  const EarningScreen({super.key});

  @override
  State<EarningScreen> createState() => _EarningScreenState();
}

class _EarningScreenState extends State<EarningScreen> {
  final controller = Get.find<WithdrawController>();

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Earning',
        actions: [
          SelectEarningYear(),
          SizedBox(width: scaleFactor * 14),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: controller.scrollController,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: scaleFactor * 14,
              vertical: height * 0.01,
            ),
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EarningChart(
                    overview: controller.withdrawOverview,
                    total: controller.thisMonthWithdraw.value,
                  ),
                  SizedBox(height: height * 0.01),
                  CustomText(
                    text: 'History (${controller.selectedYear.value})',
                    color: AppColors.darkGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: height * 0.01),

                  if (controller.inProgress.value)
                    const BookingShimmer(length: 5)
                  else if (controller.withdrawItems.isEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.05),
                      child: const NoData(text: 'No transactions found'),
                    )
                  else
                    ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.withdrawItems.length,
                      itemBuilder: (context, index) {
                        return EarningHistoryContainer(
                          item: controller.withdrawItems[index],
                        );
                      },
                    ),

                  // Bottom loading indicator
                  if (controller.isLoadingMore.value)
                    const CircleLoading(top: 0),

                  // No more items indicator
                  if (!controller.hasMore.value &&
                      controller.withdrawItems.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.02),
                      child: Center(
                        child: CustomText(
                          text: 'No more items',
                          color: AppColors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

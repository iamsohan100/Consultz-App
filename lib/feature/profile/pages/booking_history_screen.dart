import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/feature/profile/widgets/booking_history_container.dart';
import 'package:consultz/feature/profile/widgets/booking_shimmer.dart';
import 'package:consultz/core/utils/loading.dart/circle_loading.dart';
import 'package:consultz/core/utils/widgets/no_data.dart';
import 'package:consultz/feature/profile/widgets/filter_booking_history_button.dart';
import 'package:consultz/feature/profile/controller/booking_history_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingHistoryScreen extends StatefulWidget {
  const BookingHistoryScreen({super.key});

  @override
  State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
  final bookingViewModel = Get.find<BookingHistoryController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bookingViewModel.scrollController.addListener(() {
        if (bookingViewModel.scrollController.position.pixels >=
                bookingViewModel.scrollController.position.maxScrollExtent -
                    200 &&
            !bookingViewModel.isLoadingMore.value &&
            bookingViewModel.hasMore.value) {
          bookingViewModel.loadMore();
        }
      });
      if (bookingViewModel.bookingList.isEmpty) {
        bookingViewModel.initialLoad();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return Scaffold(
      appBar: customAppBar(context: context, title: 'Booking history'),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: bookingViewModel.scrollController,
          child: Padding(
            padding: EdgeInsetsGeometry.only(
              top: height * 0.01,
              bottom: height * 0.02,
            ),
            child: Obx(() {
              final bookings = bookingViewModel.bookingList;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: scaleFactor * 16,
                      right: scaleFactor * 16,
                      bottom: scaleFactor * 16,
                    ),
                    child: const FilterBookingHistoryButton(),
                  ),
                  if (bookingViewModel.inProgress.value)
                    const BookingShimmer()
                  else if (bookings.isEmpty)
                    const NoData(text: 'No bookings yet')
                  else
                    ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: bookings.length,
                      itemBuilder: (context, index) {
                        return BookingHistoryContainer(
                          bookingModel: bookings[index],
                        );
                      },
                    ),

                  // Bottom loading indicator
                  if (bookingViewModel.isLoadingMore.value)
                    const CircleLoading(top: 0),

                  // No more reviews indicator
                  if (!bookingViewModel.hasMore.value && bookings.isNotEmpty)
                    const NoData(text: 'No more bookings'),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

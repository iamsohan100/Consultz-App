import 'package:consultz/feature/bookings/model/message_data.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/feature/bookings/widgets/accept_dicline_button.dart';
import 'package:consultz/feature/bookings/widgets/booking_details_app_bar.dart';
import 'package:consultz/feature/bookings/widgets/discussion_message.dart';
import 'package:consultz/feature/bookings/widgets/discussion_profile.dart';
import 'package:consultz/feature/bookings/widgets/join_call_button.dart';
import 'package:consultz/feature/bookings/widgets/message_container.dart';

import 'package:consultz/core/utils/widgets/no_data.dart';
import 'package:consultz/feature/Auth/controller/browse_first_controller.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/feature/bookings/controller/booking_details_controller.dart';
import 'package:consultz/feature/bookings/widgets/countdown_join_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:consultz/core/utils/helper/time_helper.dart';

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BookingDetailsController>();
    final profileController = Get.find<ProfileController>();

    final args = Get.arguments as bool?;
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return Scaffold(
      appBar: bookingDetaailsAppBar(context),
      bottomNavigationBar: Obx(() {
        final details = controller.bookingDetails.value;
        final browseFirstController = Get.find<BrowseFirstController>();
        final currentUserId =
            profileController.expertProfileModel.value.data?.sId;
        final bool isMe = details?.user?.sId == currentUserId;
        String participantName = '';
        if (details != null) {
          if (browseFirstController.isConsultee.value) {
            participantName =
                '${details.consult?.firstName ?? ''} ${details.consult?.lastName ?? ''}';
          } else {
            participantName =
                '${details.user?.firstName ?? ''} ${details.user?.lastName ?? ''}';
          }
        }

        if (details?.status?.toLowerCase() == 'pending') {
          final profileController = Get.find<ProfileController>();
          final currentUserId =
              profileController.expertProfileModel.value.data?.sId;
          final bool isMe = details?.user?.sId == currentUserId;

          if (isMe) {
            return const SizedBox.shrink();
          }
          return AcceptDiclineButton(expertId: details?.consult?.sId ?? '');
        } else if (details?.status?.toLowerCase() == 'confirmed' ||
            details?.status?.toLowerCase() == 'up next') {
          DateTime? startTime;
          final slot = details?.slot;
          if (slot?.date != null && slot?.time != null) {
            startTime = TimeHelper.utcToLocalDateTime(slot!.date!, slot.time!);
          }

          if (startTime != null) {
            return CountdownJoinButton(
              startTime: startTime,
              name: participantName.trim(),
              duration: details?.sessionDuration ?? 0,
              bookingId: details?.sId ?? '',
              receiverUserId: isMe
                  ? details?.consult?.sId ?? ''
                  : details?.user?.sId ?? '',
              image: isMe
                  ? details?.consult?.photoUrl ?? ''
                  : details?.user?.photoUrl ?? '',
              status: details?.status,
            );
          }

          // If no startTime, directly show JoinCallButton
          return JoinCallButton(
            name: participantName.trim(),
            receiverUserId: isMe
                ? details?.consult?.sId ?? ''
                : details?.user?.sId ?? '',
            image: isMe
                ? details?.consult?.photoUrl ?? ''
                : details?.user?.photoUrl ?? '',
            bookingId: details?.sId ?? '',
          );
        }
        return const SizedBox.shrink();
      }),
      body: SafeArea(
        child: Obx(() {
          final details = controller.bookingDetails.value;
          if (details == null) {
            return const NoData(text: 'No bookings details found');
          }

          final List<MessageModel> questions = [
            MessageModel(
              qus: 'What is the main question you’d like answered?',
              ans: details.mainQuestion ?? 'N/A',
            ),
            MessageModel(
              qus: 'What challenges or roadblocks are you facing?',
              ans: details.challengeQuestion ?? 'N/A',
            ),
            MessageModel(
              qus: 'Can you share some background or context?',
              ans: details.backgroundQuestion ?? 'N/A',
            ),
          ];

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsetsGeometry.only(
                left: scaleFactor * 20,
                right: scaleFactor * 20,
                bottom: scaleFactor * 20,
              ),
              child: Column(
                children: [
                  DiscussionMessage(joinCall: args, details: details),
                  SizedBox(height: height * 0.01),
                  DiscussionProfile(details: details),
                  SizedBox(height: height * 0.025),
                  ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: questions.length,
                    itemBuilder: (_, index) {
                      return MessageContainer(
                        messageModel: questions[index],
                        index: index,
                        photoUrl: details.user?.photoUrl,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

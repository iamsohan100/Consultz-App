
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/feature/bookings/controller/socket_service_controller.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/loading.dart/circle_loading.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/widgets/no_data.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/feature/bookings/controller/msg_controller.dart';
import 'package:consultz/feature/bookings/widgets/first_person_msg_card.dart';
import 'package:consultz/feature/bookings/widgets/msg_field.dart';
import 'package:consultz/feature/bookings/widgets/second_person_msg_card.dart';
import 'package:consultz/feature/bookings/widgets/message_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MsgScreen extends StatefulWidget {
  const MsgScreen({super.key});

  @override
  State<MsgScreen> createState() => _MsgScreenState();
}

class _MsgScreenState extends State<MsgScreen> {
  final msgController = Get.find<MsgController>();
  final socketController = Get.find<SocketServiceController>();
  final profileController = Get.find<ProfileController>();
  String? bookingId;
  String? receiverId;
  String? personName;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args is Map) {
      personName = args['personName'];
      bookingId = args['bookingId'];
      receiverId = args['receiverId'];
    } else {
      personName = args;
    }

    if (bookingId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        msgController.initialLoad(bookingId!);
        socketController.newMessageOn();
      });
    }
  }

  @override
  void dispose() {
    socketController.socket?.off('new-message');
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    final String title = personName ?? 'Message';
    final currentUserId = profileController.expertProfileModel.value.data?.sId;

    return Scaffold(
      appBar: customAppBar(title: title, context: context),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: scaleFactor * 20),
              child: Obx(() {
                if (msgController.inProgress.value) {
                  return const MessageShimmer();
                }

                if (msgController.messageList.isEmpty) {
                  return Column(
                    children: [
                      SizedBox(height: height * 0.25),
                      Icon(
                        Icons.message_outlined,
                        size: scaleFactor * 50,
                        color: AppColors.grey,
                      ),
                      NoData(text: "No messages yet"),
                    ],
                  );
                }

                return ListView.separated(
                  controller: msgController.scrollController,
                  reverse: true,
                  itemCount:
                      msgController.messageList.length +
                      (msgController.isLoadingMore.value ? 1 : 0),
                  itemBuilder: (_, index) {
                    if (index == msgController.messageList.length) {
                      return CircleLoading(top: 0);
                    }

                    final message = msgController.messageList[index];
                    final isMe = message.sender?.sId == currentUserId;

                    return isMe
                        ? FirstPersonMsgCard(message: message)
                        : SecondPersonMsgCard(message: message);
                  },
                  separatorBuilder: (context, index) =>
                      SizedBox(height: height * 0.01),
                );
              }),
            ),
          ),
          MessageField(bookingId: bookingId!, receiverId: receiverId!),
        ],
      ),
    );
  }
}

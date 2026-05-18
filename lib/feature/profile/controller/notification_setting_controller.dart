// ignore_for_file: use_build_context_synchronously
import 'package:consultz/core/network/api_caller.dart';
import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/feature/profile/model/notification_setting_model.dart';
import 'package:get/get.dart';

class NotificationSettingController extends GetxController {
  Rx<NotificationSettingModel> notificationSettingModel =
      NotificationSettingModel().obs;
  Future<bool> changeNotifiy() async {
    final profileController = Get.find<ProfileController>();
    final data = profileController.expertProfileModel.value.data;
    final pushNotify = data?.pushNotify;
    final emailNotify = data?.emailNotify;
    bool isSuccess = true;

    try {
      final response = await ApiCaller.patchRequest(
        url: ApiUrls.changeNotify,
        body: {
          "pushNotify": pushNotify?.toJson(),
          "emailNotify": emailNotify?.toJson(),
        },
      );
      // log("${response?.responseData.toString()}");
      if (response?.statusCode == 200 && response?.isSuccess == true) {
        notificationSettingModel.value = NotificationSettingModel.fromJson(
          response?.responseData,
        );
      } else {
        bottomMessage(msg: response?.message);
        isSuccess = false;
      }
    } catch (e) {
      bottomMessage(msg: e.toString());
      isSuccess = false;
    }

    return isSuccess;
  }
}

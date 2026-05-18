import 'package:get/get.dart';

class MainController extends GetxController {
  final curentIndex = 0.obs;
  void changeIndex({required int index}) {
    // final user = AuthPreference.logInInfo;

    if (index != curentIndex.value) {
      // if (user?.data?.user?.status == 'pending') {
      //   bottomMessage(
      //     msg:
      //         "Your account is currently pending approval. Please wait until it is approved.",
      //   );
      // }
      //  else {
      curentIndex.value = index;
      // }
    }
  }
}

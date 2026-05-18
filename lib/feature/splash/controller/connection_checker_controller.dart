import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectionCheckerController extends GetxController {
  RxBool hasInternet = true.obs;

  @override
  void onInit() {
    super.onInit();
    checkInitialConnection();
    _monitorConnection();
  }

  void _monitorConnection() {
    Connectivity().onConnectivityChanged.listen((status) async {
      hasInternet.value =
          await InternetConnectionChecker.instance.hasConnection;
    });
  }

  void checkInitialConnection() async {
    hasInternet.value = await InternetConnectionChecker.instance.hasConnection;
  }

}

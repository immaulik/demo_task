import 'package:demo_task/routes/pages.dart';
import 'package:demo_task/utils/enum.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  void onRoleTap(Role role) {
    Get.toNamed(Pages.selectCountry, arguments: role);
  }

  void onTermsOfServiceTap() {
    Get.toNamed(Pages.termsOfService);
  }
}

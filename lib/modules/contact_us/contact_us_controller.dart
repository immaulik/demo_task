import 'package:demo_task/api/api_config.dart';
import 'package:demo_task/api/api_const.dart';
import 'package:demo_task/api/response_model.dart';
import 'package:demo_task/model/user_model.dart';
import 'package:demo_task/routes/pages.dart';
import 'package:demo_task/utils/app_utils.dart';
import 'package:demo_task/utils/custom_snakbar.dart';
import 'package:demo_task/utils/enum.dart';
import 'package:demo_task/utils/logger.dart';
import 'package:get/get.dart';

class ContactUsController extends GetxController {
  RxBool isLogout = false.obs;
  RxBool isDelete = false.obs;

  Future<void> onTapLogout() async {
    try {
      isLogout = true.obs;
      ResponseModel model =
          await ApiConfig.client.postData(ApiConst.logout, {});
      if (model.status) {
        showSnackBar(
            title: model.message,
            subTitle: model.data.toString(),
            type: SnackBarType.success);
        isLogout = false.obs;
        AppUtils.userModel = UserModel();
        Get.offAllNamed(Pages.initialRoute);
      } else {
        showSnackBar(
            title: model.message,
            subTitle: model.data.toString(),
            type: SnackBarType.error);
        isLogout = false.obs;
      }
    } on Exception catch (e) {
      isLogout = false.obs;
      logger.e(e.toString());
      showSnackBar(
          title: "Error", subTitle: e.toString(), type: SnackBarType.error);
    }
  }

  Future<void> onTapDelete() async {
    try {
      isDelete(true);
      ResponseModel model =
          await ApiConfig.client.postData(ApiConst.delete, {});
      if (model.status) {
        showSnackBar(
            title: model.message,
            subTitle: model.data.toString(),
            type: SnackBarType.success);
        isDelete(false);
        AppUtils.userModel = UserModel();
        Get.offAllNamed(Pages.initialRoute);
      } else {
        showSnackBar(
            title: model.message,
            subTitle: model.data.toString(),
            type: SnackBarType.error);
        isDelete(false);
      }
    } on Exception catch (e) {
      isDelete(false);
      logger.e(e.toString());
      showSnackBar(
          title: "Error", subTitle: e.toString(), type: SnackBarType.error);
    }
  }
}

import 'package:demo_task/api/api_config.dart';
import 'package:demo_task/api/api_const.dart';
import 'package:demo_task/api/response_model.dart';
import 'package:demo_task/model/country_model.dart';
import 'package:demo_task/routes/pages.dart';
import 'package:demo_task/utils/custom_snakbar.dart';
import 'package:demo_task/utils/enum.dart';
import 'package:demo_task/utils/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  Role selectedRole = Role.agent;
  CountryModel countryModel = CountryModel();
  RxBool isEnable = false.obs;
  TextEditingController numCTRL = TextEditingController();
  RxBool isOTPScreen = false.obs;
  final formKey = GlobalKey<FormState>();
  String otp = "";
  RxBool isLogin = false.obs;

  @override
  void onInit() {
    selectedRole = Get.arguments[0];
    countryModel = Get.arguments[1];
    super.onInit();
  }

  void onCountryBack() {
    Get.back();
  }

  void onTextChange() {
    numCTRL.addListener(() {
      if (numCTRL.text.isNotEmpty) {
        isEnable(true);
      } else {
        isEnable(false);
      }
    });
  }

  Future<void> getOTP() async {
    if (formKey.currentState!.validate()) {
      await _getOtp();
    }
  }

  Future<void> _getOtp() async {
    try {
      isLogin(true);
      ResponseModel model = await ApiConfig.client.postData(
          selectedRole == Role.student
              ? ApiConst.studentLogin
              : ApiConst.agentLogin,
          {"tel_code": countryModel.telCode, "phone": numCTRL.text});
      if (model.status) {
        showSnackBar(
            title: "Success",
            subTitle: model.message,
            type: SnackBarType.success);
        Get.toNamed(Pages.otpVerify,
            arguments: countryModel.telCode + numCTRL.text);
      } else {
        showSnackBar(
            title: model.message,
            subTitle: model.data,
            type: SnackBarType.error);
      }
      isLogin(false);
    } on Exception catch (e) {
      isLogin(false);
      logger.e(e.toString());
      showSnackBar(
          title: "Error", subTitle: e.toString(), type: SnackBarType.error);
    }
  }
}

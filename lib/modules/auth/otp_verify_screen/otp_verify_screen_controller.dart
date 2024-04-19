import 'dart:async';

import 'package:demo_task/api/api_config.dart';
import 'package:demo_task/api/api_const.dart';
import 'package:demo_task/api/response_model.dart';
import 'package:demo_task/model/user_model.dart';
import 'package:demo_task/routes/pages.dart';
import 'package:demo_task/utils/app_utils.dart';
import 'package:demo_task/utils/custom_snakbar.dart';
import 'package:demo_task/utils/enum.dart';
import 'package:demo_task/utils/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class OtpVerifyScreenController extends GetxController {
  late Timer timer;
  RxInt secondsRemaining = 30.obs;
  RxBool enableResend = false.obs;
  RxBool enableVerify = false.obs;
  RxString errorText = "".obs;
  String number = "";
  RxBool isVerifying = false.obs;
  TextEditingController otpCTRL = TextEditingController();

  @override
  void onInit() {
    _startTimer();
    number = Get.arguments;
    listenOtp();
    super.onInit();
  }

  @override
  void dispose() {
    timer.cancel();

    super.dispose();
  }

  void listenOtp() async {
    otpCTRL.addListener(() {
      if (otpCTRL.text.isNotEmpty) {
        enableVerify(true);
      } else {
        enableVerify(false);
      }
    });
  }

  void onResend() {
    secondsRemaining(30);
    _startTimer();
    _resendOtp();
  }

  void _startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        secondsRemaining--;
      } else {
        timer.cancel();
        // Add your logic for when the timer finishes (optional)
        print('Timer finished!');
      }
      logger.i(secondsRemaining);
    });
  }

  Future<void> _resendOtp() async {
    logger.w(number);
    try {
      ResponseModel model = await ApiConfig.client
          .postData(ApiConst.resendOtp, {"phone": number});
      if (model.status) {
        showSnackBar(
            title: "Success",
            subTitle: model.message,
            type: SnackBarType.success);
      } else {
        showSnackBar(
            title: "Error", subTitle: model.message, type: SnackBarType.error);
      }
    } on Exception catch (e) {
      logger.e(e.toString());
      showSnackBar(
          title: "Error", subTitle: e.toString(), type: SnackBarType.error);
    }
  }

  Future<void> onVerifyOtp() async {
    await _verifyOtp();
  }

  Future<void> _verifyOtp() async {
    try {
      isVerifying(true);
      ResponseModel model = await ApiConfig.client.postData(
          ApiConst.verifyOtp, {"phone": number, "code": otpCTRL.text});
      if (model.status) {
        isVerifying(false);
        showSnackBar(
            title: "Success",
            subTitle: model.message,
            type: SnackBarType.success);
        UserModel user = UserModel.fromJson(model.data);
        AppUtils.userModel = user;
        timer.cancel();
        secondsRemaining = 0.obs;
        Get.toNamed(Pages.companySelect);
      } else {
        errorText(model.data.toString());
      }
      isVerifying(false);
    } on Exception catch (e) {
      isVerifying(false);
      logger.e(e.toString());
      showSnackBar(
          title: "Error", subTitle: e.toString(), type: SnackBarType.error);
    }
  }
}

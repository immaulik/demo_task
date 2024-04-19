import 'package:demo_task/const/color_const.dart';
import 'package:demo_task/modules/auth/otp_verify_screen/otp_verify_screen_controller.dart';
import 'package:demo_task/utils/const_styles.dart';
import 'package:demo_task/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class OtpVerifyScreen extends GetView<OtpVerifyScreenController> {
  const OtpVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 120,
              child: Column(
                children: [
                  Text(
                    "Verify Number",
                    style: titleStyle,
                  ),
                  Gap(15),
                  Text(
                    "Please enter the OTP received to\nverify your number",
                    textAlign: TextAlign.center,
                    style: Get.textTheme.displayMedium!
                        .copyWith(color: ColorConst.primary, height: 1.5),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.07),
                      Colors.grey.withOpacity(0.2),
                      Colors.black.withOpacity(0.07),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset:
                          Offset(5, 5), // Shadow moved to the right and bottom
                    )
                  ]),
              height: 2,
            ),
            Gap(40),
            SizedBox(
              height: 60,
              child: Pinput(
                controller: controller.otpCTRL,
                length: 4,
                androidSmsAutofillMethod:
                    AndroidSmsAutofillMethod.smsUserConsentApi,
                defaultPinTheme: PinTheme(
                  height: 50,
                  width: 50,
                  textStyle: Get.textTheme.displayMedium,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1.0, color: Color(0xFF7D7E80)),
                    ),
                  ),
                ),
                /*OtpTextField(
                onSubmit: (value) => controller.onOTPSubmit(value),
                numberOfFields: 4,
                textStyle: Get.textTheme.displayMedium,
                cursorColor: Color(0xFF7D7E80),
                focusedBorderColor: ColorConst.primary,
                enabledBorderColor: Color(0xFF7D7E80),
              )*/
              ),
            ),
            Gap(Get.height * 0.03),
            Obx(
              () => Text(
                controller.errorText.value,
                style: Get.textTheme.displaySmall!.copyWith(color: Colors.red),
              ),
            ),
            Gap(Get.height * 0.1),
            Text(
              "Didn’t receive OTP?",
              style: Get.textTheme.displaySmall,
            ),
            Gap(10),
            SizedBox(
              height: 50,
              child: Obx(
                () => controller.secondsRemaining != 0
                    ? Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Wrap(
                          children: [
                            Text(
                              "Resending OTP in ",
                              style: Get.textTheme.displayMedium,
                            ),
                            Text(
                              "${controller.secondsRemaining} Seconds",
                              style: Get.textTheme.displayMedium!
                                  .copyWith(color: ColorConst.primary),
                            ),
                          ],
                        ),
                      )
                    : TextButton(
                        onPressed: () => controller.onResend(),
                        child: Text("Resend Otp")),
              ),
            ),
            Gap(Get.height * 0.1),
            Obx(
              () => CustomButton(
                title: "Verify",
                isLoading: controller.isVerifying.value,
                onTap: () => controller.onVerifyOtp(),
                isEnable: controller.enableVerify(),
              ),
            ),
            SizedBox(),
          ],
        ),
      ),
    );
  }
}

import 'package:country_flags/country_flags.dart';
import 'package:demo_task/const/color_const.dart';
import 'package:demo_task/modules/auth/login/login_controller.dart';
import 'package:demo_task/utils/const_styles.dart';
import 'package:demo_task/utils/extension.dart';
import 'package:demo_task/widgets/custom_button.dart';
import 'package:demo_task/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

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
                    "Enter phone number",
                    style: titleStyle,
                  ),
                  Gap(15),
                  Text(
                    "Please enter your 10 digit mobile\nnumber to receive OTP",
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
            Form(
              key: controller.formKey,
              child: SizedBox(
                height: 60,
                child: IntrinsicWidth(
                  stepWidth: 250,
                  child: Center(
                    child: CustomTextField(
                      hint: "9999999999",
                      validatorFunction: (value) {
                        if (value != null && value.isEmpty) {
                          return "Please enter contact number";
                        } else if (value != null && value.length < 10) {
                          return "Please enter valid contact number";
                        } else {
                          return null;
                        }
                      },
                      controller: controller.numCTRL,
                      onTap: () => controller.onTextChange(),
                      isBorder: false,
                      inputType: TextInputType.number,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      hintStyle: Get.textTheme.displayMedium!.copyWith(
                          color: ColorConst.search,
                          fontWeight: FontWeight.w500),
                      prefixBoxConstraint: const BoxConstraints(
                        minHeight: 25,
                        minWidth: 60,
                      ),
                      prefixIcon: InkWell(
                        onTap: () => controller.onCountryBack(),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 20.0,
                              width: 35.0,
                              child: CountryFlag.fromCountryCode(
                                controller
                                    .countryModel.code, // Ensure uppercase code
                              ),
                            ),
                            Gap(20),
                            Text(
                              "${controller.countryModel.telCode}  ",
                              style: Get.textTheme.displayMedium!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Gap(Get.height * 0.35),
            Obx(
              () => CustomButton(
                title: "Get OTP",
                isLoading: controller.isLogin.value,
                onTap: () => controller.getOTP(),
                isEnable: controller.isEnable(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

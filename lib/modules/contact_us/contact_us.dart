import 'package:demo_task/modules/contact_us/contact_us_controller.dart';
import 'package:demo_task/utils/const_styles.dart';
import 'package:demo_task/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ContactUs extends GetView<ContactUsController> {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: SizedBox(
            width: Get.width,
          )),
          Text(
            "Welcome",
            style: titleStyle,
          ),
          Gap(40),
          CustomButton(
            isLoading: false,
            isEnable: true,
            title: "Logout",
            onTap: () => controller.onTapLogout(),
          ),
          Gap(30),
          CustomButton(
            isLoading: false,
            isEnable: true,
            title: "Delete User",
            onTap: () => controller.onTapDelete(),
          ),
          Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}

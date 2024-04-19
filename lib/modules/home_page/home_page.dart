import 'package:demo_task/const/asset_const.dart';
import 'package:demo_task/const/color_const.dart';
import 'package:demo_task/modules/home_page/home_page_controller.dart';
import 'package:demo_task/routes/pages.dart';
import 'package:demo_task/utils/enum.dart';
import 'package:demo_task/widgets/inner_shadow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        AssetConst.homeImage,
        fit: BoxFit.fill,
        height: double.infinity,
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: ColorConst.lightBlack,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Gap(20),
                Text(
                  "Welcome to Study Lancer",
                  style: Get.textTheme.displayLarge,
                ),
                Gap(5),
                Text(
                  "Please select your role to get registered",
                  style: Get.textTheme.displayMedium,
                ),
                Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    roleTile(
                      img: AssetConst.student,
                      role: "Student",
                      onTap: () => controller.onRoleTap(Role.student),
                    ),
                    roleTile(
                      img: AssetConst.agent,
                      role: "Agent",
                      onTap: () => controller.onRoleTap(Role.agent),
                    ),
                  ],
                ),
                Gap(10),
                Wrap(
                  children: [
                    Text(
                      "By continuing you agree to our ",
                      style: Get.textTheme.displaySmall,
                    ),
                    InkWell(
                      onTap: () => controller.onTermsOfServiceTap(),
                      child: Text(
                        "Terms and Conditions",
                        style: Get.textTheme.displaySmall!.copyWith(
                          color: ColorConst.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
                Gap(10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget roleTile(
      {required String role,
      required VoidCallback onTap,
      required String img}) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(17),
                child: Image.asset(
                  img,
                  height: 100,
                  width: 130,
                )),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.25),
                    spreadRadius: 0,
                    blurRadius: 5,
                    offset:
                        Offset(-4, -4), // Shadow moved to the right and bottom
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    spreadRadius: 0,
                    blurRadius: 5,
                    offset:
                        Offset(4, 4), // Shadow moved to the right and bottom
                  ),
                ],
                borderRadius: BorderRadius.circular(17),
                border: Border.all(color: ColorConst.surface, width: 6)),
          ),
        ),
        Gap(8),
        Text(
          role,
          style: Get.textTheme.displayMedium!
              .copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

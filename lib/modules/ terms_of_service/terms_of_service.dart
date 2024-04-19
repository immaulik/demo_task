import 'package:demo_task/const/asset_const.dart';
import 'package:demo_task/const/color_const.dart';
import 'package:demo_task/modules/%20terms_of_service/terms_of_service_controller.dart';
import 'package:demo_task/routes/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class TermsOfService extends GetView<TermsOfServiceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(18),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(15),
                close(),
                Gap(15),
                title(),
                Gap(15),
                Obx(
                  () => HtmlWidget(
                    controller.termsModel.value.content,
                    textStyle: Get.textTheme.displaySmall,
                  ),
                ),
                Gap(20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  const TermsOfService({super.key});

  Widget close() {
    return Align(
      alignment: Alignment.topRight,
      child: InkWell(
        borderRadius: BorderRadius.circular(17),
        onTap: () => Get.back(),
        child: Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: ColorConst.onSurface,
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.25),
                spreadRadius: 0,
                blurRadius: 5,
                offset: Offset(-5, -5), // Shadow moved to the right and bottom
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                spreadRadius: 0,
                blurRadius: 5,
                offset: Offset(5, 5), // Shadow moved to the right and bottom
              )
            ],
            borderRadius: BorderRadius.circular(17),
          ),
          child: Icon(
            Icons.close,
            color: ColorConst.white,
          ),
        ),
      ),
    );
  }

  Widget title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(AssetConst.copySvg),
        Gap(30),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Terms of Service",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: ColorConst.primary,
                ),
              ),
              Gap(12),
              Text(
                "Update 16/03/2023",
                style: Get.textTheme.displaySmall,
              ),
            ],
          ),
        )
      ],
    );
  }
}

import 'package:demo_task/api/api_future.dart';
import 'package:demo_task/const/color_const.dart';
import 'package:demo_task/modules/company_select/company_select_controller.dart';
import 'package:demo_task/utils/const_styles.dart';
import 'package:demo_task/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CompanySelect extends GetView<CompanySelectController> {
  const CompanySelect({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 120,
              child: Column(
                children: [
                  Text(
                    "Select Country",
                    style: titleStyle,
                  ),
                  Gap(15),
                  Text(
                    "Please select the country where\nyou want to study",
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
            Gap(30),
            SizedBox(
              height: Get.height * 0.45,
              child: ApiFuture(
                widget: () => _gridView(),
                rxValue: controller.rxApiCountries,
                onRetryTap: controller.onApiRetryTap,
              ),
            ),
            Gap(30),
            Obx(
              () => CustomButton(
                  title: "Proceed",
                  onTap: () => controller.onTapProceed(),
                  isEnable: true,
                  isLoading: controller.isLoading()),
            ),
            Gap(15),
            Text(
              "Can’t see the country of your interest?",
              textAlign: TextAlign.center,
              style: Get.textTheme.displayMedium!.copyWith(height: 1.5),
            ),
            Gap(5),
            TextButton(onPressed: () {}, child: Text("Consult with us"))
          ],
        ),
      ),
    );
  }

  Widget _gridView() {
    return GridView.builder(
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 30),
      itemCount: controller.resModel.value.countries.length,
      itemBuilder: (context, index) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
              () => InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () => controller.onSelectCountry(
                    controller.resModel.value.countries[index]),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: controller.selectedModel.value.id ==
                                  controller.resModel.value.countries[index].id
                              ? ColorConst.primary
                              : Colors.transparent,
                          width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorConst.primary.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(
                      controller.resModel.value.countries[index].image,
                      width: 80,
                      height: 80,
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) {
                        return SizedBox(
                          width: 80,
                          height: 80,
                          child: Center(
                            child: Text(
                              controller.resModel.value.countries[index].name
                                  .substring(0, 2)
                                  .toUpperCase(),
                              style: Get.textTheme.displayLarge,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            Gap(10),
            Text(
              controller.resModel.value.countries[index].name,
              style: Get.textTheme.displayMedium,
            ),
          ],
        );
      },
    );
  }
}

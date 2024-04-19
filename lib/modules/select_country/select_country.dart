import 'package:country_flags/country_flags.dart';
import 'package:demo_task/api/api_future.dart';
import 'package:demo_task/const/asset_const.dart';
import 'package:demo_task/const/color_const.dart';
import 'package:demo_task/modules/select_country/select_country_controller.dart';
import 'package:demo_task/utils/const_styles.dart';
import 'package:demo_task/utils/extension.dart';
import 'package:demo_task/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SelectCountry extends GetView<SelectCountryController> {
  const SelectCountry({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 120,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                children: [
                  Text(
                    "Select your country",
                    style: titleStyle,
                  ),
                  Expanded(child: SizedBox()),
                  CustomTextField(
                    hint: "Search",
                    controller: controller.searchCTRL,
                    onChanged: (value) => controller.onSearch(),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(15),
                      child: SvgPicture.asset(
                        AssetConst.searchIcon,
                      ),
                    ),
                    filled: true,
                    fillColor: ColorConst.search,
                    suffixIcon: Obx(
                      () => Visibility(
                        visible: controller.isSearch.isTrue,
                        child: InkWell(
                          onTap: () => controller.onCloseTap(),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Icon(
                              Icons.close,
                              color: ColorConst.seed,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: SizedBox()),
                ],
              ),
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
          Expanded(
            child: ApiFuture(
              rxValue: controller.rxApiCountries,
              widget: _countryList,
              onRetryTap: controller.onApiRetryTap,
            ),
          ),
        ],
      ),
    );
  }

  Widget _countryList() {
    return SizedBox(
      height: Get.height * 0.68,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 18),
        separatorBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.07),
                  Colors.grey.withOpacity(0.2),
                  Colors.black.withOpacity(0.07),
                ],
              ),
            ),
            height: 1,
          );
        },
        shrinkWrap: true,
        itemCount: controller.filteredList.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () =>
                controller.onCountrySelect(controller.filteredList[index]),
            minVerticalPadding: 20,
            leading: Container(
              height: 20.0,
              width: 35.0,
              child: CountryFlag.fromCountryCode(
                controller.filteredList[index].code, // Ensure uppercase code
                // showFlag: true, // Optional: ensure flag is displayed
                // fit: BoxFit.cover, // Adjust fit for scaling
              ),
            ),
            title: Text(
              controller.filteredList[index].name,
              style: Get.textTheme.displayMedium!
                  .copyWith(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            trailing: Text(
              controller.filteredList[index].telCode,
              style: Get.textTheme.displayMedium!
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          );
        },
      ),
    );
  }
}

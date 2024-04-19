import 'package:demo_task/api/api_config.dart';
import 'package:demo_task/api/api_const.dart';
import 'package:demo_task/api/response_model.dart';
import 'package:demo_task/model/country_model.dart';
import 'package:demo_task/routes/pages.dart';
import 'package:demo_task/utils/enum.dart';
import 'package:demo_task/utils/functions.dart';
import 'package:demo_task/utils/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SelectCountryController extends GetxController {
  RxList<CountryModel> countryList = RxList();
  RxList<CountryModel> searchList = RxList();
  Role selectedRole = Role.agent;

  RxList<CountryModel> get filteredList =>
      isSearch.isTrue ? searchList : countryList;
  Rx<ResponseModel> rxApiCountries = Rx(ResponseModel.loading());
  TextEditingController searchCTRL = TextEditingController();
  RxBool isSearch = false.obs;

  @override
  void onInit() {
    selectedRole = Get.arguments;
    super.onInit();
    _getCountry();
  }



  Future<void> _getCountry() async {
    try {
      ResponseModel model = await ApiConfig.client.getData(ApiConst.country);
      if (model.status) {
        List<dynamic> countries = model.data;
        countryList.value =
            countries.map((e) => CountryModel.fromJson(e)).toList();
      }
      rxApiCountries.value = model;
    } on Exception catch (e) {
      logger.e(e.toString());
      rxApiCountries.value = ResponseModel.error(message: e.toString());
    }
  }

  void onSearch() {
    searchCTRL.addListener(() {
      if (searchCTRL.text.isNotEmpty) {
        isSearch(true);
        searchList.value = countryList
            .where((p0) => p0.name.toLowerCase().contains(searchCTRL.text))
            .toList();
      } else {
        isSearch(false);
      }
    });
  }

  void onApiRetryTap() {
    rxApiCountries.value = ResponseModel.loading();
    _getCountry();
  }

  void onCloseTap() {
    searchCTRL.text = "";
    isSearch(false);
    hideKeyboard();
  }

  void onCountrySelect(CountryModel model) {
    Get.toNamed(Pages.login, arguments: [selectedRole, model]);
  }
}

import 'package:demo_task/api/api_config.dart';
import 'package:demo_task/api/api_const.dart';
import 'package:demo_task/api/response_model.dart';
import 'package:demo_task/model/country_model.dart';
import 'package:demo_task/model/country_response_model.dart';
import 'package:demo_task/routes/pages.dart';
import 'package:demo_task/utils/custom_snakbar.dart';
import 'package:demo_task/utils/enum.dart';
import 'package:demo_task/utils/logger.dart';
import 'package:get/get.dart';

class CompanySelectController extends GetxController {
  Rx<CountryResponseModel> resModel = CountryResponseModel().obs;
  Rx<ResponseModel> rxApiCountries = Rx(ResponseModel.loading());
  Rx<CountryModel> selectedModel = CountryModel().obs;
  RxBool isLoading = false.obs;
  RxBool isEnable = false.obs;

  @override
  void onInit() {
    super.onInit();
    _getCountry();
  }

  Future<void> _getCountry() async {
    try {
      ResponseModel model =
          await ApiConfig.client.getData(ApiConst.selectCountry);
      if (model.status) {
        resModel.value = CountryResponseModel.fromJson(model.data);
      }
      rxApiCountries.value = model;
    } on Exception catch (e) {
      logger.e(e.toString());
      rxApiCountries.value = ResponseModel.error(message: e.toString());
    }
  }

  Future<void> onApiRetryTap() async {
    rxApiCountries = Rx(ResponseModel.loading());
    _getCountry();
  }

  Future<void> onTapProceed() async {
    // Get.toNamed(Pages.contactUs);
    try {
      isLoading(true);
      ResponseModel model =
          await ApiConfig.client.postData(ApiConst.selectCountry, {
        "country_id": selectedModel.value.id,
      });
      if (model.status) {
        showSnackBar(
            title: "Success",
            subTitle: model.message,
            type: SnackBarType.success);
        Get.toNamed(Pages.contactUs);
        isLoading(false);
      } else {
        showSnackBar(
            title: "Error", subTitle: model.message, type: SnackBarType.error);
        isLoading(false);
      }
    } on Exception catch (e) {
      isLoading(false);
      logger.e(e.toString());
      showSnackBar(
          title: "Error", subTitle: e.toString(), type: SnackBarType.error);
    }
  }

  void onSelectCountry(CountryModel model) {
    selectedModel(model);
    isEnable(true);
  }
}

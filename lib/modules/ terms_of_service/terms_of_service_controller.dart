import 'package:demo_task/api/api_config.dart';
import 'package:demo_task/api/api_const.dart';
import 'package:demo_task/api/response_model.dart';
import 'package:demo_task/model/terms_model.dart';
import 'package:demo_task/utils/logger.dart';
import 'package:get/get.dart';

class TermsOfServiceController extends GetxController {
  Rx<ResponseModel> rxApiTerms = Rx(ResponseModel.loading());
  Rx<TermsModel> termsModel = TermsModel().obs;

  @override
  void onInit() {
    super.onInit();
    _getTermsOfService();
  }

  Future<void> _getTermsOfService() async {
    try {
      ResponseModel model =
          await ApiConfig.client.getData(ApiConst.termsConditions);
      if (model.status) {
        termsModel.value = TermsModel.fromJson(model.data);
      }
      rxApiTerms.value = model;
    } on Exception catch (e) {
      logger.e(e.toString());
      rxApiTerms.value = ResponseModel.error(message: e.toString());
    }
  }
}

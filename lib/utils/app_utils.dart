import 'package:demo_task/model/user_model.dart';

class AppUtils {
  AppUtils._();

  static UserModel userModel = UserModel();

  static bool get isLogin => userModel.accessToken != "";
}

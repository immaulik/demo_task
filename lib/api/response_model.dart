import 'package:demo_task/api/enums.dart';
import 'package:demo_task/utils/logger.dart';

class ResponseModel<T> {
  bool status;
  ApiStatus apiStatus;
  String message;
  dynamic data;

  ResponseModel(
      {this.status = false,
      this.message = "",
      this.data,
      this.apiStatus = ApiStatus.none});

  factory ResponseModel.empty() => ResponseModel(
        apiStatus: ApiStatus.empty,
      );

  factory ResponseModel.loading() => ResponseModel(
        apiStatus: ApiStatus.loading,
      );

  factory ResponseModel.error({String message = "", String data = ""}) =>
      ResponseModel(
          status: false,
          message: message,
          data: data,
          apiStatus: ApiStatus.error);

  factory ResponseModel.fromJson(dynamic data) {
    return ResponseModel<T>(
        status: data["status"] ?? false,
        message: data["message"] ?? "",
        data: data["data"],
        apiStatus: ApiStatus.success);
  }

  Map<String, dynamic> toJson() => {
        "status": message,
        "message": message,
        "data": data,
      };
}

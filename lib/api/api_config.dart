import 'dart:convert';
import 'dart:io';

import 'package:demo_task/api/api_const.dart';
import 'package:demo_task/api/response_model.dart';
import 'package:demo_task/utils/app_utils.dart';
import 'package:demo_task/utils/logger.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData;

class ApiConfig {
  ApiConfig.__(Dio dio) {
    _dio = dio;
  }

  static ApiConfig? _client;

  static ApiConfig get client {
    return _client ??= ApiConfig.__(Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        baseUrl: ApiConst.apiBase,
        headers: {
          "Accept": "application/json",
        }))
      ..interceptors.add(_MyInterceptor()));
  }

  late Dio _dio;

  Future<ResponseModel> getData(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic> params = const {},
  }) async {
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
        HttpClient()
          ..badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
    return _dio
        .get(
          url,
          queryParameters: params,
        )
        .then(_success)
        .catchError(_failed);
  }

  Future<ResponseModel> postData(
    String url,
    Map<String, dynamic> body, {
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    Options? option,
  }) async {
    FormData formData = FormData.fromMap(body);
    return _dio
        .post(
          url,
          data: formData,
          queryParameters: params,
          options: option,
        )
        .then(_success)
        .catchError(_failed);
  }

  Future<ResponseModel> postDataWithMultipleFiles(
    String url,
    FormData body, {
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    Options? option,
  }) async {
    // FormData formData = FormData.fromMap(body);

    return _dio
        .post(
          url,
          data: body,
          queryParameters: params,
          options: option,
        )
        .then(_success)
        .catchError(_failed);
  }

  ResponseModel _success(Response response) {
    ResponseModel model = ResponseModel.fromJson(response.data);
    return model;
  }

  Future<ResponseModel> _failed(error) async {
    String message = "Something went wrong";
    try {
      if (!(await isConnected())) {
        message = 'No internet connection.';
        // logger.wtf('no connection');
      } else if (error is DioException) {
        logger.e(
            '${error.response}\n${error.type}\nstatus code ${error.response?.statusCode}');

        DioError dError = error;

        switch (dError.type) {
          case DioExceptionType.cancel:
            message = 'Request Cancelled';
            break;
          case DioExceptionType.receiveTimeout:
            message = 'Receive Timeout';
            break;
          case DioExceptionType.sendTimeout:
            message = 'Send Timeout';
            break;
          case DioExceptionType.connectionTimeout:
            message = 'Connection Timeout';
            break;
          case DioExceptionType.badResponse:
            var resData =
                error.response?.data['message'] ?? 'Something went wrong';
            // logger.i(resData);
            switch (dError.response!.statusCode) {
              case 400:
                message = resData;
                break;
              case 401:
                message = resData;
                break;
              case 500:
                message = resData;
                break;
              case 404:
                message = resData;
                break;
              case 503:
                message = resData;
                break;
              case 406:
                message = resData;
                break;
            }
            break;
          case DioExceptionType.unknown:
            message = 'Something went wrong';
            break;
          case DioExceptionType.badCertificate:
            message = 'Something went wrong';
            break;
          case DioExceptionType.connectionError:
            message = "No internet connection.";
            break;
        }
      }
    } catch (e) {
      logger.d(e.toString());
    }
    logger.e(message);
    return ResponseModel.error(
        message: error.response!.data['message'].toString(),
        data: error.response!.data['data'].toString());
  }

  Future<bool> isConnected() async {
    try {
      List<InternetAddress> list = await InternetAddress.lookup('google.com');
      return list.isNotEmpty && list[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Widget alertDialog(String title) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text(
        "Error",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      content: Text("Something went wrong."),
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text("Okay"))
      ],
    );
  }
}

class _MyInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (AppUtils.isLogin) {
      options.headers.addAll({
        "Authorization": "Bearer ${AppUtils.userModel.accessToken}",
      });
    }

    // if (options.path == ApiConst.endpoint.taskManagementRegister) {
    //   options.baseUrl = ApiConst.base.url2;
    //   options.contentType = "application/x-www-form-urlencoded";
    // }

    logger.i("Api Request \n"
        "Method : ${options.method}\n"
        "Url : ${options.baseUrl + options.path}\n"
        "Query Param : ${options.queryParameters}\n"
        "body : ${options.data}\n"
        "Header : ${options.headers}\n");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.i("Api Response \n"
        "Url : ${response.requestOptions.baseUrl + response.requestOptions.path}\n"
        "data : ${const JsonEncoder.withIndent(' ').convert(response.data)}");

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e("Api Error \n"
        "error type : ${err.type.name}\n"
        "error message : ${err.message}\n"
        "error response : ${err.response}\n"
        "error : ${err.error}\n");
    super.onError(err, handler);
  }
}

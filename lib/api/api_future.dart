import 'package:demo_task/api/response_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'api_const.dart';

import 'enums.dart';

class ApiFuture<T> extends StatelessWidget {
  final Rx<ResponseModel> rxValue;
  final Function widget;
  final VoidCallback? onRetryTap;
  final Function? loadingView;
  final Function? errorView;
  final Function? emptyView;

  final bool isStatus;
  final bool simple;

  const ApiFuture({
    super.key,
    required Rx<ResponseModel> rxValue,
    required this.widget,
    this.onRetryTap,
    this.loadingView,
    this.errorView,
    this.emptyView,
  })  : this.isStatus = false,
        this.rxValue = rxValue,
        this.simple = false;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final status = rxValue.value.apiStatus;
      switch (status) {
        case ApiStatus.loading:
          if (loadingView != null) {
            return loadingView!();
          } else {
            return simple ? SizedBox() : const _DefaultLoadingView();
          }
        case ApiStatus.success:
          return widget();
        case ApiStatus.empty:
          if (emptyView != null) {
            return emptyView!();
          } else {
            return simple ? SizedBox() : const _DefaultEmptyView();
          }
        case ApiStatus.error:
          if (errorView != null) {
            return errorView!();
          } else {
            return simple
                ? SizedBox()
                : _DefaultErrorView(
                    error: rxValue.value.message,
                    onRetryTap: onRetryTap,
                    retry: onRetryTap != null,
                  );
          }
        default:
          return const SizedBox();
      }
    });
  }
}

class _DefaultLoadingView extends StatelessWidget {
  const _DefaultLoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator.adaptive());
  }
}

class _DefaultEmptyView extends StatelessWidget {
  const _DefaultEmptyView();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("No data"));
  }
}

class _DefaultErrorView extends StatelessWidget {
  final String error;
  final bool retry;
  final VoidCallback? onRetryTap;

  const _DefaultErrorView({
    required this.error,
    this.retry = false,
    this.onRetryTap,
  });

  @override
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image.asset(
            //   ApiConst.assets.apiError,
            //   height: 100,
            //   width: 100,
            // ),
            SizedBox(height: 2),
            Text(
              "Error",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 2),
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 11,
              ),
            ),
            if (retry) ...[
              SizedBox(height: 2),
              ElevatedButton(
                  onPressed: onRetryTap,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size(100, 35),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side:
                              const BorderSide(color: Colors.white, width: 2))),
                  child: const Text(
                    "Retry",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ))
            ],
          ],
        ),
      ),
    );
  }
}

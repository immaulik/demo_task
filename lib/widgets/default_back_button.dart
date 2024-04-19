import 'package:demo_task/const/color_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DefaultBackButton extends StatelessWidget {
  const DefaultBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: InkWell(
        borderRadius: BorderRadius.circular(17),
        onTap: () => Get.back(),
        child: Container(
          padding: EdgeInsets.all(10),
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
            Icons.arrow_back_ios_rounded,
            color: ColorConst.white,
            size: 14,
          ),
        ),
      ),
    );
  }
}

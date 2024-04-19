import 'package:demo_task/const/color_const.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.isEnable,
    required this.isLoading,
  });

  final String title;
  final VoidCallback onTap;
  final bool isEnable;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: isEnable ? onTap : null,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Text(
                title,
                style: TextStyle(
                  color: isEnable
                      ? Color(0xFFF9D3B4)
                      : Color(0xFFF9D3B4).withOpacity(0.4),
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              decoration: BoxDecoration(
                  color: ColorConst.onSurface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: Offset(
                          -4, -4), // Shadow moved to the right and bottom
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset:
                          Offset(4, 4), // Shadow moved to the right and bottom
                    ),
                  ],
                  borderRadius: BorderRadius.circular(100)),
            ),
          );
  }
}

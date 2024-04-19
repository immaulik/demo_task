import 'package:demo_task/const/color_const.dart';
import 'package:demo_task/const/font_const.dart';
import 'package:demo_task/widgets/default_back_button.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get appTheme => ThemeData(
        fontFamily: FontConst.metropolis,
        colorScheme: ColorScheme.fromSeed(
          seedColor: ColorConst.seed,
          primary: ColorConst.primary,
          onPrimary: ColorConst.onPrimary,
          surface: ColorConst.surface,
        ),
        scaffoldBackgroundColor: ColorConst.onSurface,
        appBarTheme: AppBarTheme(
            scrolledUnderElevation: 0
        ),
        actionIconTheme: ActionIconThemeData(
          backButtonIconBuilder: (context) {
            return DefaultBackButton();
          },
        ),
        textTheme: TextTheme(
            displayLarge: TextStyle(
                fontSize: 24,
                color: ColorConst.white,
                fontWeight: FontWeight.w600),
            displayMedium: TextStyle(
                fontSize: 14,
                color: ColorConst.white,
                fontWeight: FontWeight.w400),
            displaySmall: TextStyle(
                fontSize: 12,
                color: ColorConst.white,
                fontWeight: FontWeight.w400)),
      );
}

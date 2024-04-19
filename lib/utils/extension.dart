import 'package:demo_task/utils/enum.dart';
import 'package:flutter/material.dart';

extension SnackBarExtension on SnackBarType {
  Color get color {
    switch (this) {
      case SnackBarType.error:
        return Color(0xFFF05252);
      case SnackBarType.success:
        return Color(0xFF0E9F6E);
      case SnackBarType.general:
        return Color(0xFFD9896A);
    }
  }
}

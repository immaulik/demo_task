import 'package:flutter/material.dart';

abstract class ColorConst {
  static const lightBlack = Color(0xFF292929);
  static const white = Color(0xFFFFFFFF);
  static const Color seed = Color(0xFFD9896A);
  static const Color onSeed = Colors.white;
  static const Color surface = Color(0xFF292929);
  static const Color primary = Color(0xFFD9896A);
  static const Color onPrimary = Color(0xFF292929);
  static const Color onSurface = Color(0xFF292929);
  static const Color search = Color(0xFF4B4E4F);
  static final highlightColor = Colors.white.withOpacity(0.05);
  static final shadowColor = Colors.black87;
  static final softHighlightColor = ColorConst.highlightColor.withOpacity(0.03);
  static final softShadowColor = ColorConst.shadowColor.withOpacity(0.3);
}

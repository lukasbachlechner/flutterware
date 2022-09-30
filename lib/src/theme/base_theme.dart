import 'package:flutter/material.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/theme/styles/text_theme.dart';

ThemeData getBaseTheme({Brightness brightness = Brightness.light}) {
  return ThemeData(
    brightness: brightness,
    textTheme: getTextTheme(brightness: brightness),
    primaryColor: AppColors.primaryColor,
  );
}

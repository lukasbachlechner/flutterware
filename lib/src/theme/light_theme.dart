import 'package:flutter/material.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/theme/base_theme.dart';
// import 'package:widgetbook_annotation/widgetbook_annotation.dart';

// @WidgetbookTheme(name: 'Light')
ThemeData getLightTheme() =>
    getBaseTheme(brightness: Brightness.light).copyWith(
      scaffoldBackgroundColor: AppColors.white,
    );

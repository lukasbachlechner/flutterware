import 'package:flutter/material.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/theme/styles/text_theme.dart';

ThemeData getBaseTheme({Brightness brightness = Brightness.light}) {
  final textTheme = getTextTheme(brightness: brightness);
  return ThemeData(
    brightness: brightness,
    textTheme: textTheme,
    primaryColor: AppColors.primaryColor,
    inputDecorationTheme: InputDecorationTheme(
        alignLabelWithHint: true,
        border: const UnderlineInputBorder(
          borderRadius: BorderRadius.zero,
        ),
        focusedBorder: const UnderlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(
            color: AppColors.primaryColor,
            width: 2.0,
          ),
        ),
        errorBorder: const UnderlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(
            color: AppColors.primaryRed,
            width: 1.0,
          ),
        ),
        floatingLabelStyle: MaterialStateTextStyle.resolveWith((states) {
          final style = textTheme.headlineSmall!;

          if (states.contains(MaterialState.error)) {
            return style.copyWith(
              color: AppColors.primaryRed,
            );
          } else if (states.contains(MaterialState.focused)) {
            return style.copyWith(
              color: AppColors.primaryColor,
            );
          }

          return style;
        }),
        labelStyle: MaterialStateTextStyle.resolveWith((states) {
          final style = textTheme.headlineSmall!;
          if (states.contains(MaterialState.error)) {
            return style.copyWith(
              color: AppColors.primaryRed,
            );
          }

          return style;
        }),
        errorStyle: textTheme.headlineSmall!.copyWith(
          fontSize: 12.0,
          color: AppColors.primaryRed,
        )),
  );
}

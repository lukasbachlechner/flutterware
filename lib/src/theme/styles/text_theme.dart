import 'package:flutter/material.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/constants/app_fonts.dart';

TextTheme getTextTheme({Brightness brightness = Brightness.light}) =>
    const TextTheme()
        .copyWith(
          displayLarge: const TextStyle(
            fontFamily: AppFonts.displayFont,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
          displayMedium: const TextStyle(
            fontFamily: AppFonts.displayFont,
            fontWeight: FontWeight.w400,
            fontSize: 24,
          ),
          displaySmall: const TextStyle(
            fontFamily: AppFonts.displayFont,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
          headlineLarge: const TextStyle(
            fontFamily: AppFonts.displayFont,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
          headlineMedium: const TextStyle(
            fontFamily: AppFonts.displayFont,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          headlineSmall: const TextStyle(
            fontFamily: AppFonts.displayFont,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        )
        .apply(
          displayColor: brightness == Brightness.light
              ? AppColors.blackPrimary
              : AppColors.white,
          bodyColor: brightness == Brightness.light
              ? AppColors.blackPrimary
              : AppColors.white,
        );

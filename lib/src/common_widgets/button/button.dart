import 'package:flutter/material.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/constants/app_sizes.dart';

import '../../constants/app_fonts.dart';

enum ButtonType {
  primaryColor,
  primaryBlack,
  secondary,
  outlined,
  text,
}

enum ButtonSize { small, medium, large }

class Button extends StatelessWidget {
  const Button({
    super.key,
    this.onPressed,
    required this.label,
    this.buttonType = ButtonType.primaryColor,
    this.buttonSize = ButtonSize.small,
    this.disabled = false,
  });

  final VoidCallback? onPressed;
  final String label;
  final ButtonType buttonType;
  final ButtonSize buttonSize;
  final bool disabled;

  EdgeInsets getPadding() {
    switch (buttonSize) {
      case ButtonSize.small:
        return const EdgeInsets.all(AppSizes.p20);
      case ButtonSize.medium:
      case ButtonSize.large:
        return const EdgeInsets.symmetric(vertical: AppSizes.p20);
      default:
        return const EdgeInsets.all(AppSizes.p20);
    }
  }

  Color getTextColor() {
    switch (buttonType) {
      case ButtonType.primaryColor:
      case ButtonType.primaryBlack:
        return AppColors.white;
      case ButtonType.secondary:
        return AppColors.greyPrimary;
      case ButtonType.outlined:
        return AppColors.blackPrimary;
      case ButtonType.text:
        return AppColors.primaryBlue;
      default:
        return AppColors.white;
    }
  }

  Size? getButtonSize() {
    switch (buttonSize) {
      case ButtonSize.medium:
        return const Size.fromWidth(280);
      case ButtonSize.large:
        return const Size.fromWidth(343);
      default:
        return null;
    }
  }

  Color getBackgroundColor() {
    switch (buttonType) {
      case ButtonType.primaryColor:
        return AppColors.primaryColor;
      case ButtonType.primaryBlack:
        return AppColors.blackPrimary;
      case ButtonType.secondary:
        return AppColors.greyLightAccent;
      case ButtonType.outlined:
        return AppColors.white;
      default:
        return AppColors.primaryColor;
    }
  }

  Color getPressedBackgroundColor() {
    switch (buttonType) {
      case ButtonType.primaryColor:
        return AppColors.primaryColorLight;
      case ButtonType.primaryBlack:
        return AppColors.blackSecondary;
      case ButtonType.secondary:
        return AppColors.greyDarkAccent;
      default:
        return Colors.transparent;
    }
  }

  Color getDisabledBackgroundColor() {
    switch (buttonType) {
      case ButtonType.primaryColor:
      case ButtonType.primaryBlack:
      case ButtonType.secondary:
        return AppColors.greyLightAccent;
      case ButtonType.outlined:
        return AppColors.white;
      default:
        return AppColors.greyLightAccent;
    }
  }

  ButtonStyle getStyle() {
    return ButtonStyle(
      elevation: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.hovered)) {
          return 10;
        }
        return 0;
      }),
      foregroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return AppColors.greyDarkAccent;
        }
        return getTextColor();
      }),
      textStyle: MaterialStateProperty.resolveWith((states) {
        final isPressed = states.contains(MaterialState.pressed);
        return TextStyle(
          fontFamily: AppFonts.displayFont,
          fontWeight: FontWeight.w600,
          fontSize: AppSizes.p16,
          decoration: isPressed ? TextDecoration.underline : null,
        );
      }),
      padding: MaterialStatePropertyAll(getPadding()),
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return getDisabledBackgroundColor();
        }
        if (states.contains(MaterialState.pressed)) {
          return getPressedBackgroundColor();
        }
        return getBackgroundColor();
      }),
      overlayColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.pressed)) {
          return getBackgroundColor();
        }
        return null;
      }),
      shape: MaterialStateProperty.resolveWith((states) {
        Color borderColor = AppColors.primaryColor;
        if (states.contains(MaterialState.disabled)) {
          borderColor = AppColors.greyLightAccent;
        }
        return RoundedRectangleBorder(
          side: buttonType == ButtonType.outlined
              ? BorderSide(
                  color: borderColor,
                )
              : BorderSide.none,
        );
      }),
      fixedSize: MaterialStatePropertyAll(getButtonSize()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = disabled || onPressed == null;
    if (buttonType == ButtonType.text) {
      return TextButton(
        onPressed: isDisabled ? null : onPressed,
        style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
            foregroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return AppColors.greySecondary;
              }
              if (states.contains(MaterialState.pressed)) {
                return AppColors.greyPrimary;
              }
              return AppColors.primaryBlue;
            }),
            splashFactory: NoSplash.splashFactory,
            textStyle: const MaterialStatePropertyAll(
              TextStyle(
                fontFamily: AppFonts.displayFont,
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
                decoration: TextDecoration.underline,
              ),
            )),
        child: Text(label),
      );
    }
    return ElevatedButton(
      onPressed: isDisabled ? null : onPressed,
      style: getStyle(),
      child: Text(label.toUpperCase()),
    );
  }
}

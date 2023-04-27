import 'package:flutter/material.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:flutterware/src/constants/flutterware_icons.dart';

enum FwNotificationType {
  error,
  success,
  info,
}

class FwNotification extends StatelessWidget {
  final String? title;
  final String message;
  final FwNotificationType type;

  const FwNotification({
    super.key,
    this.title,
    required this.message,
    required this.type,
  });

  Color get _backgroundColor {
    switch (type) {
      case FwNotificationType.error:
        return AppColors.primaryRed;
      case FwNotificationType.success:
        return AppColors.primaryColor;
      case FwNotificationType.info:
        return AppColors.primaryBlue;
    }
  }

  String get _headingText {
    switch (type) {
      case FwNotificationType.error:
        return 'Error';
      case FwNotificationType.success:
        return 'Success';
      case FwNotificationType.info:
        return 'Information';
    }
  }

  IconData get _icon {
    switch (type) {
      case FwNotificationType.error:
        return FlutterwareIcons.shield;
      case FwNotificationType.success:
        return FlutterwareIcons.addedToBasket;
      case FwNotificationType.info:
        return FlutterwareIcons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.p8,
        vertical: AppSizes.p16,
      ),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Icon(
            _icon,
            color: Colors.white,
            size: 32,
          ),
          gapW8,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? _headingText,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: AppColors.white,
                      ),
                ),
                gapH4,
                Text(
                  message,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: AppColors.white,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

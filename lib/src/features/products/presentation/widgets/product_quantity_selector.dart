import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/circle_button/circle_button.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:flutterware/src/constants/flutterware_icons.dart';

class ProductQuantitySelector extends StatelessWidget {
  final int count;
  final VoidCallback onMinusPressed;
  final VoidCallback onPlusPressed;
  const ProductQuantitySelector({
    super.key,
    required this.count,
    required this.onMinusPressed,
    required this.onPlusPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.greyLightAccent,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.p8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleButton(
            iconData: FlutterwareIcons.minus,
            size: 10,
            iconSize: AppSizes.iconXS,
            color: AppColors.greyLightAccent,
            iconColor: AppColors.blackPrimary,
            withShadow: false,
            onPressed: onMinusPressed,
          ),
          SizedBox(
            width: 128,
            child: Center(
              child: Text(
                count.toString(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          CircleButton(
            iconData: FlutterwareIcons.plus,
            size: 10,
            iconSize: AppSizes.iconXS,
            color: AppColors.greyLightAccent,
            iconColor: AppColors.blackPrimary,
            withShadow: false,
            onPressed: onPlusPressed,
          ),
        ],
      ),
    );
  }
}

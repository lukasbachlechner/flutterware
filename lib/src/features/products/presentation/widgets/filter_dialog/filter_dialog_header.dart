import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/circle_icon/circle_icon.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:flutterware/src/constants/flutterware_icons.dart';
import 'package:flutterware/src/features/products/presentation/widgets/filter_dialog/filter_dialog.dart';

class FilterDialogHeader extends StatelessWidget {
  const FilterDialogHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.greyLightAccent,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.p16,
        vertical: AppSizes.p20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Filters',
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: AppColors.blackSecondary),
          ),
          GestureDetector(
            onTap: () => FilterDialog.close(context),
            child: const CircleIcon(FlutterwareIcons.close),
          ),
        ],
      ),
    );
  }
}

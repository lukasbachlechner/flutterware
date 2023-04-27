import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/list_tile/list_tile.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:flutterware/src/constants/flutterware_icons.dart';

import '../../../../../common_widgets/circle_icon/circle_icon.dart';

class FilterDialogOption extends StatelessWidget {
  final String title;
  final Widget? leading;
  final bool isSelected;
  final VoidCallback? onTap;

  const FilterDialogOption({
    super.key,
    required this.title,
    this.leading,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FwListTile(
      onTap: onTap,
      textColor: isSelected ? AppColors.primaryColor : null,
      padding: const EdgeInsets.only(
        top: AppSizes.p16,
        bottom: AppSizes.p16,
        left: AppSizes.p24,
        right: AppSizes.p20,
      ),
      leading: leading,
      title: title,
      trailing: isSelected
          ? const CircleIcon(
              FlutterwareIcons.checked,
            )
          : CircleIcon.placeholder(),
    );
  }
}

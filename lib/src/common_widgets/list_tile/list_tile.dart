import 'package:flutter/material.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:flutterware/src/constants/flutterware_icons.dart';

class FwListTile extends StatelessWidget {
  final String title;
  final Widget? leading;
  final VoidCallback? onTap;
  final Color? textColor;
  final EdgeInsets? padding;
  final Widget? trailing;
  final Color? backgroundColor;

  const FwListTile({
    super.key,
    required this.title,
    this.leading,
    this.onTap,
    this.textColor,
    this.padding,
    this.trailing,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? AppColors.white,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: padding ??
              const EdgeInsets.symmetric(
                horizontal: AppSizes.p16,
                vertical: 14.0,
              ),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColors.greyLightAccent),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: textColor ?? AppColors.blackSecondary,
                      ),
                ),
              ),
              trailing ??
                  Icon(
                    FlutterwareIcons.chevronRight,
                    color: textColor ?? AppColors.blackSecondary,
                    size: 32.0,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

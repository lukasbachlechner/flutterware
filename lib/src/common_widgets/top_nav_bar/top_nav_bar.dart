import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/constants/flutterware_icons.dart';
import 'package:go_router/go_router.dart';

class TopNavBar extends StatelessWidget {
  final String title;
  const TopNavBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backgroundColor: AppColors.greyLightAccent,
      titleTextStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: AppColors.blackSecondary,
          ),
      toolbarHeight: 50,
      leading: IconButton(
        onPressed: () => context.pop(),
        icon: const Icon(
          FlutterwareIcons.chevronLeft,
          color: AppColors.blackSecondary,
        ),
      ),
      title: Text(title),
      elevation: 0,
    );
  }
}

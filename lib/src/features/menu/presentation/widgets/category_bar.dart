import 'package:flutter/material.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:flutterware/src/constants/flutterware_icons.dart';
import 'package:flutterware/src/features/menu/presentation/screens/menu_sublevel_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:shopware6_client/shopware6_client.dart';

class CategoryBar extends StatelessWidget {
  final Category category;
  const CategoryBar({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.pushNamed(
        MenuSublevelScreen.name,
        params: {
          'parentId': category.id.toString(),
        },
        queryParams: {
          'title': category.name,
        },
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
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
            Text(
              category.name,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: AppColors.blackSecondary,
                  ),
            ),
            const Icon(
              FlutterwareIcons.chevronRight,
              color: AppColors.blackSecondary,
              size: 32.0,
            ),
          ],
        ),
      ),
    );
  }
}

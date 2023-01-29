import 'package:flutter/material.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:flutterware/src/constants/flutterware_icons.dart';
import 'package:go_router/go_router.dart';

class ProductAppBar extends StatelessWidget {
  const ProductAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.p16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => context.pop(),
              child: const Icon(
                FlutterwareIcons.chevronLeft,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const Icon(
                FlutterwareIcons.moreAction,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

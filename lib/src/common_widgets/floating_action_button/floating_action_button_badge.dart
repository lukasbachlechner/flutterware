import 'package:flutter/material.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/utils/string.dart';

import '../../constants/app_sizes.dart';

class FwFloatingActionButtonBadge extends StatelessWidget {
  const FwFloatingActionButtonBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: const ShapeDecoration(
        color: AppColors.primaryRed,
        shape: StadiumBorder(),
      ),
      constraints: const BoxConstraints(
        minWidth: AppSizes.p16,
      ),
      height: AppSizes.p16,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            limitToThreshold(1),
            textAlign: TextAlign.center,
            // TODO: refactor styling
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}

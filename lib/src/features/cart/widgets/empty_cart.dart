import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../common_widgets/button/button.dart';
import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_sizes.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AppAssets.emptyCart,
        ),
        gapH40,
        Text(
          'Your cart is empty',
          style: Theme.of(context)
              .textTheme
              .displayLarge!
              .copyWith(color: AppColors.primaryColor),
        ),
        gapH40,
        const SizedBox(
          // padding: EdgeInsets.symmetric(horizontal: AppSizes.p24 * 2.5),
          width: 267,
          child: Text(
            'Looks like you haven\'t added any items to the bag yet. Start shopping to fill it in.',
          ),
        ),
        gapH40,
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.p16,
          ),
          child: Button(
            onPressed: () => context.pop(),
            label: 'Go back shopping',
            buttonSize: ButtonSize.fullWidth,
          ),
        ),
      ],
    );
  }
}

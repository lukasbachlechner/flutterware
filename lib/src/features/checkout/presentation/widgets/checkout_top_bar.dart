import 'package:flutter/material.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:flutterware/src/constants/flutterware_icons.dart';

class CheckoutTopBar extends StatelessWidget {
  const CheckoutTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.p16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox.square(
              dimension: AppSizes.p32,
              child: Placeholder(),
            ),
            Row(
              children: [
                const Icon(
                  FlutterwareIcons.safety,
                  size: AppSizes.iconLG,
                ),
                gapW8,
                Text(
                  'Secure payment',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontSize: 12),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

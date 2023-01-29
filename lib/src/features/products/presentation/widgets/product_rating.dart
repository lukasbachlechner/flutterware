import 'package:flutter/material.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/constants/app_fonts.dart';
import 'package:flutterware/src/constants/app_sizes.dart';

class ProductRating extends StatelessWidget {
  final double rating;
  final int ratingCount;
  const ProductRating({super.key, this.rating = 0, this.ratingCount = 0});

  bool _shouldBeFilled(int index) => index + 1 <= rating.round();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.p4),
      child: Row(
        children: [
          for (var i = 0; i < 5; i++)
            Icon(
              Icons.star,
              size: 16,
              color: _shouldBeFilled(i)
                  ? AppColors.primaryColor
                  : AppColors.greyDarkAccent,
            ),
          gapW8,
          Text(
            '($ratingCount)',
            style: const TextStyle(
              fontFamily: AppFonts.displayFont,
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }
}

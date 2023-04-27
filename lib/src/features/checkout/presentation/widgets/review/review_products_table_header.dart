import 'package:flutter/material.dart';

import '../../../../../common_widgets/heading/heading.dart';
import '../../../../../constants/app_sizes.dart';

class ReviewProductsTableHeader extends StatelessWidget {
  const ReviewProductsTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        SizedBox(
          width: AppSizes.p80,
          child: Heading(
            'Item',
            level: HeadingLevel.h6,
          ),
        ),
        gapW20,
        Expanded(
          child: Heading(
            'Description',
            level: HeadingLevel.h6,
          ),
        ),
        gapW20,
        Heading(
          'Amount',
          level: HeadingLevel.h6,
        ),
      ],
    );
  }
}

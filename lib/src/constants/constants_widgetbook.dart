import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/heading/heading.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:flutterware/src/widgetbook/widgetbook_frame_wrapper.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@WidgetbookUseCase(name: 'Colors', type: AppColors)
Widget colorConstantsUseCase(BuildContext context) {
  Widget buildColorTile({required Color color}) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: [
          Container(
            color: color,
          ),
          Center(
            child: Text(
              color.toString(),
              style: TextStyle(
                color: color.computeLuminance() > 0.3
                    ? AppColors.blackPrimary
                    : AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildColorRow({
    required String title,
    required Color left,
    required Color right,
  }) {
    return [
      Heading(title),
      gapH16,
      AspectRatio(
        aspectRatio: 2,
        child: Row(
          children: [
            buildColorTile(color: left),
            buildColorTile(color: right),
          ],
        ),
      ),
      gapH24,
    ];
  }

  return WidgetbookFrameWrapper(
    title: 'Colors',
    child: ListView(
      children: [
        gapH32,
        ...buildColorRow(
          title: 'Black',
          left: AppColors.blackPrimary,
          right: AppColors.blackSecondary,
        ),
        ...buildColorRow(
          title: 'Grey',
          left: AppColors.greyPrimary,
          right: AppColors.greySecondary,
        ),
        ...buildColorRow(
          title: 'Grey accent',
          left: AppColors.greyDarkAccent,
          right: AppColors.greyLightAccent,
        ),
        ...buildColorRow(
          title: 'Green',
          left: AppColors.primaryColor,
          right: AppColors.primaryColorLight,
        ),
        ...buildColorRow(
          title: 'Blue',
          left: AppColors.primaryBlue,
          right: AppColors.secondaryBlue,
        ),
        ...buildColorRow(
          title: 'Yellow',
          left: AppColors.primaryYellow,
          right: AppColors.secondaryYellow,
        ),
        ...buildColorRow(
          title: 'Red',
          left: AppColors.primaryRed,
          right: AppColors.secondaryRed,
        ),
      ],
    ),
  );
}

// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/button/button.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart'
    as annotations;
import 'package:widgetbook/widgetbook.dart';

@annotations.WidgetbookUseCase(name: 'Button types', type: Button)
Widget buttonTypesUseCase(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Button(
          onPressed: () {},
          label: 'Learn more',
        ),
        gapH16,
        Button(
          onPressed: () {},
          label: 'Shop now',
          buttonType: ButtonType.primaryBlack,
        ),
        gapH16,
        Button(
          onPressed: () {},
          label: 'Clear all',
          buttonType: ButtonType.secondary,
        ),
        gapH16,
        Button(
          onPressed: () {},
          label: 'Learn more',
          buttonType: ButtonType.outlined,
        ),
        gapH16,
        Button(
          onPressed: () {},
          label: 'Shop now',
          buttonType: ButtonType.text,
        ),
      ],
    ),
  );
}

@annotations.WidgetbookUseCase(name: 'Button sizes', type: Button)
Widget buttonSizesUseCase(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Button(
          onPressed: () {},
          label: 'Learn more',
          buttonSize: ButtonSize.small,
        ),
        gapH16,
        Button(
          onPressed: () {},
          label: 'Learn more',
          buttonSize: ButtonSize.medium,
        ),
        gapH16,
        Button(
          onPressed: () {},
          label: 'Learn more',
          buttonSize: ButtonSize.large,
        ),
      ],
    ),
  );
}

@annotations.WidgetbookUseCase(name: 'Button playground', type: Button)
Widget buttonPlaygroundUseCase(BuildContext context) {
  final label =
      context.knobs.text(label: 'Button label', initialValue: 'Learn more');
  final buttonSize = context.knobs.options(label: 'Button size', options: [
    for (var size in ButtonSize.values)
      Option(label: size.toString(), value: size),
  ]);
  final buttonType = context.knobs.options(label: 'Button type', options: [
    for (var type in ButtonType.values)
      Option(label: type.toString(), value: type),
  ]);
  final disabled =
      context.knobs.boolean(label: 'Is disabled?', initialValue: false);

  return Center(
    child: Button(
      onPressed: () {},
      label: label,
      buttonSize: buttonSize,
      buttonType: buttonType,
      disabled: disabled,
    ),
  );
}

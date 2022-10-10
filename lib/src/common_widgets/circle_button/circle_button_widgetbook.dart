// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/circle_button/circle_button.dart';
import 'package:flutterware/src/constants/flutterware_icons.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart'
    as annotations;
import 'package:widgetbook/widgetbook.dart';

@annotations.WidgetbookUseCase(
    name: 'Circle button playground', type: CircleButton)
Widget circleButtonPlaygroundUseCase(BuildContext context) {
  final icon = context.knobs.options(label: 'Icon', options: [
    for (var icon in FlutterwareIcons.getAll().entries)
      Option(label: icon.key, value: icon.value)
  ]);
  return Center(
    child: CircleButton(
      onPressed: () {},
      iconData: icon,
    ),
  );
}

/* import 'package:flutter/material.dart';
import 'package:flutterware/src/constants/flutterware_icons.dart';
import 'package:flutterware/src/widgetbook/widgetbook_frame_wrapper.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@WidgetbookUseCase(name: 'Text inputs', type: TextField)
Widget inputsUseCase(BuildContext context) {
  return WidgetbookFrameWrapper(
    title: 'Text inputs',
    child: Center(
      child: DropdownButtonFormField(
        icon: const Icon(FlutterwareIcons.chevronDown),
        onChanged: (value) {},
        items: const [
          DropdownMenuItem(child: Text('Item 1')),
          DropdownMenuItem(
            value: 2,
            child: Text('Item 2'),
          ),
          DropdownMenuItem(
            value: 3,
            child: Text('Item 3'),
          ),
          DropdownMenuItem(
            value: 4,
            child: Text('Item 4'),
          ),
          DropdownMenuItem(
            value: 5,
            child: Text('Item 5'),
          ),
        ],
      ), /* TextFormField(
        maxLines: 1,
        decoration: const InputDecoration(
          filled: true,
          alignLabelWithHint: true,
          label: Text('Label'),
          contentPadding: EdgeInsets.zero,
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
      ), */
    ),
  );
}
 */

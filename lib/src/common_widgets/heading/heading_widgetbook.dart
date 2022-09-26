import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'heading.dart';

@WidgetbookUseCase(name: 'Heading levels', type: Heading)
Widget headingUseCase(BuildContext context) {
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Heading('Heading 1', level: HeadingLevel.h1),
        Heading('Heading 2', level: HeadingLevel.h2),
        Heading('Heading 3', level: HeadingLevel.h3),
        Heading('Heading 4', level: HeadingLevel.h4),
        Heading('Heading 5', level: HeadingLevel.h5),
        Heading('Heading 6', level: HeadingLevel.h6),
      ],
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterware/src/common_widgets/heading/heading.dart';

import '../../../utils/test_wrapper.dart';

void main() {
  testWidgets('Heading renders correct data', (tester) async {
    await tester.pumpWidget(
      const TestWrapper(
        child: Heading('Test heading'),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(Heading), findsOneWidget);
    expect(find.text('Test heading'), findsOneWidget);
  });

  testWidgets('Heading levels are displayed correctly', (tester) async {
    await tester.pumpWidget(
      TestWrapper(
        child: Column(
          children: [
            for (var i = 0; i < HeadingLevel.values.length; i++)
              Heading(
                'Heading $i',
                level: HeadingLevel.values[i],
                key: ValueKey('Heading${i}Key'),
              ),
          ],
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(Heading, skipOffstage: false), findsNWidgets(6));

    for (var i = 0; i < HeadingLevel.values.length; i++) {
      final textFinder = find.byKey(ValueKey('Heading${i}Key'));
      expect(textFinder, findsOneWidget);
    }
  });
}

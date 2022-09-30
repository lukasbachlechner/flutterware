import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterware/src/common_widgets/button/button.dart';

import '../../../utils/test_wrapper.dart';

void main() {
  testWidgets('Button renders correct data', (tester) async {
    await tester.pumpWidget(
      TestWrapper(
        child: Button(
          key: const ValueKey('Button'),
          label: 'Test',
          onPressed: () {},
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(Button), findsOneWidget);
  });

  testWidgets('Button renders correct widget types', (tester) async {
    await tester.pumpWidget(
      TestWrapper(
        child: Column(
          children: [
            Button(
              key: const ValueKey('ElevatedButton'),
              label: 'Test',
              onPressed: () {},
            ),
            Button(
              key: const ValueKey('TextButton'),
              label: 'Test',
              onPressed: () {},
              buttonType: ButtonType.text,
            ),
          ],
        ),
      ),
    );

    await tester.pumpAndSettle();

    final elevatedButton = find.byKey(const ValueKey('ElevatedButton'));
    final textButton = find.byKey(const ValueKey('TextButton'));

    expect(
      find.descendant(
        of: elevatedButton,
        matching: find.byType(ElevatedButton),
      ),
      findsOneWidget,
    );

    expect(
      find.descendant(
        of: textButton,
        matching: find.byType(TextButton),
      ),
      findsOneWidget,
    );
  });

  testWidgets(
      'Button correctly applies uppercase to all types except ButtonType.text',
      (tester) async {
    const testLabel = 'Label for Testing';
    await tester.pumpWidget(
      TestWrapper(
        child: Column(
          children: [
            for (var type in ButtonType.values)
              Button(
                label: testLabel,
                buttonType: type,
              ),
          ],
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text(testLabel, skipOffstage: false), findsOneWidget);
    expect(
      find.text(testLabel.toUpperCase(), skipOffstage: false),
      findsNWidgets(ButtonType.values.length - 1),
    );
  });

  testWidgets('Button correctly fires onPressed callbacks', (tester) async {
    final enabledCompleter = Completer();
    final disabledCompleter = Completer();

    const enabledKey = ValueKey('EnabledButton');
    const disabledKey = ValueKey('DisabledButton');

    await tester.pumpWidget(
      TestWrapper(
        child: Column(
          children: [
            Button(
              key: enabledKey,
              label: 'Test',
              onPressed: enabledCompleter.complete,
            ),
            Button(
              key: disabledKey,
              label: 'Test',
              disabled: true,
              onPressed: disabledCompleter.complete,
            ),
          ],
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.tap(find.byKey(enabledKey));
    await tester.tap(find.byKey(disabledKey));

    expect(enabledCompleter.isCompleted, isTrue);
    expect(disabledCompleter.isCompleted, isFalse);
  });

  testWidgets('Button correctly displays ButtonTypes', (tester) async {
    await tester.pumpWidget(
      TestWrapper(
        child: Column(
          children: [
            for (var type in ButtonType.values)
              Button(
                label: 'Test',
                buttonType: type,
                onPressed: () {},
              ),
          ],
        ),
      ),
    );

    await tester.pumpAndSettle();

    for (var type in ButtonType.values) {
      final isTextButton = type == ButtonType.text;

      final buttonFinder = find.byWidgetPredicate(
          (widget) => widget is Button && widget.buttonType == type);
      expect(buttonFinder, findsOneWidget);

      final materialButtonFinder = find.descendant(
        of: buttonFinder,
        matching: isTextButton
            ? find.byType(TextButton)
            : find.byType(ElevatedButton),
      );

      final materialButtonWidget = isTextButton
          ? tester.firstWidget(materialButtonFinder) as TextButton
          : tester.firstWidget(materialButtonFinder) as ElevatedButton;

      final buttonWidget = tester.firstWidget(buttonFinder) as Button;

      final textColor =
          materialButtonWidget.style?.foregroundColor?.resolve({});
      final expectedTextColor = buttonWidget.getTextColor();
      expect(textColor, equals(expectedTextColor));

      if (!isTextButton) {
        final backgroundColor =
            materialButtonWidget.style?.backgroundColor?.resolve({});
        final expectedBackgroundColor = buttonWidget.getBackgroundColor();
        expect(backgroundColor, equals(expectedBackgroundColor));

        final pressedBackgroundColor = materialButtonWidget
            .style?.backgroundColor
            ?.resolve({MaterialState.pressed});
        final pressedExpectedBackgroundColor =
            buttonWidget.getPressedBackgroundColor();
        expect(pressedBackgroundColor, equals(pressedExpectedBackgroundColor));
      }
    }
  });

  testWidgets('Button correctly displays ButtonSizes', (tester) async {
    await tester.pumpWidget(
      TestWrapper(
        child: Column(
          children: [
            for (var size in ButtonSize.values)
              Button(
                label: 'Test',
                buttonSize: size,
                onPressed: () {},
              ),
          ],
        ),
      ),
    );

    await tester.pumpAndSettle();

    for (var size in ButtonSize.values) {
      final buttonFinder = find.byWidgetPredicate(
          (widget) => widget is Button && widget.buttonSize == size);
      expect(buttonFinder, findsOneWidget);

      final elevatedButtonFinder = find.descendant(
        of: buttonFinder,
        matching: find.byType(ElevatedButton),
      );

      final elevatedButtonWidget =
          tester.firstWidget(elevatedButtonFinder) as ElevatedButton;

      final buttonWidget = tester.firstWidget(buttonFinder) as Button;

      final padding = elevatedButtonWidget.style?.padding?.resolve({});
      final expectedPadding = buttonWidget.getPadding();
      expect(padding, equals(expectedPadding));
      final fixedSize = elevatedButtonWidget.style?.fixedSize?.resolve({});
      final expectedFixedSize = buttonWidget.getButtonSize();
      expect(fixedSize, equals(expectedFixedSize));
    }
  });
}

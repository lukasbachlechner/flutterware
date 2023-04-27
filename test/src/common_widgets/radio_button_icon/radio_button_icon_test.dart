import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterware/src/common_widgets/radio_button_icon/radio_button_icon.dart';

void main() {
  testWidgets('FwRadioButtonIcon renders correctly', (tester) async {
    await tester.pumpWidget(const FwRadioButtonIcon());
    await tester.pumpAndSettle();

    final widget = tester.widget<FwRadioButtonIcon>(
      find.byType(FwRadioButtonIcon),
    );

    expect(find.byType(FwRadioButtonIcon), findsOneWidget);
    expect(widget.selected, isFalse);
  });

  testWidgets('FwRadioButtonIcon renders correctly with selected true',
      (tester) async {
    await tester.pumpWidget(const FwRadioButtonIcon(selected: true));
    await tester.pumpAndSettle();

    final widget = tester.widget<FwRadioButtonIcon>(
      find.byType(FwRadioButtonIcon),
    );

    expect(find.byType(FwRadioButtonIcon), findsOneWidget);
    expect(widget.selected, isTrue);
  });

  testWidgets('FwRadioButtonIcon renders correctly with selected false',
      (tester) async {
    await tester.pumpWidget(const FwRadioButtonIcon(selected: false));
    await tester.pumpAndSettle();

    final widget = tester.widget<FwRadioButtonIcon>(
      find.byType(FwRadioButtonIcon),
    );

    expect(find.byType(FwRadioButtonIcon), findsOneWidget);
    expect(widget.selected, isFalse);
  });

  testWidgets('FwRadioButtonIcon renders correctly with icon', (tester) async {
    const selectedKey = ValueKey('selected');
    const unselectedKey = ValueKey('unselected');
    await tester.pumpWidget(Column(
      children: const [
        FwRadioButtonIcon(
          key: unselectedKey,
        ),
        FwRadioButtonIcon(
          key: selectedKey,
          selected: true,
        ),
      ],
    ));
    await tester.pumpAndSettle();

    final unselectedWidget = tester.widget<FwRadioButtonIcon>(
      find.byKey(unselectedKey),
    );

    final selectedWidget = tester.widget<FwRadioButtonIcon>(
      find.byKey(selectedKey),
    );

    expect(find.byType(FwRadioButtonIcon), findsNWidgets(2));
    expect(
      find.descendant(
          of: find.byKey(selectedKey), matching: find.byType(Container)),
      findsOneWidget,
    );
  });
}

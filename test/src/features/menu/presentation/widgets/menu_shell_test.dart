import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterware/src/features/menu/presentation/widgets/menu_shell.dart';

import '../../../../../utils/test_wrapper.dart';

void main() {
  group('MenuShell', () {
    testWidgets('renders correctly', (tester) async {
      final containerKey = UniqueKey();
      await tester.pumpWidget(
        TestWrapper(
          child: MenuShell(
            child: Container(
              key: containerKey,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(MenuShell), findsOneWidget);
      expect(find.byKey(containerKey), findsOneWidget);
    });
  });
}

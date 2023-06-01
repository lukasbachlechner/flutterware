import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterware/src/features/menu/presentation/screens/menu_sublevel_screen.dart';
import 'package:flutterware/src/features/menu/presentation/widgets/category_bar.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../utils/extensions/widget_tester.dart';
import '../../../../../utils/factories/category_factory.dart';
import '../../../../../utils/mock/mock_navigation.dart';

void main() {
  group('CategoryBar', () {
    setUpAll(() {
      registerFallbackValue(FakeRoute());
    });
    testWidgets('renders correctly', (tester) async {
      final category = createCategory();
      await tester.pumpWrapperApp(
        CategoryBar(
          category: category,
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(CategoryBar), findsOneWidget);
      expect(find.text(category.name), findsOneWidget);
    });

    testWidgets('can handle onTap', (tester) async {
      final category = createCategory();
      final completer = Completer<void>();
      await tester.pumpWrapperApp(
        CategoryBar(
          category: category,
          onTap: () {
            completer.complete();
          },
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(CategoryBar), findsOneWidget);
      expect(find.text(category.name), findsOneWidget);

      await tester.tap(find.byType(CategoryBar));
      await tester.pumpAndSettle();

      expect(completer.isCompleted, true);
    });

    testWidgets('pushes correct route when tapped', (tester) async {
      final category = createCategory();
      final pushedPageKey = UniqueKey();
      final observer = MockNavigatorObserver();

      await tester.pumpWrapperAppWithRouter(
        CategoryBar(
          category: category,
        ),
        routes: [
          createTestRoute(
            path: MenuSublevelScreen.path,
            name: MenuSublevelScreen.name,
            key: pushedPageKey,
          ),
        ],
        observers: [
          observer,
        ],
      );

      await tester.pumpAndSettle();

      expect(find.byType(CategoryBar), findsOneWidget);
      expect(find.text(category.name), findsOneWidget);

      await tester.tap(find.byType(CategoryBar));
      await tester.pumpAndSettle();

      expect(find.byKey(pushedPageKey), findsOneWidget);
      verify(() => observer.didPush(any(), any()));
    });
  });
}

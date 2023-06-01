import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterware/src/features/menu/presentation/screens/menu_screen.dart';
import 'package:flutterware/src/features/menu/presentation/screens/menu_sublevel_screen.dart';
import 'package:flutterware/src/features/menu/presentation/widgets/category_bar.dart';
import 'package:flutterware/src/features/products/presentation/widgets/products_view/products_view.dart';
import 'package:go_router/go_router.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../../../../../utils/extensions/widget_tester.dart';
import '../../../../../utils/helpers.dart';

void main() {
  group('MenuScreen', () {
    setUp(() async {
      await setUpHive();
    });

    testWidgets('renders correctly', (tester) async {
      await tester.pumpWrapperApp(
        const MenuScreen(),
      );

      await tester.pumpAndSettle();

      expect(find.byType(MenuScreen), findsOneWidget);
      expect(find.byType(CategoryBar), findsWidgets);
    });

    testWidgets('pushed correct sub-categories screen', (tester) async {
      await mockNetworkImagesFor(() async {
        final pushedPageKey = UniqueKey();
        await tester.pumpWrapperAppWithRouter(const MenuScreen(), routes: [
          GoRoute(
            name: MenuSublevelScreen.name,
            path: MenuSublevelScreen.path,
            builder: (context, state) {
              return MenuSublevelScreen(
                key: pushedPageKey,
                parentId: NavigationId(state.params['parentId']!),
                title: state.queryParams['title'] ?? '',
                showProducts: state.queryParams['showProducts'] == 'true',
              );
            },
          ),
        ]);

        await tester.pumpAndSettle();

        expect(find.byType(MenuScreen), findsOneWidget);

        final firstCategory = find.byType(CategoryBar).first;

        await tester.tap(firstCategory);

        await tester.pumpAndSettle();

        expect(find.byKey(pushedPageKey), findsOneWidget);
        expect(find.byType(CategoryBar), findsWidgets);
      });
    });

    testWidgets('pushed correct screen when showProducts = true',
        (tester) async {
      await mockNetworkImagesFor(() async {
        final pushedPageKey = UniqueKey();
        await tester.pumpWrapperAppWithRouter(const MenuScreen(), routes: [
          GoRoute(
            name: MenuSublevelScreen.name,
            path: MenuSublevelScreen.path,
            builder: (context, state) {
              return MenuSublevelScreen(
                key: pushedPageKey,
                parentId: NavigationId(state.params['parentId']!),
                title: state.queryParams['title'] ?? '',
                showProducts: true,
              );
            },
          ),
        ]);

        await tester.pumpAndSettle();

        expect(find.byType(MenuScreen), findsOneWidget);

        final firstCategory = find.byType(CategoryBar).first;

        await tester.tap(firstCategory);

        await tester.pumpAndSettle();

        expect(find.byKey(pushedPageKey), findsOneWidget);
        expect(find.byType(CategoryBar), findsNothing);
        expect(find.byType(ProductsView), findsOneWidget);
      });
    });
  });
}

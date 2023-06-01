import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterware/src/features/products/presentation/screens/single_product_screen.dart';
import 'package:flutterware/src/features/products/presentation/widgets/products_view/product_grid_item.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../../../../utils/extensions/widget_tester.dart';
import '../../../../../../utils/factories/product_factory.dart';
import '../../../../../../utils/helpers.dart';
import '../../../../../../utils/mock/mock_navigation.dart';

void main() {
  group('ProductGridItem', () {
    setUpAll(() {
      registerFallbackValue(FakeRoute());
    });

    testWidgets('renders correctly', (tester) async {
      await mockNetworkImagesFor(() async {
        disableOverflowErrors();
        final product = await createProductFromFixture();
        await tester.pumpWrapperApp(
          ProductGridItem(
            product: product,
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byType(ProductGridItem), findsOneWidget);
      });
    });

    testWidgets('pushes correct screen when tapped', (tester) async {
      disableOverflowErrors();
      await mockNetworkImagesFor(() async {
        final product = await createProductFromFixture();
        final testRouteKey = UniqueKey();
        final mockNavigatorObserver = MockNavigatorObserver();

        await tester.pumpWrapperAppWithRouter(
          Material(
            child: ProductGridItem(
              product: product,
            ),
          ),
          routes: [
            createTestRoute(
              path: '/${SingleProductScreen.path}',
              name: SingleProductScreen.name,
              key: testRouteKey,
            ),
          ],
          observers: [
            mockNavigatorObserver,
          ],
        );

        await tester.pumpAndSettle();

        final productItem = find.byType(ProductGridItem);

        await tester.tap(productItem);

        await tester.pumpAndSettle();

        expect(find.byKey(testRouteKey), findsOneWidget);
        verify(() => mockNavigatorObserver.didPush(any(), any()));
      });
    });
  });
}

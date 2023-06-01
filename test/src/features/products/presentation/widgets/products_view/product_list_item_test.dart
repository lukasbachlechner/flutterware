import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterware/src/features/products/presentation/screens/single_product_screen.dart';
import 'package:flutterware/src/features/products/presentation/widgets/products_view/product_list_item.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../../../../utils/extensions/widget_tester.dart';
import '../../../../../../utils/factories/product_factory.dart';
import '../../../../../../utils/helpers.dart';
import '../../../../../../utils/mock/mock_navigation.dart';

void main() {
  group('ProductListItem', () {
    setUpAll(() {
      registerFallbackValue(FakeRoute());
    });

    testWidgets('renders correctly', (tester) async {
      await mockNetworkImagesFor(() async {
        disableOverflowErrors();
        final product = await createProductFromFixture();
        await tester.pumpWrapperApp(
          ProductListItem(
            product: product,
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byType(ProductListItem), findsOneWidget);
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
            child: ProductListItem(
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

        final productItem = find.byType(ProductListItem);

        await tester.tap(productItem);

        await tester.pumpAndSettle();

        expect(find.byKey(testRouteKey), findsOneWidget);
        verify(() => mockNavigatorObserver.didPush(any(), any()));
      });
    });
  });
}

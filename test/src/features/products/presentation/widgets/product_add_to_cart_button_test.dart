import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterware/src/common_widgets/button/button.dart';
import 'package:flutterware/src/features/cart/data/cart_repository.dart';
import 'package:flutterware/src/features/products/presentation/widgets/product_add_to_cart_button.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../utils/extensions/widget_tester.dart';
import '../../../../../utils/factories/product_factory.dart';
import '../../../../../utils/mock/mock_navigation.dart';
import '../../../../../utils/mock/mock_response.dart';

class MockCartRepository extends Mock implements CartRepository {}

void main() {
  group('ProductAddToCartButton', () {
    setUpAll(() {
      registerFallbackValue(FakeRoute());
    });
    testWidgets('renders correctly', (tester) async {
      const quantity = 1;
      final productId = getFixtureProductId();

      await tester.pumpWrapperApp(
        ProductAddToCartButton(
          quantity: quantity,
          productId: productId,
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(ProductAddToCartButton), findsOneWidget);
      expect(find.text('Add to cart'.toUpperCase()), findsOneWidget);
    });

    testWidgets('is disabled when no productId is passed', (tester) async {
      const quantity = 1;

      await tester.pumpWrapperApp(
        const ProductAddToCartButton(
          quantity: quantity,
        ),
      );

      await tester.pumpAndSettle();

      final button = tester.widget<Button>(find.byType(Button));

      expect(
        button,
        isA<Button>().having((button) => button.disabled, 'disabled', isTrue),
      );
    });

    testWidgets('adds item to cart when tapped', (tester) async {
      const quantity = 1;
      final productId = getFixtureProductId();
      final mockNavigatorObserver = MockNavigatorObserver();
      final mockCartRepository = MockCartRepository();
      final mockNavigationButtonKey = UniqueKey();

      when(() => mockCartRepository.getOrCreateCart()).thenAnswer(
        (_) async => MockResponse(null),
      );

      when(() => mockCartRepository.addItems(any())).thenAnswer(
        (_) async => MockResponse(null),
      );

      await tester.pumpWrapperAppWithRouter(
        Builder(builder: (context) {
          return Button(
            key: mockNavigationButtonKey,
            label: 'Test',
            onPressed: () => context.push('/_test1'),
          );
        }),
        routes: [
          GoRoute(
            path: '/_test1',
            builder: (context, state) => ProviderScope(
              overrides: [
                cartNotifierProvider.overrideWith(() => CartNotifier()),
                cartRepositoryProvider.overrideWithValue(mockCartRepository),
              ],
              child: ProductAddToCartButton(
                quantity: quantity,
                productId: productId,
              ),
            ),
          ),
        ],
        observers: [mockNavigatorObserver],
      );

      await tester.pumpAndSettle();

      final mockNavigationButton = find.byKey(mockNavigationButtonKey);
      expect(mockNavigationButton, findsOneWidget);

      await tester.tap(mockNavigationButton);

      await tester.pumpAndSettle();

      final button = find.byType(ProductAddToCartButton);

      await tester.tap(button);

      await tester.pumpAndSettle();

      verify(() => mockNavigatorObserver.didPop(any(), any())).called(1);
    });
  });
}

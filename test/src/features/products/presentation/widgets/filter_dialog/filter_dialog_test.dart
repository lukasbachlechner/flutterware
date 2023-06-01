import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterware/src/common_widgets/accordion/accordion.dart';
import 'package:flutterware/src/common_widgets/button/button.dart';
import 'package:flutterware/src/constants/flutterware_icons.dart';
import 'package:flutterware/src/features/products/data/products_view/products_view_controller.dart';
import 'package:flutterware/src/features/products/data/products_view/products_view_filter.dart';
import 'package:flutterware/src/features/products/presentation/widgets/filter_dialog/filter_dialog.dart';
import 'package:flutterware/src/features/products/presentation/widgets/filter_dialog/filter_dialog_option.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../../../../../../utils/extensions/widget_tester.dart';
import '../../../../../../utils/factories/product_sorting_factory.dart';
import '../../../../../../utils/factories/property_group_option_factory.dart';
import '../../../../../../utils/mock/mock_navigation.dart';

class MockProductsViewFilter extends StateNotifier<ProductsViewFilterState>
    with Mock
    implements ProductsViewFilter {
  MockProductsViewFilter(super.state);
}

class MockProductsViewNotifier extends Mock implements ProductsViewNotifier {}

void main() {
  setUpAll(() {
    registerFallbackValue(createPropertyGroupOption());
    registerFallbackValue(
      createProductSorting(key: 'key', priority: 1),
    );
    registerFallbackValue(FakeRoute());
  });

  MockProductsViewFilter getMockProductsViewFilter({
    List<ProductSorting>? availableSortings,
    ListingAggregations? aggregations,
  }) {
    final mockProductsViewFilterState = ProductsViewFilterState(
      availableSortings: availableSortings ??
          [
            createProductSorting(
              key: 'key',
              priority: 1,
            ),
          ],
      aggregations: aggregations ?? createListingAggregations(),
    );
    final mockProductsViewFilter =
        MockProductsViewFilter(mockProductsViewFilterState);
    return mockProductsViewFilter;
  }

  group('FilterDialog', () {
    testWidgets('renders correctly and displays sorting', (tester) async {
      final mockProviderState = ProductsViewState.initial(
        type: ProductsViewType.byCategoryId,
      );

      final mockProviderNotifier = ProductsViewNotifier();

      final mockProductsViewFilter = getMockProductsViewFilter();

      await tester.pumpWrapperApp(
        ProviderScope(
          overrides: [
            productsViewFilterProvider
                .overrideWith((ref) => mockProductsViewFilter)
          ],
          child: FilterDialog(
            providerState: mockProviderState,
            providerNotifier: mockProviderNotifier,
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(FilterDialog), findsOneWidget);

      final sortByAccordionItemFinder = find.byWidgetPredicate(
        (widget) => widget is AccordionItem && widget.title == 'Sort by',
      );

      await tester.tap(sortByAccordionItemFinder);

      await tester.pumpAndSettle();

      final optionFinder = find.byType(FilterDialogOption);

      expect(optionFinder, findsOneWidget);

      await tester.tap(optionFinder);

      await tester.pumpAndSettle();

      verify(() => mockProductsViewFilter.setSorting(any())).called(1);
    });

    testWidgets('renders correctly and displays aggregations', (tester) async {
      final mockProviderState = ProductsViewState.initial(
        type: ProductsViewType.byCategoryId,
      );
      final mockProviderNotifier = ProductsViewNotifier();

      final mockProductsViewFilter = getMockProductsViewFilter();

      await tester.pumpWrapperApp(
        ProviderScope(
          overrides: [
            productsViewFilterProvider
                .overrideWith((ref) => mockProductsViewFilter)
          ],
          child: FilterDialog(
            providerState: mockProviderState,
            providerNotifier: mockProviderNotifier,
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(FilterDialog), findsOneWidget);

      final propertyGroupAccordionItemFinder = find.byWidgetPredicate(
        (widget) => widget is AccordionItem && widget.title == 'PropertyGroup',
      );

      await tester.tap(propertyGroupAccordionItemFinder);

      await tester.pumpAndSettle();

      final optionFinder = find.byType(FilterDialogPropertyGroupOption);

      expect(find.byType(FilterDialogOption), findsOneWidget);

      expect(optionFinder, findsOneWidget);

      await tester.tap(optionFinder);

      verify(() => mockProductsViewFilter.toggleOption(any())).called(1);
    });

    Future<MockProductsViewNotifier> openFilterDialog(
      WidgetTester tester, {
      List<NavigatorObserver> observers = const [],
    }) async {
      final mockProviderState = ProductsViewState.initial(
        type: ProductsViewType.byCategoryId,
      );
      final mockProviderNotifier = MockProductsViewNotifier();

      when(() => mockProviderNotifier.filter()).thenAnswer((_) {});

      final mockNavigationButtonKey = UniqueKey();

      await tester.pumpWrapperAppWithRouter(
        Builder(builder: (context) {
          return Button(
            key: mockNavigationButtonKey,
            label: 'label',
            onPressed: () {
              FilterDialog.show(
                context,
                mockProviderState,
                mockProviderNotifier,
              );
            },
          );
        }),
        routes: [],
        observers: observers,
      );

      await tester.pumpAndSettle();

      final button = find.byKey(mockNavigationButtonKey);

      await tester.tap(button);

      await tester.pumpAndSettle();

      return mockProviderNotifier;
    }

    testWidgets('opens correctly', (tester) async {
      await openFilterDialog(tester);

      expect(find.byType(FilterDialog), findsOneWidget);
    });

    testWidgets('closes correctly when tapping "Done"', (tester) async {
      final mockNavigatorObserver = MockNavigatorObserver();
      final mockProviderNotifier = await openFilterDialog(
        tester,
        observers: [
          mockNavigatorObserver,
        ],
      );

      expect(find.byType(FilterDialog), findsOneWidget);

      // Pushes twice because of the /_initial route pushing first
      verify(() => mockNavigatorObserver.didPush(any(), any())).called(2);

      final done = find.text('Done'.toUpperCase());

      await tester.tap(done);

      await tester.pumpAndSettle();

      expect(find.byType(FilterDialog), findsNothing);

      verify(() => mockProviderNotifier.filter()).called(1);
      verify(() => mockNavigatorObserver.didPop(any(), any())).called(1);
    });

    testWidgets('closes correctly when tapping "Cancel"', (tester) async {
      final mockNavigatorObserver = MockNavigatorObserver();
      await openFilterDialog(
        tester,
        observers: [mockNavigatorObserver],
      );

      expect(find.byType(FilterDialog), findsOneWidget);

      final done = find.text('Cancel'.toUpperCase());

      await tester.tap(done);

      await tester.pumpAndSettle();

      expect(find.byType(FilterDialog), findsNothing);

      verify(() => mockNavigatorObserver.didPop(any(), any())).called(1);
    });

    testWidgets('closes correctly when tapping the close icon', (tester) async {
      final mockNavigatorObserver = MockNavigatorObserver();
      await openFilterDialog(
        tester,
        observers: [mockNavigatorObserver],
      );

      expect(find.byType(FilterDialog), findsOneWidget);

      final done = find.byIcon(FlutterwareIcons.close);

      await tester.tap(done);

      await tester.pumpAndSettle();

      expect(find.byType(FilterDialog), findsNothing);

      verify(() => mockNavigatorObserver.didPop(any(), any())).called(1);
    });
  });
}

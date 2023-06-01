import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterware/src/constants/flutterware_icons.dart';
import 'package:flutterware/src/features/products/data/products_view/products_view_controller.dart';
import 'package:flutterware/src/features/products/presentation/widgets/filter_dialog/filter_dialog.dart';
import 'package:flutterware/src/features/products/presentation/widgets/products_view/products_view_filter_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../../utils/extensions/widget_tester.dart';

void main() {
  group('ProductsViewFilterBar', () {
    testWidgets('handles view type changes', (tester) async {
      final providerState = ProductsViewState.initial(
        type: ProductsViewType.byCategoryId,
      );
      final providerNotifier = ProductsViewNotifier();
      final container = ProviderContainer();

      await tester.pumpWrapperApp(
        UncontrolledProviderScope(
          container: container,
          child: ProductsViewFilterBar(
            providerState: providerState,
            providerNotifier: providerNotifier,
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(container.read(productViewModeProvider), ProductViewMode.list);

      final gridViewIcon = find.byIcon(FlutterwareIcons.boxView);
      final listViewIcon = find.byIcon(FlutterwareIcons.listIcon);

      await tester.tap(gridViewIcon);

      await tester.pumpAndSettle();

      expect(container.read(productViewModeProvider), ProductViewMode.grid);

      await tester.tap(listViewIcon);

      await tester.pumpAndSettle();

      expect(container.read(productViewModeProvider), ProductViewMode.list);
    });

    testWidgets('can open FilterDialog', (tester) async {
      final providerState = ProductsViewState.initial(
        type: ProductsViewType.byCategoryId,
      );
      final providerNotifier = ProductsViewNotifier();

      await tester.pumpWrapperAppWithRouter(
        ProductsViewFilterBar(
          providerState: providerState,
          providerNotifier: providerNotifier,
        ),
        routes: [],
      );

      await tester.pumpAndSettle();

      final filterIcon = find.byIcon(FlutterwareIcons.filter);

      await tester.tap(filterIcon);

      await tester.pumpAndSettle();

      expect(find.byType(FilterDialog), findsOneWidget);
    });
  });

  group('ProductsViewFilterBarDelegate', () {
    test('can be instantiated', () {
      final providerState = ProductsViewState.initial(
        type: ProductsViewType.byCategoryId,
      );

      final secondProviderState = ProductsViewState.initial(
        type: ProductsViewType.byCategoryId,
        totalCount: 42,
      );

      final providerNotifier = ProductsViewNotifier();

      final delegate = ProductsViewFilterBarDelegate(
        providerState: providerState,
        providerNotifier: providerNotifier,
      );

      final secondDelegate = ProductsViewFilterBarDelegate(
        providerState: secondProviderState,
        providerNotifier: providerNotifier,
      );

      expect(delegate.shouldRebuild(secondDelegate), isTrue);
      expect(delegate.stretchConfiguration, isNotNull);
      expect(
        delegate.stretchConfiguration is OverScrollHeaderStretchConfiguration,
        isTrue,
      );
      expect(delegate.snapConfiguration, isNotNull);
      expect(
        delegate.snapConfiguration is FloatingHeaderSnapConfiguration,
        isTrue,
      );
      expect(delegate.vsync, isNull);
    });
  });
}

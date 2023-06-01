import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterware/src/constants/flutterware_icons.dart';
import 'package:flutterware/src/features/products/presentation/widgets/products_view/product_grid_item.dart';
import 'package:flutterware/src/features/products/presentation/widgets/products_view/product_list_item.dart';
import 'package:flutterware/src/features/products/presentation/widgets/products_view/products_view.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../../../../utils/extensions/widget_tester.dart';
import '../../../../../../utils/helpers.dart';
import '../../../../../../utils/id_generator.dart';

void main() {
  group('ProductsView', () {
    testWidgets('renders correctly', (tester) async {
      await mockNetworkImagesFor(() async {
        disableOverflowErrors();

        await tester.pumpWrapperApp(
          ProductsView.category(
            categoryId: IDGenerator.generate(),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byType(ProductsView), findsOneWidget);
      });
    });
    testWidgets('renders correct children', (tester) async {
      final originalError = disableOverflowErrors();
      await mockNetworkImagesFor(() async {
        await tester.pumpWrapperApp(
          ProductsView.category(
            categoryId: IDGenerator.generate(),
          ),
        );

        await tester.pumpAndSettle();
        FlutterError.onError = originalError;

        expect(find.byType(ProductsView), findsOneWidget);
        expect(find.byType(ProductListItem), findsWidgets);

        final gridIcon = find.byIcon(FlutterwareIcons.boxView);

        await tester.tap(gridIcon);
        await tester.pumpAndSettle();
        expect(find.byType(ProductGridItem), findsWidgets);
      });
    });
  });
}

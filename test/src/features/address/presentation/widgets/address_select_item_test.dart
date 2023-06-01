import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterware/src/features/address/presentation/widgets/address_select_item.dart';

import '../../../../../utils/factories/address_factory.dart';
import '../../../../../utils/test_wrapper.dart';

void main() {
  group('AddressSelectItem', () {
    testWidgets('renders correctly', (tester) async {
      final address = createAddress();
      await tester.pumpWidget(
        TestWrapper(
          child: AddressSelectItem(address: address),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text(address.street), findsOneWidget);
    });

    testWidgets('renders correctly with selected = true', (tester) async {
      final address = createAddress();

      await tester.pumpWidget(
        TestWrapper(
          child: AddressSelectItem(
            address: address,
            selected: true,
          ),
        ),
      );

      await tester.pumpAndSettle();

      final widgetFinder = find.byType(AddressSelectItem);

      expect(
        tester.widget(widgetFinder),
        isA<AddressSelectItem>().having(
          (w) => w.selected,
          'selected',
          isTrue,
        ),
      );
      expect(find.byType(Icon), findsOneWidget);
    });
  });
}

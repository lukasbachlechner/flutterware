import 'package:flutter_test/flutter_test.dart';
import 'package:flutterware/src/features/address/presentation/widgets/address_select.dart';
import 'package:flutterware/src/features/address/presentation/widgets/address_select_item.dart';

import '../../../../../utils/factories/address_factory.dart';
import '../../../../../utils/factories/factories.dart';
import '../../../../../utils/test_wrapper.dart';

void main() {
  group('AddressSelect', () {
    testWidgets('renders correctly', (tester) async {
      final addresses = createList(() => createAddress(), 5);
      await tester.pumpWidget(
        TestWrapper(
          child: AddressSelect(
            addresses: addresses,
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(AddressSelect), findsOneWidget);
      expect(
        find.byType(AddressSelectItem, skipOffstage: false),
        findsNWidgets(5),
      );
    });
  });
}

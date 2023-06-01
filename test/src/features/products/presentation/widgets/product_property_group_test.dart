import 'package:flutter_test/flutter_test.dart';
import 'package:flutterware/src/features/products/presentation/widgets/product_property_group.dart';

import '../../../../../utils/extensions/widget_tester.dart';
import '../../../../../utils/factories/property_group_option_factory.dart';

void main() {
  group('ProductPropertyGroup', () {
    testWidgets('renders correctly', (tester) async {
      final mockPropertyGroup = createPropertyGroup();
      await tester.pumpWrapperApp(
        ProductPropertyGroup(propertyGroup: mockPropertyGroup),
      );

      await tester.pumpAndSettle();

      expect(find.byType(ProductPropertyGroup), findsOneWidget);
    });
  });
}

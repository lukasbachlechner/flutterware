import 'package:flutter_test/flutter_test.dart';
import 'package:flutterware/src/common_widgets/modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutterware/src/features/cart/data/cart_button_provider.dart';
import 'package:flutterware/src/features/products/presentation/screens/single_product_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../../../../../utils/extensions/widget_tester.dart';

void main() {
  group('SingleProductScreen', () {
    testWidgets('renders correctly', (tester) async {
      await mockNetworkImagesFor(() async {
        // Hardcoded from fixtures
        final productId = ID("176b6c013f5b4ac7a6bb13219a2fd969");
        CartButtonState? cartButtonState;

        await tester.pumpWrapperApp(
          Consumer(builder: (_, ref, __) {
            cartButtonState = ref.watch(cartButtonNotifierProvider);
            return SingleProductScreen(
              productId: productId,
            );
          }),
        );

        await tester.pumpAndSettle();

        expect(find.byType(SingleProductScreen), findsOneWidget);

        expect(cartButtonState, isNotNull);
        expect(cartButtonState is AddToCartCartButtonState, isTrue);

        cartButtonState!.onPressed();

        await tester.pumpAndSettle();

        expect(find.byType(FwBottomSheet), findsOneWidget);
      });
    });
  });
}

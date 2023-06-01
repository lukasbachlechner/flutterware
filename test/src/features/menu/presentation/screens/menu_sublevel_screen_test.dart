import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterware/src/features/menu/presentation/screens/menu_sublevel_screen.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../../../../../utils/extensions/widget_tester.dart';
import '../../../../../utils/helpers.dart';
import '../../../../../utils/id_generator.dart';

void main() {
  group('MenuSublevelScreen', () {
    setUp(() async {
      await setUpHive();
    });

    testWidgets('renders correctly', (tester) async {
      final orig = disableOverflowErrors();
      await mockNetworkImagesFor(() async {
        await tester.pumpWrapperAppWithRouter(
          MenuSublevelScreen(
            parentId: NavigationId(
              IDGenerator.generate().value,
            ),
            title: 'title',
            showProducts: false,
          ),
          routes: [],
        );

        await tester.pumpAndSettle();

        FlutterError.onError = orig;

        expect(find.byType(MenuSublevelScreen), findsOneWidget);
      });
    });
  });
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterware/src/common_widgets/image/image.dart';
import 'package:flutterware/src/features/products/presentation/widgets/product_images.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../../../utils/extensions/widget_tester.dart';
import '../../../../../utils/factories/factories.dart';
import '../../../../../utils/factories/product_factory.dart';

void main() {
  group('ProductImages', () {
    testWidgets('renders correctly with only one image', (tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWrapperApp(
          ProductImages(
            cover: createProductMedia(),
          ),
        );
      });

      await tester.pumpAndSettle();

      expect(find.byType(ProductImages), findsOneWidget);
      expect(find.byType(ProductImagesIndicator), findsNothing);

      expect(find.byType(FwImage), findsOneWidget);
    });

    testWidgets('renders correctly with multiple images', (tester) async {
      const imageCount = 3;

      await mockNetworkImagesFor(() async {
        await tester.pumpWrapperApp(
          ProductImages(
            media: createList(() => createProductMedia(), imageCount),
          ),
        );
      });

      await tester.pumpAndSettle();

      expect(find.byType(ProductImagesIndicator), findsOneWidget);

      expect(find.byType(CarouselSlider), findsOneWidget);
    });
  });

  group('ProductImagesIndicator', () {
    testWidgets('renders correctly', (tester) async {
      const imageCount = 3;

      await tester.pumpWrapperApp(
        const ProductImagesIndicator(
          activeIndex: 0,
          length: imageCount,
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(ProductImagesIndicator), findsOneWidget);

      final indicators = find.byWidgetPredicate(
        (widget) => widget is Container && widget.decoration is BoxDecoration,
      );
      expect(indicators, findsNWidgets(imageCount));
    });
  });
}

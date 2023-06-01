import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/features/products/presentation/widgets/product_rating.dart';

import '../../../../../utils/extensions/widget_tester.dart';

void main() {
  group('ProductRating', () {
    void expectStars({
      required int filled,
      required int unfilled,
    }) {
      expect(find.byIcon(Icons.star), findsNWidgets(5));
      expect(
        find.byWidgetPredicate(
          (widget) => widget is Icon && widget.color == AppColors.primaryColor,
        ),
        findsNWidgets(filled),
      );
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Icon && widget.color == AppColors.greyDarkAccent,
        ),
        findsNWidgets(unfilled),
      );
    }

    testWidgets('renders correctly with no props', (tester) async {
      await tester.pumpWrapperApp(const ProductRating());

      await tester.pumpAndSettle();

      expect(find.byType(ProductRating), findsOneWidget);

      expect(find.byIcon(Icons.star), findsNWidgets(5));
      expect(find.text('(0)'), findsOneWidget);
    });

    testWidgets('renders correctly with rating count', (tester) async {
      await tester.pumpWrapperApp(const ProductRating(
        ratingCount: 42,
      ));

      await tester.pumpAndSettle();

      expect(find.text('(42)'), findsOneWidget);
    });

    testWidgets('renders correctly with rating and rating count',
        (tester) async {
      await tester.pumpWrapperApp(const ProductRating(
        ratingCount: 42,
        rating: 4,
      ));

      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.star), findsNWidgets(5));
      expect(find.text('(42)'), findsOneWidget);
      expectStars(filled: 4, unfilled: 1);
    });

    testWidgets('rounds rating correctly (down)', (tester) async {
      await tester.pumpWrapperApp(
        const ProductRating(
          ratingCount: 42,
          rating: 4.2,
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.star), findsNWidgets(5));
      expect(find.text('(42)'), findsOneWidget);
      expectStars(filled: 4, unfilled: 1);
    });

    testWidgets('rounds rating correctly (up)', (tester) async {
      await tester.pumpWrapperApp(
        const ProductRating(
          ratingCount: 42,
          rating: 3.7,
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.star), findsNWidgets(5));
      expect(find.text('(42)'), findsOneWidget);
      expectStars(filled: 4, unfilled: 1);
    });
  });
}

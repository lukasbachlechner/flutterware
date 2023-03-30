import 'package:flutter/material.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/features/products/presentation/widgets/products_view/products_view.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../../../../constants/app_sizes.dart';

class FlutterwareSearchDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    /* return ThemeData(
      appBarTheme: const AppBarTheme(
        titleSpacing: 0,
        elevation: 0,
        toolbarHeight: 40,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 5, color: Colors.red),
        ),
      ),
    ); */
    // TODO: implement appBarTheme
    final appBarTheme = super.appBarTheme(context).appBarTheme.copyWith(
          toolbarHeight: 50,
          titleSpacing: 0,
        );
    final inputTheme = super.appBarTheme(context).inputDecorationTheme.copyWith(
          enabledBorder: const UnderlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(
              width: 2.0,
              color: AppColors.blackPrimary,
            ),
          ),
          labelStyle: const TextStyle(
            fontSize: 12,
          ),
          focusedBorder: const UnderlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(
              width: 2.0,
              color: AppColors.primaryColor,
            ),
          ),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: AppSizes.p8),
        );
    final newTheme = super.appBarTheme(context).copyWith(
          appBarTheme: appBarTheme,
          inputDecorationTheme: inputTheme,
        );
    return newTheme;
  }

  @override
  TextStyle? get searchFieldStyle => const TextStyle(
        fontSize: 16,
        height: 1,
      );

  /*  @override
  PreferredSizeWidget? buildBottom(BuildContext context) {
    // TODO: implement buildBottom
    return const PreferredSize(
      preferredSize: Size.fromHeight(10),
      child: SizedBox.shrink(),
    );
  } */

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      const SizedBox(
        width: 16,
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  Widget buildResults(BuildContext context) {
    return ProductsView.category(
      categoryId: ID('2583f86071e748bebb13bc04da99d320'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Placeholder();
  }
}

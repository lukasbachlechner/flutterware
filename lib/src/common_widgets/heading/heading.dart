import 'package:flutter/material.dart';
import 'package:flutterware/src/constants/app_sizes.dart';

enum HeadingLevel { h1, h2, h3, h4, h5, h6 }

class Heading extends StatelessWidget {
  const Heading(
    this.data, {
    super.key,
    this.level = HeadingLevel.h1,
    this.inContainer = false,
  });

  final String data;
  final bool inContainer;
  final HeadingLevel level;

  /// These levels will automatically be converted to uppercase.
  static const levelsWithUppercase = <HeadingLevel>[HeadingLevel.h2];

  TextStyle _mapLevelToStyle(BuildContext context) {
    final styles = {
      HeadingLevel.h1: Theme.of(context).textTheme.displayLarge,
      HeadingLevel.h2: Theme.of(context).textTheme.displayMedium,
      HeadingLevel.h3: Theme.of(context).textTheme.displaySmall,
      HeadingLevel.h4: Theme.of(context).textTheme.headlineLarge,
      HeadingLevel.h5: Theme.of(context).textTheme.headlineMedium,
      HeadingLevel.h6: Theme.of(context).textTheme.headlineSmall
    };

    return styles[level]!;
  }

  String _maybeUppercaseData() {
    if (levelsWithUppercase.contains(level)) {
      return data.toUpperCase();
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: inContainer
          ? const EdgeInsets.symmetric(horizontal: AppSizes.p16)
          : EdgeInsets.zero,
      child: Text(
        _maybeUppercaseData(),
        style: _mapLevelToStyle(context),
      ),
    );
  }
}

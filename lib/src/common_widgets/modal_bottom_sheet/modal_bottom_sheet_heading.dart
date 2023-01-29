import 'package:flutter/material.dart';

class FwBottomSheetHeading extends StatelessWidget {
  final String heading;
  const FwBottomSheetHeading(this.heading, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      style: Theme.of(context).textTheme.displaySmall,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutterware/src/features/search/presentation/widgets/search_bar.dart';

class MenuShell extends StatelessWidget {
  final Widget child;
  const MenuShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SearchBar(),
        MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: Expanded(child: child),
        ),
      ],
    );
  }
}

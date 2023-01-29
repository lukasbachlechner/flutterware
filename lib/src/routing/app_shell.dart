import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/bottom_navigation_bar/bottom_navigation_bar.dart';

import '../common_widgets/floating_action_button/floating_action_button.dart';

class AppShell extends StatelessWidget {
  final Widget child;

  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const FwBottomNavigationBar(),
      floatingActionButton: const FwFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}

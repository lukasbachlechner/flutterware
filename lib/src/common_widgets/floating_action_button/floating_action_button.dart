import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/floating_action_button/floating_action_button_badge.dart';
import 'package:flutterware/src/constants/app_sizes.dart';

import '../../constants/flutterware_icons.dart';
import '../circle_button/circle_button.dart';

class FwFloatingActionButton extends StatelessWidget {
  const FwFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: AppSizes.fabSize,
      child: Stack(
        children: [
          CircleButton(
            iconData: FlutterwareIcons.basket,
            size: AppSizes.fabSize,
            onPressed: () {},
          ),
          const Align(
            alignment: Alignment.topRight,
            child: FwFloatingActionButtonBadge(),
          )
        ],
      ),
    );
  }
}

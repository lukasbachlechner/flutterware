import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';
import '../button/button.dart';

class FwBottomSheet extends StatelessWidget {
  final double? relativeHeight;
  final List<Widget>? children;
  final Widget? child;
  final double topPadding;

  const FwBottomSheet({
    super.key,
    this.relativeHeight,
    required this.child,
    required this.topPadding,
  }) : children = null;

  const FwBottomSheet.children(
      {super.key,
      this.relativeHeight,
      required this.children,
      required this.topPadding})
      : child = null;

  static show({
    required BuildContext context,
    List<Widget>? children,
    Widget? child,
    double? relativeHeight,
  }) {
    assert(
      !(child == null && children == null),
      'Either child or children must be set.',
    );
    final topPadding = MediaQuery.of(context).padding.top;
    return showModalBottomSheet(
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return child != null
            ? FwBottomSheet(
                relativeHeight: relativeHeight,
                topPadding: topPadding,
                child: child,
              )
            : FwBottomSheet.children(
                relativeHeight: relativeHeight,
                topPadding: topPadding,
                children: children,
              );
      },
    );
  }

  Widget _maybeWrapWithFixedHeight({
    required Widget child,
    required BuildContext context,
  }) {
    if (relativeHeight != null) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * relativeHeight!,
        child: child,
      );
    }

    return child;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: _maybeWrapWithFixedHeight(
        context: context,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            gapH8,
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                height: 3,
                width: 48,
              ),
            ),
            gapH8,
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(AppSizes.p16),
                color: AppColors.white,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (child != null)
                        child!
                      // SingleChildScrollView(child: child!)
                      else if (children != null)
                        ...children!,
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: AppColors.white,
              padding: const EdgeInsets.all(AppSizes.p16).copyWith(top: 0),
              child: SafeArea(
                child: Button(
                  buttonSize: ButtonSize.fullWidth,
                  buttonType: ButtonType.secondary,
                  label: 'Cancel',
                  onPressed: () => context.pop(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

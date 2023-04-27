import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/page_wrap/page_wrap.dart';
import 'package:flutterware/src/features/checkout/presentation/views/checkout_confirmation_view.dart';

import '../../../../constants/app_colors.dart';

class CheckoutConfirmationScreen extends StatelessWidget {
  static const path = '/checkout/confirm';
  static const name = 'checkoutConfirmationScreen';

  const CheckoutConfirmationScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const PageWrap(
      color: AppColors.white,
      child: CheckoutConfirmationView(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../common_widgets/button/button.dart';
import '../../../../constants/app_sizes.dart';
import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';

class AccountLoggedOutView extends StatelessWidget {
  const AccountLoggedOutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.p16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Button(
              buttonSize: ButtonSize.fullWidth,
              label: 'Login',
              onPressed: () => context.pushNamed(LoginScreen.name),
            ),
            gapH16,
            Button(
              buttonSize: ButtonSize.fullWidth,
              buttonType: ButtonType.primaryBlack,
              label: 'Register',
              onPressed: () => context.pushNamed(SignupScreen.name),
            )
          ],
        ),
      ),
    );
  }
}

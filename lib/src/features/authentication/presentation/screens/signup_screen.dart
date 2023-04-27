import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/page_wrap/page_wrap.dart';
import 'package:flutterware/src/features/authentication/presentation/screens/login_screen.dart';
import 'package:flutterware/src/features/authentication/presentation/widgets/forms/signup_form.dart';
import 'package:go_router/go_router.dart';

import '../../../../common_widgets/button/button.dart';
import '../../../../common_widgets/top_nav_bar/top_nav_bar.dart';
import '../../../../constants/app_sizes.dart';

class SignupScreen extends StatelessWidget {
  static const path = '/signup';
  static const name = 'signupScreen';

  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: true,
      appBar: const TopNavBar(title: 'Join us'),
      body: PageWrap(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  gapH40,
                  const SignupForm(),
                  gapH40,
                  Center(
                    child: Button(
                      buttonType: ButtonType.text,
                      label: 'or log in to your account',
                      onPressed: () =>
                          context.pushReplacementNamed(LoginScreen.name),
                    ),
                  ),
                  gapH160,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

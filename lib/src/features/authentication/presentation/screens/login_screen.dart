import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/button/button.dart';
import 'package:flutterware/src/common_widgets/heading/heading.dart';
import 'package:flutterware/src/common_widgets/page_wrap/page_wrap.dart';
import 'package:flutterware/src/common_widgets/top_nav_bar/top_nav_bar.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:flutterware/src/features/authentication/presentation/screens/signup_screen.dart';
import 'package:flutterware/src/features/authentication/presentation/widgets/forms/login_form.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  static const path = '/login';
  static const name = 'loginScreen';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWrap(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopNavBar(title: 'Login'),
            gapH40,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.p16),
              child: Heading(
                'Log in',
                level: HeadingLevel.h3,
              ),
            ),
            LoginForm(),
            gapH40,
            Center(
              child: Text(
                "Don't have an account yet?",
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: AppColors.primaryColor,
                    ),
              ),
            ),
            gapH40,
            Center(
              child: Button(
                buttonType: ButtonType.text,
                label: 'Register now',
                onPressed: () => context.pushNamed(SignupScreen.name),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

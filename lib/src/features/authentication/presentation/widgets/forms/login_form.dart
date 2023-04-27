import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutterware/src/common_widgets/button/button.dart';
import 'package:flutterware/src/common_widgets/notification/notification.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:flutterware/src/features/authentication/data/login_controller.dart';
import 'package:flutterware/src/features/authentication/data/validators/email_and_password_validators.dart';
import 'package:flutterware/src/features/global/data/validators/validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginForm extends HookConsumerWidget with EmailAndPasswordValidators {
  LoginForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final submitted = useState(false);
    final formKey = useState(GlobalKey<FormState>());

    final node = useFocusScopeNode();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    Future<void> submit() async {
      submitted.value = true;
      final loginController = ref.read(loginControllerProvider.notifier);

      if (formKey.value.currentState!.validate()) {
        await loginController.submit(
          email: emailController.text,
          password: passwordController.text,
        );
      }
    }

    final loginState = ref.watch(loginControllerProvider);

    ref.listen(
      loginControllerProvider,
      (_, state) {
        if (state.hasError) {
          passwordController.clear();
        }
      },
    );

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.p16,
      ),
      child: FocusScope(
        node: node,
        child: Form(
          key: formKey.value,
          child: Column(
            children: [
              if (loginState.hasError)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSizes.p8),
                  child: FwNotification(
                    type: FwNotificationType.error,
                    message: 'Invalid email and/or password',
                  ),
                ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  enabled: !loginState.isLoading,
                ),
                style: Theme.of(context).textTheme.headlineSmall,
                validator: (email) => emailErrorText(email ?? ''),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                autocorrect: false,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                inputFormatters: [
                  ValidatorInputFormatter(
                    editingValidator: EmailEditingRegexValidator(),
                  ),
                ],
              ),
              gapH40,
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  enabled: !loginState.isLoading,
                ),
                validator: (password) => passwordLoginErrorText(password ?? ''),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: true,
                autocorrect: false,
                textInputAction: TextInputAction.done,
              ),
              gapH40,
              Button(
                label: 'Login',
                buttonSize: ButtonSize.fullWidth,
                onPressed: loginState.isLoading ? null : () => submit(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

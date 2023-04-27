import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutterware/src/common_widgets/button/button.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:flutterware/src/features/authentication/data/validators/signup_validator.dart';
import 'package:flutterware/src/features/global/data/global_data_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../../../../../common_widgets/heading/heading.dart';
import '../../../../../common_widgets/notification/notification.dart';
import '../../../../../constants/flutterware_icons.dart';
import '../../../data/signup_controller.dart';

class SignupFormElement {
  final String label;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final AutovalidateMode autovalidateMode;
  final bool autocorrect;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final bool obscureText;
  final Iterable<String>? autofillHints;

  const SignupFormElement({
    required this.label,
    this.validator,
    required this.controller,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.autocorrect = true,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.autofillHints,
  });
}

Widget _buildTextField(
  BuildContext context, {
  required bool enabled,
  required SignupFormElement element,
}) {
  return TextFormField(
    controller: element.controller,
    style: Theme.of(context).textTheme.headlineSmall,
    decoration: InputDecoration(
      labelText: element.label,
      enabled: enabled,
    ),
    obscureText: element.obscureText,
    validator: element.validator,
    autovalidateMode: element.autovalidateMode,
    autocorrect: element.autocorrect,
    textInputAction: element.textInputAction,
    keyboardType: element.keyboardType,
    autofillHints: element.autofillHints,
  );
}

Widget _buildDropdown<T>(
  BuildContext context, {
  required String hint,
  required ValueNotifier<ID?> state,
  required List<T> items,
  required Widget Function(T item) itemLabelBuilder,
  required ID? Function(T item) itemValueBuilder,
  required bool Function(T item) itemSelectedBuilder,
}) {
  return DropdownButtonFormField<ID>(
    elevation: 2,
    value: state.value,
    validator: (value) =>
        value != null ? null : 'Please select a ${hint.toLowerCase()}',
    selectedItemBuilder: (context) => items
        .map(
          (item) => itemLabelBuilder(item),
        )
        .toList(),
    hint: Text(hint),
    onChanged: (value) => state.value = value,
    style: Theme.of(context).textTheme.headlineSmall,
    items: items
        .map(
          (item) => DropdownMenuItem<ID>(
            value: itemValueBuilder(item),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                itemLabelBuilder(item),
                if (itemSelectedBuilder(item))
                  const Icon(FlutterwareIcons.checked),
              ],
            ),
          ),
        )
        .toList(),
  );
}

class SignupForm extends HookConsumerWidget {
  const SignupForm({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupState = ref.watch(signupControllerProvider);
    final globalData = ref.watch(globalDataNotifierProvider).asData!.value;

    final salutations = globalData.salutations;
    final countries = globalData.countries;
    final zipcodePattern = globalData.currentCountry().defaultPostalCodePattern;

    final submitted = useState(false);
    final formKey = useState(GlobalKey<FormState>());
    final salutationId = useState<ID?>(salutations.first.id);
    final countryId = useState<ID?>(countries.first.id);
    final acceptedDataProtection = useState(false);

    final node = useFocusScopeNode();

    // Personal details
    final firstNameController = useTextEditingController(text: 'John');
    final lastNameController = useTextEditingController(text: 'Doe');
    final emailController = useTextEditingController(text: 'a@b.com');
    final passwordController = useTextEditingController(text: 'password');

    // Address
    final streetController = useTextEditingController(text: 'Street');
    final zipcodeController = useTextEditingController(text: '1234');
    final cityController = useTextEditingController(text: 'City');

    final signupValidator = SignupValidator(zipcodePattern: zipcodePattern);

    final List<SignupFormElement> personalDetailInputs = [
      SignupFormElement(
          label: 'First name',
          controller: firstNameController,
          validator: (value) => signupValidator.firstNameErrorText(value ?? ''),
          autofillHints: [AutofillHints.givenName]),
      SignupFormElement(
        label: 'Last name',
        controller: lastNameController,
        validator: (value) => signupValidator.lastNameErrorText(value ?? ''),
        autofillHints: [AutofillHints.familyName],
      ),
      SignupFormElement(
          label: 'Email',
          controller: emailController,
          validator: (value) => signupValidator.emailErrorText(value ?? ''),
          keyboardType: TextInputType.emailAddress,
          autofillHints: [AutofillHints.email]),
      SignupFormElement(
          label: 'Password',
          controller: passwordController,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          validator: (value) =>
              signupValidator.passwordRegisterErrorText(value ?? ''),
          autofillHints: [AutofillHints.password]),
    ];

    final List<SignupFormElement> addressInputs = [
      SignupFormElement(
        label: 'Street',
        controller: streetController,
        validator: (value) => signupValidator.streetErrorText(value ?? ''),
      ),
      SignupFormElement(
        label: 'Zip code',
        controller: zipcodeController,
        validator: (value) => signupValidator.zipcodeErrorText(value ?? ''),
      ),
      SignupFormElement(
        label: 'City',
        controller: cityController,
        validator: (value) => signupValidator.cityErrorText(value ?? ''),
        textInputAction: TextInputAction.done,
      ),
    ];

    Future<void> submit() async {
      submitted.value = true;
      formKey.value.currentState!.validate();
      if (!acceptedDataProtection.value) {
        return;
      }
      if (formKey.value.currentState!.validate()) {
        await ref.read(signupControllerProvider.notifier).submit(
              salutationId: salutationId.value!,
              firstName: firstNameController.text,
              lastName: lastNameController.text,
              email: emailController.text,
              password: passwordController.text,
              street: streetController.text,
              zipcode: zipcodeController.text,
              city: cityController.text,
              countryId: countryId.value!,
              acceptedDataProtection: acceptedDataProtection.value,
            );
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.p16),
      child: FocusScope(
        node: node,
        child: Form(
          key: formKey.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (signupState.hasError) ...[
                ...(signupState.error! as ShopwareErrorResponse)
                    .errors
                    .map(
                      (error) => Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: AppSizes.p8),
                        child: FwNotification(
                          type: FwNotificationType.error,
                          message: error.detail,
                        ),
                      ),
                    )
                    .toList(),
                gapH16,
              ],
              const Heading(
                'Personal details',
                level: HeadingLevel.h3,
              ),
              gapH16,
              _buildDropdown<Salutation>(
                context,
                hint: 'Salutation',
                state: salutationId,
                items: salutations,
                itemLabelBuilder: (item) => Text(item.displayName),
                itemValueBuilder: (item) => item.id,
                itemSelectedBuilder: (item) => item.id == salutationId.value,
              ),
              gapH24,
              for (var element in personalDetailInputs) ...[
                _buildTextField(
                  context,
                  enabled: !signupState.isLoading,
                  element: element,
                ),
                gapH24,
              ],
              gapH40,
              const Heading(
                'Address',
                level: HeadingLevel.h3,
              ),
              for (var element in addressInputs) ...[
                _buildTextField(
                  context,
                  enabled: !signupState.isLoading,
                  element: element,
                ),
                gapH24,
              ],
              _buildDropdown<Country>(
                context,
                hint: 'Country',
                state: countryId,
                items: countries,
                itemLabelBuilder: (item) => Text(item.name),
                itemValueBuilder: (item) => item.id,
                itemSelectedBuilder: (item) => item.id == countryId.value,
              ),
              gapH24,
              const Heading(
                'Consent',
                level: HeadingLevel.h3,
              ),
              gapH16,
              CheckboxListTile(
                value: acceptedDataProtection.value,
                contentPadding: EdgeInsets.zero,
                onChanged: (value) => acceptedDataProtection.value = value!,
                title: Text(
                  'I agree to the terms and conditions and the privacy policy.',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: submitted.value &&
                                acceptedDataProtection.value == false
                            ? AppColors.primaryRed
                            : null,
                      ),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: AppColors.primaryColor,
              ),
              if (submitted.value && !acceptedDataProtection.value)
                Text(
                  'This is a required field.',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: AppColors.primaryRed,
                        fontSize: 12.0,
                      ),
                ),
              gapH40,
              Button(
                label: 'Create an account',
                onPressed: signupState.isLoading ? null : submit,
                buttonSize: ButtonSize.fullWidth,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

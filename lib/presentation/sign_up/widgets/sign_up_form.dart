import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/application/result_state/result_state.dart';
import 'package:csean_mobile/domain/app_constants.dart';
import 'package:csean_mobile/domain/models/network/network_exceptions.dart';
import 'package:csean_mobile/presentation/shared/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/custom_alert_dialog.dart';
import '../../shared/default_button.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController firstNameController = TextEditingController();
  late TextEditingController lastNameController = TextEditingController();
  late TextEditingController phoneNumberController = TextEditingController();
  late TextEditingController emailAddressController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  late TextEditingController confirmPasswordController = TextEditingController();
  late bool obscurePassword = true;
  late bool obscureConfirmPassword = true;
  bool submitted = false;

  String? emailErrorText;
  String? phoneErrorText;
  String? firstNameErrorText;
  String? lastNameErrorText;
  String? passwordErrorText;
  String? confirmPasswordErrorText;
  bool isSigningUp = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomFormField(
            text: "First Name",
            textEditingController: firstNameController,
            textInputType: TextInputType.name,
            errorText: firstNameErrorText,
            isSubmitted: submitted,
            onChanged: (_) => setState(() {}),
            validator: (value) {
              if (value!.isEmpty) {
                return kFirstNameNullError;
              }
              return null;
            },
          ),
          CustomFormField(
            text: "Last Name",
            textEditingController: lastNameController,
            textInputType: TextInputType.name,
            errorText: lastNameErrorText,
            isSubmitted: submitted,
            onChanged: (_) => setState(() {}),
            validator: (value) {
              if (value!.isEmpty) {
                return kLastNameNullError;
              }
              return null;
            },
          ),
          CustomFormField(
            text: "Phone number",
            textEditingController: phoneNumberController,
            textInputType: TextInputType.number,
            errorText: phoneErrorText,
            isSubmitted: submitted,
            onChanged: (_) => setState(() {}),
            maxLength: 11,
            validator: (value) {
              if (value!.isEmpty) {
                return kPhoneNumberNullError;
              } else if (!phoneNumberValidatorRegExp.hasMatch(value)) {
                return kInvalidPhoneNumberError;
              }
              return null;
            },
          ),
          CustomFormField(
            text: "Email Address",
            textEditingController: emailAddressController,
            textInputType: TextInputType.emailAddress,
            errorText: emailErrorText,
            isSubmitted: submitted,
            onChanged: (_) => setState(() {}),
            validator: (value) {
              if (value!.isEmpty) {
                return kEmailNullError;
              } else if (!emailValidatorRegExp.hasMatch(value)) {
                return kInvalidEmailError;
              }
              return null;
            },
          ),
          CustomFormField(
            text: "Password",
            obscureText: obscurePassword,
            textEditingController: passwordController,
            textInputType: TextInputType.text,
            errorText: passwordErrorText,
            isSubmitted: submitted,
            suffixIcon: InkWell(
              onTap: () => setState(() => obscurePassword = !obscurePassword),
              child: Icon(
                !obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                size: 18,
                color: Theme.of(context).indicatorColor,
              ),
            ),
            onChanged: (_) => setState(() {}),
            validator: (value) {
              if (value!.isEmpty) {
                return kPassNullError;
              } else if (value.length < 8) {
                return kShortPassError;
              }
              return null;
            },
          ),
          CustomFormField(
            text: "Confirm password",
            obscureText: obscureConfirmPassword,
            textEditingController: confirmPasswordController,
            textInputType: TextInputType.text,
            errorText: confirmPasswordErrorText,
            isSubmitted: submitted,
            suffixIcon: InkWell(
              onTap: () => setState(() => obscureConfirmPassword = !obscureConfirmPassword),
              child: Icon(
                !obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                size: 18,
                color: Theme.of(context).indicatorColor,
              ),
            ),
            onChanged: (_) => setState(() {}),
            validator: (value) {
              if (value!.isEmpty) {
                return kConfirmPassNullError;
              } else if (value != passwordController.text) {
                return kPassMatchNullError;
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          DefaultButton(
            isPrimary: true,
            text: 'Sign Up',
            onPressed: () => _signUp(context),
          ),
        ],
      ),
    );
  }

  Future<void> _signUp(BuildContext context) async {
    setState(() => submitted = true);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final bloc = context.read<SignUpBloc>();
      bloc.add(SignUpEvent.signUp(firstName: firstNameController.text, lastName: lastNameController.text, emailAddress: emailAddressController.text, password: passwordController.text, confirmPassword: confirmPasswordController.text));

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => BlocBuilder<SignUpBloc, ResultState>(
          builder: (ctx, state) => state.when(
            idle: () => const CustomAlertDialog(text: 'Idling...'),
            loading: () => const CustomAlertDialog(text: 'Creating account...'),
            data: (_) {
              return const CustomAlertDialog(text: 'Account created successfully');
            },
            error: (e) => CustomAlertDialog(title: const Text('Sign up failed'), text: NetworkExceptions.getErrorMessage(e), isError: true),
          ),
        ),
      );
    }
  }
}

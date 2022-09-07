import 'package:csean_mobile/application/result_state/result_state.dart';
import 'package:csean_mobile/domain/app_constants.dart';
import 'package:csean_mobile/domain/models/network/network_exceptions.dart';
import 'package:csean_mobile/presentation/shared/custom_alert_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/presentation/shared/custom_form_field.dart';
import 'package:csean_mobile/presentation/shared/default_button.dart';
import 'package:csean_mobile/presentation/shared/row_text.dart';
import 'package:flutter/material.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController emailAddressController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  late bool obscureText = true;
  bool submitted = false;

  String? emailErrorText;
  String? passwordErrorText;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
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
            obscureText: obscureText,
            textEditingController: passwordController,
            textInputType: TextInputType.text,
            errorText: passwordErrorText,
            isSubmitted: submitted,
            suffixIcon: InkWell(
              onTap: () => setState(() => obscureText = !obscureText),
              child: Icon(
                !obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: RowText(
              mainAxisAlignment: MainAxisAlignment.end,
              text: "Forgot password?",
            ),
          ),
          const SizedBox(height: 15),
          DefaultButton(
            isPrimary: true,
            text: 'Sign In',
            onPressed: () => _signIn(context),
          ),
        ],
      ),
    );
  }

  Future<void> _signIn(BuildContext context) async {
    setState(() => submitted = true);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final bloc = context.read<SignInBloc>();
      bloc.add(SignInEvent.signIn(email: emailAddressController.text, password: passwordController.text));

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => BlocBuilder<SignInBloc, ResultState>(
          builder: (ctx, state) => state.when(
            idle: () => const CustomAlertDialog(text: 'Idling...'),
            loading: () => const CustomAlertDialog(text: 'Signing in...'),
            data: (_) {
              return const CustomAlertDialog(text: 'Initializing data...');
            },
            error: (e) => CustomAlertDialog(title: const Text('Log in failed'), text: NetworkExceptions.getErrorMessage(e), isError: true),
          ),
        ),
      );
    }
  }
}

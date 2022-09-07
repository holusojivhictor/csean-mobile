import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/presentation/auth/auth_screen.dart';
import 'package:csean_mobile/presentation/shared/row_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:csean_mobile/presentation/sign_up/widgets/sign_up_form.dart';
import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () => context.read<SessionBloc>().add(const SessionEvent.appStarted(init: false)),
          child: Icon(
            Icons.arrow_back_sharp,
            color: theme.indicatorColor,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 15,
            child: Column(
              children: const [
                CseanTitle(),
              ],
            ),
          ),
          Expanded(
            flex: 90,
            child: Container(
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: Styles.expandedBorderRadius,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: Styles.edgeInsetVertical16,
                      child: Text(
                        'Create Account',
                        style: theme.textTheme.headline2!.copyWith(fontSize: 24),
                      ),
                    ),
                    const SignUpForm(),
                    RowText(
                      isSelectable: true,
                      text: "I'm already a member.   ",
                      mainAxisAlignment: MainAxisAlignment.center,
                      child: InkWell(
                        onTap: () {
                          context.read<SessionBloc>().add(const SessionEvent.signIn());
                        },
                        child: Text(
                          'Sign In',
                          style: theme.textTheme.bodyText1!.copyWith(color: Colors.green),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

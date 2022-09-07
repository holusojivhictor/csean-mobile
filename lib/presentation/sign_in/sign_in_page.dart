import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/application/session/session_bloc.dart';
import 'package:csean_mobile/presentation/auth/auth_screen.dart';
import 'package:csean_mobile/presentation/shared/row_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:csean_mobile/presentation/sign_in/widgets/sign_in_form.dart';
import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

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
            flex: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const CseanTitle(),
                Container(
                  margin: const EdgeInsets.all(30),
                  child: Image.asset("assets/auth/auth_02.png"),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 50,
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
                        'Sign In',
                        style: theme.textTheme.headline2!.copyWith(fontSize: 24),
                      ),
                    ),
                    const SignInForm(),
                    RowText(
                      isSelectable: true,
                      text: "I'm a new user.  ",
                      mainAxisAlignment: MainAxisAlignment.center,
                      child: InkWell(
                        onTap: () {
                          context.read<SessionBloc>().add(const SessionEvent.signUp());
                        },
                        child: Text(
                          'Sign Up',
                          style: theme.textTheme.bodyText1!.copyWith(color: Colors.green),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
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

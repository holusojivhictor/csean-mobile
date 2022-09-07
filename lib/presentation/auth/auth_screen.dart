import 'package:csean_mobile/application/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:csean_mobile/presentation/shared/default_button.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 65,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const CseanTitle(),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Image.asset("assets/auth/auth_03.png"),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 35,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      child: Text(
                        'Become a member of the Cyber Security Experts Association of Nigeria',
                        style: theme.textTheme.headline3!.copyWith(fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                      height: 40,
                      width: width * 0.6,
                    ),
                  ),
                  DefaultButton(
                    isPrimary: true,
                    text: "Sign Up",
                    onPressed: () {
                      context.read<SessionBloc>().add(const SessionEvent.signUp());
                    },
                  ),
                  DefaultButton(
                    isPrimary: false,
                    hasBorder: true,
                    text: "Sign In",
                    onPressed: () {
                      context.read<SessionBloc>().add(const SessionEvent.signIn());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CseanTitle extends StatelessWidget {
  final bool isSmall;

  const CseanTitle({
    Key? key,
    this.isSmall = false,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'CSEA',
        style: TextStyle(fontSize: isSmall ? 12 : 40, color: Colors.black, fontWeight: FontWeight.w200, fontFamily: 'DejaVuSans'),
        children: <TextSpan>[
          TextSpan(
            text: 'N\n',
            style: TextStyle(fontSize: isSmall ? 12 : 40, color: theme.primaryColor, fontWeight: FontWeight.w200, fontFamily: 'DejaVuSans'),
          ),
          TextSpan(
            text: 'CYBER SECURITY EXPERTS \nASSOCIATION OF NIGERIA',
            style: TextStyle(fontSize: isSmall ? 3 : 10, color: Colors.black, fontWeight: FontWeight.w200, fontFamily: 'DejaVuSans'),
          ),
        ],
      ),
    );
  }
}

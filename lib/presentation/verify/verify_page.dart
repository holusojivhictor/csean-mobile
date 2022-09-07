import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/presentation/shared/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyPage extends StatelessWidget {
  const VerifyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 40,
              child: Container(
                margin: const EdgeInsets.all(70),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey, width: 3),
                ),
                child: Icon(Icons.check, size: 90, color: theme.primaryColor),
              ),
            ),
            Expanded(
              flex: 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'CONGRATULATIONS!',
                    style: theme.textTheme.headline6!.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    margin: const EdgeInsets.all(25),
                    child: const Text(
                      'You have successfully created a membership account with the Cyber Security Experts Association of Nigeria. Account activation link has been sent to the email address you provided.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  const Text(
                    'Proceed after activating your account.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  ),
                  Container(
                    margin: const EdgeInsets.all(50),
                    child: DefaultButton(
                      text: 'PROCEED',
                      isPrimary: true,
                      onPressed: () => context.read<SessionBloc>().add(const SessionEvent.signIn()),
                    ),
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

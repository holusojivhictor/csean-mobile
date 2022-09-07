import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/presentation/app_widget.dart';
import 'package:csean_mobile/presentation/auth/auth_screen.dart';
import 'package:csean_mobile/presentation/main_splash/main_splash_page.dart';
import 'package:csean_mobile/presentation/onboarding/welcome.dart';
import 'package:csean_mobile/presentation/sign_in/sign_in_page.dart';
import 'package:csean_mobile/presentation/sign_up/sign_up_page.dart';
import 'package:csean_mobile/presentation/verify/verify_page.dart';
import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionWrapper extends StatelessWidget {
  const SessionWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MaterialApp materialApp(Widget? home) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: CseanMobileTheme.light(),
        darkTheme: CseanMobileTheme.light(),
        home: home,
      );
    }
    return BlocBuilder<SessionBloc, SessionState>(
      builder: (context, state) => state.map<Widget>(
        unInitialized: (_) => materialApp(const AnimatedTextSplash()),
        unAuthenticated: (_) => materialApp(const AuthScreen()),
        signUpState: (_) => materialApp(const SignUpPage()),
        signInState: (_) => materialApp(const SignInPage()),
        signUpDoneState: (_) {
          return BlocBuilder<SessionBloc, SessionState>(
            builder: (ctx, state) => materialApp(const VerifyPage()),
          );
        },
        onboardingAuth: (_) {
          return BlocBuilder<OnboardingBloc, OnboardingState>(
            builder: (ctx, state) => materialApp(const OnboardingWelcome()),
          );
        },
        authenticated: (_) {
          return BlocBuilder<MainBloc, MainState>(
            builder: (ctx, state) => const AppWidget(),
          );
        },
      ),
    );
  }
}

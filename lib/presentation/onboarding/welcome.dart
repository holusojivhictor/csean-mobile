import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/presentation/onboarding/onboarding_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class OnboardingWelcome extends StatelessWidget {
  const OnboardingWelcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(25),
          child: Column(
            children: [
              Expanded(
                flex: 15,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: theme.scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      height: 45,
                      width: 45,
                      child: Image.asset("assets/auth/black_hole.png"),
                    ),
                    Baseline(
                      baseline: 30,
                      baselineType: TextBaseline.alphabetic,
                      child: Text(
                        'CSEAN',
                        style: theme.textTheme.headline5!.copyWith(fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to CSEAN!',
                      style: theme.textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      child: Text(
                        'To continue your journey in the membership registration process, please proceed to the onboarding flow.',
                        style: theme.textTheme.headline4!.copyWith(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 55,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(30),
                      child: Image.asset("assets/auth/auth_01.png"),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: theme.primaryColor,
                        child: const Icon(Icons.arrow_forward_outlined, color: Colors.white),
                      ),
                      onTap: () => _goToOnboardingPage(context),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _goToOnboardingPage(BuildContext context) async {
    context.read<OnboardingBloc>().add(const OnboardingEvent.init());
    // context.read<ProfileBloc>().add(const ProfileEvent.loadProfile());
    await Navigator.push(context, MaterialPageRoute(builder: (ctx) => const OnboardingPage()));
  }
}

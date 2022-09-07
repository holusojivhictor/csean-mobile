import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/presentation/onboarding/widgets/dots_row.dart';
import 'package:csean_mobile/presentation/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/about_you.dart';
import 'pages/certifications.dart';
import 'pages/employer_details.dart';
import 'pages/referee.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(25),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BlocBuilder<OnboardingBloc, OnboardingState>(
                  builder: (ctx, state) => state.map(
                    loading: (_) => const Loading(useScaffold: false),
                    firstSection: (_) => const DotsRow(
                      twoHasBorder: true,
                      threeHasBorder: true,
                      fourHasBorder: true,
                    ),
                    secondSection: (_) => const DotsRow(
                      oneHasCheck: true,
                      threeHasBorder: true,
                      fourHasBorder: true,
                    ),
                    thirdSection: (_) => const DotsRow(
                      oneHasCheck: true,
                      twoHasCheck: true,
                      fourHasBorder: true,
                    ),
                    fourthSection: (_) => const DotsRow(
                      oneHasCheck: true,
                      twoHasCheck: true,
                      threeHasCheck: true,
                    ),
                    fifthSection: (_) => const DotsRow(
                      oneHasCheck: true,
                      twoHasCheck: true,
                      threeHasCheck: true,
                    ),
                    finish: (_) => const DotsRow(
                      oneHasCheck: true,
                      twoHasCheck: true,
                      threeHasCheck: true,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                BlocBuilder<OnboardingBloc, OnboardingState>(
                  builder: (ctx, state) => state.map(
                    loading: (_) => const Loading(useScaffold: false),
                    firstSection: (_) => const AboutYou(),
                    secondSection: (_) => const EmployerDetails(),
                    thirdSection: (_) => const Certifications(),
                    fourthSection: (_) => const FirstRefereePage(),
                    fifthSection: (_) => const SecondRefereePage(),
                    finish: (_) => const Loading(useScaffold: false),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

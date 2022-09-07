part of 'onboarding_bloc.dart';

@freezed
class OnboardingState with _$OnboardingState {
  const factory OnboardingState.loading() = _LoadingState;

  const factory OnboardingState.firstSection() = _FirstSection;

  const factory OnboardingState.secondSection() = _SecondSection;

  const factory OnboardingState.thirdSection() = _ThirdSection;

  const factory OnboardingState.fourthSection() = _FourthSection;

  const factory OnboardingState.fifthSection() = _FifthSection;

  const factory OnboardingState.finish() = _FinishedState;
}
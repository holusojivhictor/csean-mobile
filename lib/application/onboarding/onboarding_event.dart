part of 'onboarding_bloc.dart';

@freezed
class OnboardingEvent with _$OnboardingEvent {
  const factory OnboardingEvent.init() = _Init;

  const factory OnboardingEvent.second({
    String? membershipType,
    int? memberChapter,
    String? occupation,
    String? jobTitle,
    @Default(false) bool isEdit,
  }) = _Second;

  const factory OnboardingEvent.third({
    String? companyName,
    String? address,
    String? city,
    String? country,
    @Default(false) bool isEdit,
  }) = _Third;

  const factory OnboardingEvent.fourth({
    String? licenseName,
    String? dateIssued,
    File? licenseDocument,
    File? resumeDocument,
    @Default(false) bool isEdit,
  }) = _Fourth;

  const factory OnboardingEvent.fifth({
    String? refereeName,
    String? refereeOccupation,
    String? refereeEmail,
    String? refereePhone,
    String? refereeRelation,
    @Default(false) bool isEdit,
  }) = _Fifth;

  const factory OnboardingEvent.finish({
    int? status,
    String? refereeName,
    String? refereeOccupation,
    String? refereeEmail,
    String? refereePhone,
    String? refereeRelation,
  }) = _Finish;
}
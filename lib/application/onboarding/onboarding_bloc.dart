import 'dart:io';

import 'package:csean_mobile/domain/services/csean_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboarding_bloc.freezed.dart';
part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final CseanService _cseanService;
  OnboardingBloc(this._cseanService) : super(const OnboardingState.loading());

  @override
  Stream<OnboardingState> mapEventToState(OnboardingEvent event) async* {
    final s = await event.map(
      init: (_) async => _loadFirstSection(),
      second: (e) async => _loadSecondSection(membershipType: e.membershipType, memberChapter: e.memberChapter, occupation: e.occupation, jobTitle: e.jobTitle, isEdit: e.isEdit),
      third: (e) async => _loadThirdSection(companyName: e.companyName, address: e.address, city: e.city, country: e.country, isEdit: e.isEdit),
      fourth: (e) async => _loadFourthSection(licenseName: e.licenseName, dateIssued: e.dateIssued, licenseDocument: e.licenseDocument, resumeDocument: e.resumeDocument, isEdit: e.isEdit),
      fifth: (e) async => _loadFifthSection(refereeName: e.refereeName, refereeOccupation: e.refereeOccupation, refereeEmail: e.refereeEmail, refereePhone: e.refereePhone, refereeRelation: e.refereeRelation, isEdit: e.isEdit),
      finish: (e) async => _finishOnboarding(status: e.status, refereeName: e.refereeName, refereeOccupation: e.refereeOccupation, refereeEmail: e.refereeEmail, refereePhone: e.refereePhone, refereeRelation: e.refereeRelation),
    );

    yield s;
  }

  OnboardingState _loadFirstSection() {
    return const OnboardingState.firstSection();
  }

  Future<OnboardingState> _loadSecondSection({String? membershipType, int? memberChapter, String? occupation, String? jobTitle, bool isEdit = false}) async {
    if (!isEdit) {
      await _cseanService.submitAboutYou(membershipType!, memberChapter!, occupation!, jobTitle!);
    }
    return const OnboardingState.secondSection();
  }

  Future<OnboardingState> _loadThirdSection({String? companyName, String? address, String? city, String? country, bool isEdit = false}) async {
    if (!isEdit) {
      await _cseanService.submitEmployerDetails(companyName!, address!, city!, country!);
    }
    return const OnboardingState.thirdSection();
  }

  Future<OnboardingState> _loadFourthSection({String? licenseName, String? dateIssued, File? licenseDocument, File? resumeDocument, bool isEdit = false}) async {
    if (!isEdit) {
      await _cseanService.submitCertification(licenseName!, dateIssued!, licenseDocument!);
      await _cseanService.submitResume(resumeDocument!);
    }
    return const OnboardingState.fourthSection();
  }

  Future<OnboardingState> _loadFifthSection({String? refereeName, String? refereeOccupation, String? refereeEmail, String? refereePhone, String? refereeRelation, bool isEdit = false}) async {
    if (!isEdit) {
      await _cseanService.submitNewRefereeDetail(refereeName!, refereeOccupation!, refereeEmail!, refereePhone!, refereeRelation!);
      await _cseanService.initProfile();
    }
    return const OnboardingState.fifthSection();
  }

  Future<OnboardingState> _finishOnboarding({int? status, String? refereeName, String? refereeOccupation, String? refereeEmail, String? refereePhone, String? refereeRelation}) async {
    await _cseanService.submitEthicsStatus(status!);
    await _cseanService.submitNewRefereeDetail(refereeName!, refereeOccupation!, refereeEmail!, refereePhone!, refereeRelation!);

    return const OnboardingState.finish();
  }
}
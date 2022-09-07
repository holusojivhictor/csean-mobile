import 'package:csean_mobile/domain/app_constants.dart';
import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/domain/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_bloc.freezed.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final CseanService _cseanService;
  final SettingsService _settingsService;

  ProfileBloc(this._cseanService, this._settingsService) : super(const ProfileState.loading());

  _LoadedState get currentState => state as _LoadedState;

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    final s = await event.when(
      loadProfile: () async {
        final user = _cseanService.getProfileData();

        return _buildInitialState(user);
      },
      updatingProfile: (isUpdating) async {
        if (state is! _LoadedState) {
          return state;
        }

        return currentState.copyWith.call(isUpdating: isUpdating);
      },
      isHeaderSetChanged: (isHeaderSet) async {
        _settingsService.isProfileHeaderSet = isHeaderSet;
        return currentState.copyWith.call(isHeaderSet: isHeaderSet);
      },
      headerImageChanged: (newValue) async {
        _settingsService.headerPath = newValue;
        return currentState.copyWith.call(headerImage: newValue);
      },
      chapterTypeChanged: (newValue) async {
        return currentState.copyWith.call(tempChapterType: newValue);
      },
      makeChangeRequest: (value) async {
        await _cseanService.chapterChangeRequest(value);
        await saveString(key: tempChapterTypeKey, value: value.name);
        return currentState.copyWith.call(requestState: ChapterRequestState.active);
      },
    );

    yield s;
  }

  ProfileState _buildInitialState(UserAccountModel user) {
    ChapterCardModel _toChapterForCard(ChapterModel chapter) {
      return ChapterCardModel(
        id: chapter.id,
        name: chapter.name,
        description: chapter.description,
        officers: chapter.officers,
        extra: chapter.extra,
      );
    }

    ProfileCardModel _toProfileForCard(ProfileModel model) {
      return ProfileCardModel(
        userId: model.userId,
        chapterId: model.chapterId,
        membershipType: model.membershipType,
        currentOccupation: model.currentOccupation,
        jobTitle: model.jobTitle,
        companyName: model.companyName,
        address: model.address,
        city: model.city,
        country: model.country,
        gender: model.genderType,
        dateOfBirth: model.dateOfBirth,
        resume: model.resume,
        chapter: _toChapterForCard(model.chapter ?? ChapterModel(id: 0, name: ChapterType.Lagos, description: '', officers: '', extra: '')),
      );
    }

    final isHeaderSet = _settingsService.isProfileHeaderSet;
    final headerImage = _settingsService.headerPath;
    final profile = _toProfileForCard(user.profile);
    ChapterRequestState requestState = ChapterRequestState.inactive;
    _cseanService.getRequestState(profile.chapter!.name).then((value) => requestState = value);

    return ProfileState.loaded(
      id: user.id,
      type: user.type,
      firstName: user.firstName,
      lastName: user.lastName,
      fullName: user.fullName,
      email: user.email,
      phone: user.phoneNumber,
      status: user.status,
      photoUrl: user.photoUrl,
      profile: profile,
      certificates: user.certificates.map((certificate) {
        return CertificateCardModel(
          id: certificate.id,
          userId: certificate.userId,
          certificateUrl: certificate.certificateUrl,
          certificateName: certificate.certificateName,
          certificationDate: certificate.certificationDate,
          certificateDetails: certificate.certificateDetails,
        );
      }).toList(),
      referees: user.referees.map((referee) {
        return RefereeCardModel(
          id: referee.id,
          userId: referee.userId,
          fullName: referee.fullName,
          occupation: referee.occupation,
          email: referee.email,
          phone: referee.phone,
          relationship: referee.relationship,
          status: referee.status,
        );
      }).toList(),
      headerImage: headerImage,
      isUpdating: false,
      isHeaderSet: isHeaderSet,
      tempChapterType: profile.chapter!.name,
      requestState: requestState,
    );
  }
}
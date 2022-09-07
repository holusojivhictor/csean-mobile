part of 'profile_bloc.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.loading() = _LoadingState;

  const factory ProfileState.loaded({
    required int id,
    required AccountType type,
    required String firstName,
    required String lastName,
    required String fullName,
    required String email,
    required String phone,
    required int status,
    required String photoUrl,
    required ProfileCardModel profile,
    required List<CertificateCardModel> certificates,
    required List<RefereeCardModel> referees,
    required String headerImage,
    required bool isUpdating,
    required bool isHeaderSet,
    required ChapterType tempChapterType,
    required ChapterRequestState requestState,
  }) = _LoadedState;
}
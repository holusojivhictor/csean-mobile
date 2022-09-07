part of 'profile_bloc.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.loadProfile() = _LoadProfile;

  const factory ProfileEvent.updatingProfile({
    required bool isUpdating,
  }) = _UpdatingProfile;

  const factory ProfileEvent.isHeaderSetChanged({
    required bool newValue,
  }) = _IsHeaderSetChanged;

  const factory ProfileEvent.headerImageChanged({
    required String newValue,
  }) = _HeaderImageChanged;

  const factory ProfileEvent.chapterTypeChanged({
    required ChapterType newValue,
  }) = _ChapterTypeChanged;

  const factory ProfileEvent.makeChangeRequest({
    required ChapterType value,
  }) = _MakeChangeRequest;
}

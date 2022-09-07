part of 'data_bloc.dart';

@freezed
class DataEvent with _$DataEvent {
  const factory DataEvent.initData() = _InitData;

  const factory DataEvent.registerForEvent({
    required int id,
  }) = _RegisterForEvent;

  const factory DataEvent.verifyPayment({
    required String reference,
  }) = _VerifyPayment;

  const factory DataEvent.verifyEventPayment({
    required String reference,
  }) = _VerifyEventPayment;

  const factory DataEvent.updateProfile({
    required String firstName,
    required String lastName,
    required String phone,
    required String membershipType,
    required String currentOccupation,
    required String jobTitle,
    required String companyName,
    required String address,
    required String city,
    required String country,
    required String gender,
    required String dateOfBirth,
  }) = _UpdateProfile;

  const factory DataEvent.updateProfilePicture({
    required File image,
  }) = _UpdateProfilePicture;

  const factory DataEvent.getTopicsAndMessages() = _GetTopicsAndMessages;

  const factory DataEvent.sendMessage({
    required int topicId,
    required String message,
  }) = _SendMessage;

  const factory DataEvent.sendProgressReport({
    required int activityId,
    required String description,
    required String dateCompleted,
    required File certificate,
  }) = _SendProgressReport;

  const factory DataEvent.sendTicket({
    required String subject,
    required String message,
    File? attachment,
  }) = _SendTicket;
}
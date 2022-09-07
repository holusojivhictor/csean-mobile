part of 'sign_up_bloc.dart';

@freezed
class SignUpEvent with _$SignUpEvent {
  const factory SignUpEvent.signUp({
    required String firstName,
    required String lastName,
    required String emailAddress,
    required String password,
    required String confirmPassword,
  }) = _SignUp;
}
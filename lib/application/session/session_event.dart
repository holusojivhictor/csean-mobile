part of 'session_bloc.dart';

@freezed
class SessionEvent with _$SessionEvent {
  const factory SessionEvent.appStarted({required bool init}) = _AppStarted;

  const factory SessionEvent.signsUp() = _SignedUp;

  const factory SessionEvent.logsOut() = _LoggedOut;

  const factory SessionEvent.signUp() = _SignUp;

  const factory SessionEvent.signIn() = _SignIn;

  const factory SessionEvent.initStartup() = _InitStartup;
}
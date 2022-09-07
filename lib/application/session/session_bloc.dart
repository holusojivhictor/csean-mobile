import 'package:csean_mobile/domain/services/csean_service.dart';
import 'package:csean_mobile/domain/services/logging_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'session_bloc.freezed.dart';
part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final CseanService _cseanService;
  final LoggingService _logger;

  SessionBloc(this._cseanService, this._logger) : super(const SessionState.unInitialized());

  @override
  Stream<SessionState> mapEventToState(SessionEvent event) async* {
    final s = await event.when(
      appStarted: (e) async => _appStarted(init: e),
      signUp: () async => _yieldSignUp(),
      signIn: () async => _yieldSignIn(),
      signsUp: () async => _yieldVerify(),
      initStartup: () async => _initStartup(),
      logsOut: () async => _logOut(),
    );

    yield* s;
  }

  Stream<SessionState> _appStarted({bool init = false}) async* {
    if (init) {
      await Future.delayed(const Duration(milliseconds: 4500));
    }

    // yield* _initStartup();
    yield const SessionState.unAuthenticated();
  }

  Stream<SessionState> _initStartup() async* {
    final hasToken = await checkToken();

    if (!hasToken) {
      yield const SessionState.unAuthenticated();
      return;
    }

    await _cseanService.getToken();
    await _cseanService.init();
    final userData = _cseanService.getProfileData();
    _logger.info(runtimeType, 'User status is ${userData.status} ...');

    if (userData.profile.terms == 1) {
      yield const SessionState.authenticated();
      return;
    }

    if (userData.status == 0) {
      yield const SessionState.onboardingAuth();
      return;
    }

    yield const SessionState.authenticated();
  }

  Stream<SessionState> _yieldVerify() async* {

    yield const SessionState.signUpDoneState();
  }

  Stream<SessionState> _logOut() async* {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    yield const SessionState.unAuthenticated();
  }

  Future<void> deleteToken(String token) async {
  }

  Future<bool> checkToken() async {
    final tokenCheck = await _cseanService.isTokenActive();

    return tokenCheck;
  }

  Stream<SessionState> _yieldSignUp() async* {

    yield const SessionState.signUpState();
  }

  Stream<SessionState> _yieldSignIn() async* {

    yield const SessionState.signInState();
  }
}
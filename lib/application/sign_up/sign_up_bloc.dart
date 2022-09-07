import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/application/result_state/result_state.dart';
import 'package:csean_mobile/domain/models/network/api_result.dart';
import 'package:csean_mobile/domain/models/network/network_exceptions.dart';
import 'package:csean_mobile/domain/services/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_bloc.freezed.dart';
part 'sign_up_event.dart';

class SignUpBloc extends Bloc<SignUpEvent, ResultState<Response>> {
  final AuthService _authService;
  final SessionBloc _sessionBloc;

  SignUpBloc(this._authService, this._sessionBloc) : super(const ResultState.idle());

  @override
  Stream<ResultState<Response>> mapEventToState(SignUpEvent event) async* {
    yield const ResultState.loading();

    if (event is _SignUp) {
      ApiResult<Response> apiResult = await _authService.registerAccount(event.firstName, event.lastName, event.emailAddress, event.password, event.confirmPassword);

      yield* apiResult.when(
        success: (Response response) async* {
          _sessionBloc.add(const SessionEvent.signsUp());
          yield ResultState.data(data: response);
        },
        failure: (NetworkExceptions error) async* {
          yield ResultState.error(error: error);
        },
      );
    }
  }
}
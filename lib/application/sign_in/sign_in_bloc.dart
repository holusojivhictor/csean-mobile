import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/application/result_state/result_state.dart';
import 'package:csean_mobile/domain/app_constants.dart';
import 'package:csean_mobile/domain/models/network/api_result.dart';
import 'package:csean_mobile/domain/models/network/network_exceptions.dart';
import 'package:csean_mobile/domain/services/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_bloc.freezed.dart';
part 'sign_in_event.dart';

class SignInBloc extends Bloc<SignInEvent, ResultState<Response>> {
  final AuthService _authService;
  final SessionBloc _sessionBloc;

  SignInBloc(this._authService, this._sessionBloc) : super(const ResultState.idle());

  @override
  Stream<ResultState<Response>> mapEventToState(SignInEvent event) async* {
    yield const ResultState.loading();

    if (event is _SignIn) {
      ApiResult<Response> apiResult = await _authService.login(event.email, event.password);

      yield* apiResult.when(
        success: (Response response) async* {
          final json = response.data as Map<String, dynamic>;
          final token = json["data"]["access_token"];
          await saveString(key: tokenStorageKey, value: token);
          _sessionBloc.add(const SessionEvent.initStartup());
          yield ResultState.data(data: response);
        },
        failure: (NetworkExceptions error) async* {
          yield ResultState.error(error: error);
        },
      );
    }
  }
}

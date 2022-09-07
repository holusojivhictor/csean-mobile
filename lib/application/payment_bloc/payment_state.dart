part of 'payment_bloc.dart';

@freezed
class PaymentState with _$PaymentState {
  const factory PaymentState.loading() = _LoadingState;

  const factory PaymentState.loaded({
    required double amount,
    required String emailAddress,
    required String accessCode,
    required String reference,
  }) = _LoadedState;
}
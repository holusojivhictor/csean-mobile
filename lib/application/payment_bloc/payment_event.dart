part of 'payment_bloc.dart';

@freezed
class PaymentEvent with _$PaymentEvent {
  const factory PaymentEvent.loadDetails() = _LoadDetails;

  const factory PaymentEvent.loadEventDetails({
    required int id,
}) = _LoadEventDetails;
}
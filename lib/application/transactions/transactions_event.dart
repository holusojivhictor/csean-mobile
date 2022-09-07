part of 'transactions_bloc.dart';

@freezed
class TransactionsEvent with _$TransactionsEvent {
  const factory TransactionsEvent.init() = _Init;

  const factory TransactionsEvent.historyFilterTypeChanged(PaymentHistoryFilterType? historyFilterType) = _HistoryFilterTypeChanged;

  const factory TransactionsEvent.applyFilterChanges() = _ApplyFilterChanges;
}
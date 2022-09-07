part of 'transactions_bloc.dart';

@freezed
class TransactionsState with _$TransactionsState {
  const factory TransactionsState.loading() = _LoadingState;

  const factory TransactionsState.loaded({
    required bool memberSubscribed,
    required double amount,
    required int gracePeriod,
    required List<TransactionCardModel> transactions,
    PaymentHistoryFilterType? historyFilterType,
    PaymentHistoryFilterType? tempHistoryFilterType,
  }) = _LoadedState;
}
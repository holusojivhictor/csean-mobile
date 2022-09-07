import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:csean_mobile/domain/extensions/int_extensions.dart';
import 'package:csean_mobile/domain/extensions/string_extensions.dart';
import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/domain/services/csean_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transactions_bloc.freezed.dart';
part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final CseanService _cseanService;

  TransactionsBloc(this._cseanService) : super(const TransactionsState.loading());

  _LoadedState get currentState => state as _LoadedState;

  @override
  Stream<TransactionsState> mapEventToState(TransactionsEvent event) async* {
    final s = event.map(
      init: (_) => _buildInitialState(),
      historyFilterTypeChanged: (e) => currentState.copyWith.call(tempHistoryFilterType: e.historyFilterType),
      applyFilterChanges: (_) => _buildInitialState(historyFilterType: currentState.tempHistoryFilterType),
    );

    yield s;
  }

  TransactionsState _buildInitialState({
    PaymentHistoryFilterType? historyFilterType,
  }) {
    final isLoaded = state is _LoadedState;
    var data = _cseanService.getTransactionsForCard();
    final userData = _cseanService.getProfileData();
    final subscriptionData = _cseanService.getSubscriptionData();
    final now = DateTime.now();

    if (!isLoaded) {
      return TransactionsState.loaded(
        memberSubscribed: userData.subscription.parseToBool(),
        amount: subscriptionData.amount,
        gracePeriod: subscriptionData.gracePeriod,
        transactions: data,
        historyFilterType: historyFilterType,
        tempHistoryFilterType: historyFilterType,
      );
    }

    switch (historyFilterType) {
      case PaymentHistoryFilterType.week:
        data = data.where((el) => el.createdAt.parseDateString().isAfter(now.subtract(const Duration(days: 7)))).toList();
        break;
      case PaymentHistoryFilterType.month:
        data = data.where((el) => el.createdAt.parseDateString().isAfter(now.subtract(const Duration(days: 30)))).toList();
        break;
      case PaymentHistoryFilterType.year:
        data = data.where((el) => el.createdAt.parseDateString().isAfter(now.subtract(const Duration(days: 365)))).toList();
        break;
      default:
        break;
    }

    final s = currentState.copyWith.call(
      transactions: data,
      historyFilterType: historyFilterType,
      tempHistoryFilterType: historyFilterType,
    );

    return s;
  }
}
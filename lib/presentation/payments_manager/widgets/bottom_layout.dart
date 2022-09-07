import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/assets.dart';
import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/presentation/payments_manager/widgets/action_box.dart';
import 'package:csean_mobile/presentation/payments_manager/widgets/history_card.dart';
import 'package:csean_mobile/presentation/shared/choice/choice_bar_wout_icon.dart';
import 'package:csean_mobile/presentation/shared/clickable_title.dart';
import 'package:csean_mobile/presentation/shared/details/constants.dart';
import 'package:csean_mobile/presentation/shared/loading.dart';
import 'package:csean_mobile/presentation/shared/nothing_found_column.dart';
import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageBottomLayout extends StatelessWidget {
  final List<TransactionCardModel> transactions;
  final int? selectedValue;
  final bool isSubscribed;
  const PageBottomLayout({Key? key, required this.transactions, this.selectedValue, required this.isSubscribed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final maxTopHeight = getPaymentPageTopHeight(context) - 50;
    return Container(
      margin: EdgeInsets.only(top: maxTopHeight),
      child: Padding(
        padding: Styles.edgeInsetAll10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BlocBuilder<PaymentBloc, PaymentState>(
              builder: (ctx, state) => state.map(
                loading: (_) => const Loading(useScaffold: false),
                loaded: (state) => ActionBox(
                  amount: state.amount,
                  accessCode: state.accessCode,
                  emailAddress: state.emailAddress,
                  reference: state.reference,
                  isSubscribed: isSubscribed,
                ),
              ),
            ),
            ClickableTitle(title: 'Payment History', textStyle: Theme.of(context).textTheme.headline4),
            ChoiceBarWithoutIconWithAllValue(
              sort: false,
              values: PaymentHistoryFilterType.values.map((e) => e.index).toList(),
              selectedValue: selectedValue,
              onAllOrValueSelected: (v) {
                context.read<TransactionsBloc>().add(TransactionsEvent.historyFilterTypeChanged(v != null ? PaymentHistoryFilterType.values[v] : null));
                context.read<TransactionsBloc>().add(const TransactionsEvent.applyFilterChanges());
              },
              choiceText: (val, _) => Assets.translatePaymentHistoryFilterType(PaymentHistoryFilterType.values[val]),
            ),
            if (transactions.isNotEmpty)
              _buildList(context, transactions)
            else
              NothingFoundColumn(msg: 'No transactions to show', iconSize: 50, textStyle: Theme.of(context).textTheme.headline4),
          ],
        ),
      ),
    );
  }
  
  Widget _buildList(BuildContext context, List<TransactionCardModel> transactions) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: transactions.length,
      itemBuilder: (ctx, index) {
        final e = transactions[index];
        return HistoryCard.item(transaction: e);
      },
    );
  }
}

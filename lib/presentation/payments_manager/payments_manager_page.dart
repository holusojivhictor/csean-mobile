import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/presentation/payments_manager/widgets/bottom_layout.dart';
import 'package:csean_mobile/presentation/payments_manager/widgets/top_layout.dart';
import 'package:csean_mobile/presentation/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentsManagerPage extends StatelessWidget {
  const PaymentsManagerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsBloc, TransactionsState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const Loading(),
        loaded: (state) => Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Stack(
                fit: StackFit.passthrough,
                clipBehavior: Clip.none,
                children: [
                  PageTopLayout(
                    amount: state.amount,
                    isSubscribed: state.memberSubscribed,
                  ),
                  PageBottomLayout(
                    selectedValue: state.tempHistoryFilterType?.index,
                    transactions: state.transactions,
                    isSubscribed: state.memberSubscribed,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

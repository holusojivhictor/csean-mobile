import 'package:csean_mobile/presentation/payments_manager/widgets/pinned_box.dart';
import 'package:csean_mobile/presentation/shared/custom_card.dart';
import 'package:csean_mobile/presentation/shared/details/constants.dart';
import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';

class PageTopLayout extends StatelessWidget {
  final double amount;
  final bool isSubscribed;

  const PageTopLayout({
    Key? key,
    required this.amount,
    required this.isSubscribed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final maxHeight = getPaymentPageTopHeight(context);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFADD2BA),
            Color(0xFFE0EEE4),
            Color(0xFFFCFDFC),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      height: maxHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: Colors.black),
            elevation: 0,
            title: Text('Payments Manager', style: Theme.of(context).textTheme.headline2),
          ),
          CustomCard(
            margin: Styles.edgeInsetAll10,
            child: Padding(
              padding: Styles.edgeInsetAll16,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Amount unpaid',
                    style: theme.textTheme.bodyText1,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'NGN ${isSubscribed ? 0 : amount.toStringAsFixed(2)}',
                    style: theme.textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      PinnedBox(title: 'Total', amount: amount),
                      PinnedBox(title: 'Paid', amount: isSubscribed ? amount : 0.0),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

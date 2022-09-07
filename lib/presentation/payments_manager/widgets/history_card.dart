import 'package:csean_mobile/domain/app_constants.dart';
import 'package:csean_mobile/domain/extensions/string_extensions.dart';
import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/presentation/shared/custom_card.dart';
import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  final int id;
  final double amount;
  final String package;
  final String createdAt;

  final bool withElevation;

  const HistoryCard({
    Key? key,
    required this.id,
    required this.amount,
    required this.package,
    required this.createdAt,
    this.withElevation = true,
  }) : super(key: key);

  HistoryCard.item({
    Key? key,
    required TransactionCardModel transaction,
    this.withElevation = false,
  })  : id = transaction.id,
        amount = transaction.amount,
        package = transaction.package,
        createdAt = transaction.createdAt,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: Styles.mainCardBorderRadius,
      onTap: () {},
      child: CustomCard(
        clipBehavior: Clip.hardEdge,
        margin: Styles.edgeInsetAll10,
        shape: Styles.mainCardShape,
        elevation: withElevation ? Styles.cardTenElevation : 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey.withOpacity(0.2),
                      child: const Icon(Icons.paypal, color: Colors.black87),
                    ),
                  ),
                  Expanded(
                    flex: 70,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            package,
                            style: Theme.of(context).textTheme.headline2!.copyWith(fontWeight: FontWeight.w300, fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                '${createdAt.formatDateString()}, ${createdAt.formatTimeString(hasYear: true)}',
                                style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 13, fontWeight: FontWeight.normal),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Text(
                      '${getCurrency()}$amount',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontFamily: 'DejaVuSans', fontSize: 14),
                    ),
                  ),
                ],
              ),
              const Divider(color: Colors.grey, indent: 5, height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

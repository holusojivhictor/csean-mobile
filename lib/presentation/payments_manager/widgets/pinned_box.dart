import 'package:csean_mobile/domain/app_constants.dart';
import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';

class PinnedBox extends StatelessWidget {
  final String title;
  final double amount;

  const PinnedBox({Key? key, required this.title, required this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: Styles.edgeInsetAll10,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          const Positioned(
            left: 0.0,
            top: 0.0,
            child: CircleAvatar(
              radius: 3,
              backgroundColor: Colors.black,
            ),
          ),
          Padding(
            padding: Styles.edgeInsetAll3,
            child: Column(
              children: [
                Text(title),
                Text(
                  '${getCurrency()}$amount',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(fontFamily: 'DejaVuSans', fontWeight: FontWeight.w200),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

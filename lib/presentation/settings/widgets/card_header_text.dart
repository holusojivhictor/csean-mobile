import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';

class CardHeaderText extends StatelessWidget {
  final String title;
  final bool isTop;
  const CardHeaderText({Key? key, required this.title, this.isTop = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: isTop ? Styles.edgeInsetHorizontal16Top10 : Styles.edgeInsetHorizontal16,
      child: Row(
        children: [
          Text(
            title,
            textAlign: TextAlign.start,
            style: theme.textTheme.bodyText1!.copyWith(letterSpacing: 0.15, color: Colors.grey, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class NothingFound extends StatelessWidget {
  final String? msg;
  final IconData icon;
  final double iconSize;
  final EdgeInsets padding;
  final TextStyle? textStyle;
  const NothingFound({
    Key? key,
    this.msg,
    this.icon = Icons.info,
    this.iconSize = 60,
    this.textStyle,
    this.padding = const EdgeInsets.only(bottom: 30, right: 20, left: 20),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: padding,
      child: Center(
        child: Column(
          children: <Widget>[
            Icon(
              icon,
              color: theme.primaryColor,
              size: iconSize,
            ),
            Text(
              msg ?? 'Nothing to show',
              textAlign: TextAlign.center,
              style: textStyle ?? theme.textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}

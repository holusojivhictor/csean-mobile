import 'package:flutter/material.dart';

class PageDot extends StatelessWidget {
  final String text;
  final bool hasBorder;
  final bool hasCheck;

  const PageDot({
    Key? key,
    required this.text,
    this.hasBorder = false,
    this.hasCheck = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.only(top: hasCheck ? 0 : 3),
      height: 25,
      width: 25,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: hasBorder ? Colors.white : theme.primaryColor,
        border: hasBorder ? Border.all(color: theme.primaryColor) : null,
      ),
      child: !hasCheck ? Text(text,
        style: theme.textTheme.headline4!.copyWith(color: hasBorder ? theme.primaryColor : Colors.white),
        textAlign: TextAlign.center,
      ) : const Icon(Icons.check, color: Colors.white, size: 15),
    );
  }
}

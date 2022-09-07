import 'package:flutter/material.dart';

import 'nothing_found.dart';

class NothingFoundColumn extends StatelessWidget {
  final String? msg;
  final IconData icon;
  final double iconSize;
  final EdgeInsets padding;
  final TextStyle? textStyle;
  const NothingFoundColumn({
    Key? key,
    this.msg,
    this.icon = Icons.info,
    this.iconSize = 60,
    this.textStyle,
    this.padding = const EdgeInsets.only(bottom: 30, right: 20, left: 20),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [NothingFound(msg: msg, icon: icon, iconSize: iconSize, padding: padding, textStyle: textStyle)],
    );
  }
}

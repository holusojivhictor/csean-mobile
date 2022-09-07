import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class DetailBottomLayout extends StatelessWidget {
  final bool isBlog;
  final List<Widget> children;
  const DetailBottomLayout({Key? key, required this.children, this.isBlog = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final maxTopHeight = getTopMarginForPortrait(context, false);
    return Card(
      margin: EdgeInsets.only(top: maxTopHeight),
      shape: Styles.cardItemDetailShape,
      color: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      child: Padding(
        padding: isBlog ? Styles.edgeInsetAll10 : Styles.edgeInsetAll16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      ),
    );
  }
}

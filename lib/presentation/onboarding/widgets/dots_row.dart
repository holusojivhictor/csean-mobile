import 'package:flutter/material.dart';

import 'page_dot.dart';

class DotsRow extends StatelessWidget {
  final bool oneHasCheck;
  final bool oneHasBorder;
  final bool twoHasCheck;
  final bool twoHasBorder;
  final bool threeHasCheck;
  final bool threeHasBorder;
  final bool fourHasCheck;
  final bool fourHasBorder;

  const DotsRow({
    Key? key,
    this.oneHasCheck = false,
    this.oneHasBorder = false,
    this.twoHasBorder = false,
    this.twoHasCheck = false,
    this.threeHasBorder = false,
    this.threeHasCheck = false,
    this.fourHasBorder = false,
    this.fourHasCheck = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 10,
          right: 0,
          left: 0,
          child: Container(
            height: 1,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PageDot(
              text: '1',
              hasCheck: oneHasCheck,
              hasBorder: oneHasBorder,
            ),
            PageDot(
              text: '2',
              hasBorder: twoHasBorder,
              hasCheck: twoHasCheck,
            ),
            PageDot(
              text: '3',
              hasBorder: threeHasBorder,
              hasCheck: threeHasCheck,
            ),
            PageDot(
              text: '4',
              hasBorder: fourHasBorder,
              hasCheck: fourHasCheck,
            ),
          ],
        ),
      ],
    );
  }
}

import 'dart:math' as math;
import 'package:flutter/material.dart';

class FreePaidAvatar extends StatelessWidget {
  final String text;
  const FreePaidAvatar({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: CircleAvatar(
        radius: 15,
        backgroundColor: theme.primaryColor.withOpacity(0.4),
        child: Transform.rotate(
          angle: -math.pi / 4,
          child: Text(
            text,
            style: theme.textTheme.bodyText2!.copyWith(fontSize: 9, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

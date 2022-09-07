import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  final String text;
  final bool isAlt;
  const HeaderText({
    Key? key,
    required this.text,
    this.isAlt = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: isAlt ? 10 : 15),
      child: Column(
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: isAlt ? 15 : 18),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  final String headerText;
  final String bodyText;

  const TextBox({Key? key, required this.headerText, required this.bodyText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headerText,
          style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 15),
        SizedBox(
          child: Text(
            bodyText,
            style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 18),
          ),
        ),
      ],
    );
  }
}

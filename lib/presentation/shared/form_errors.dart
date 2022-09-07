import 'package:flutter/material.dart';

class FormErrors extends StatelessWidget {
  final List<String> errors;
  const FormErrors({Key? key, required this.errors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(errors.length, (index) => formErrorText(errors[index])),
    );
  }

  Row formErrorText(String error) {
    return Row(
      children: [
        const Icon(Icons.error_outline, size: 15, color: Colors.redAccent),
        const SizedBox(width: 5),
        Text(error),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../../theme.dart';

typedef Validator = String? Function(String?);
typedef OnChanged = void Function(String);

class OnboardingFormField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String? initialValue;
  final TextInputType textInputType;
  final String? hintText;
  final Validator? validator;
  final OnChanged? onChanged;
  final bool enabled;
  final bool readOnly;
  final int maxLines;
  final bool isSubmitted;
  final String? errorText;
  final int? maxLength;

  const OnboardingFormField({
    Key? key,
    required this.textInputType,
    this.textEditingController,
    this.initialValue,
    this.hintText,
    this.validator,
    this.onChanged,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.isSubmitted = false,
    this.errorText,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: isSubmitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
      controller: textEditingController,
      initialValue: initialValue,
      readOnly: readOnly,
      maxLines: maxLines,
      onSaved: (value) {
        textEditingController!.text = value ?? "";
      },
      onChanged: onChanged,
      validator: validator,
      keyboardType: textInputType,
      maxLength: maxLength,
      decoration: InputDecoration(
        counter: maxLength != null ? const Offstage() : null,
        errorText: errorText,
        contentPadding: Styles.formFieldPadding,
        disabledBorder: Styles.onboardingFieldBorder,
        enabledBorder: Styles.onboardingFieldBorder,
        border: Styles.onboardingFieldBorder,
        hintText: hintText,
        enabled: enabled,
        hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(color: Theme.of(context).indicatorColor.withOpacity(0.6)),
      ),
    );
  }
}

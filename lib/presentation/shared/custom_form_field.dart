import 'package:csean_mobile/presentation/shared/row_text.dart';
import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';

typedef Validator = String? Function(String?);
typedef OnChanged = void Function(String);

class CustomFormField extends StatelessWidget {
  final String text;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final bool obscureText;
  final Widget? suffixIcon;
  final Validator? validator;
  final OnChanged? onChanged;
  final String? errorText;
  final bool isSubmitted;
  final int? maxLength;

  const CustomFormField({
    Key? key,
    required this.text,
    required this.textEditingController,
    required this.textInputType,
    this.isSubmitted = false,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.errorText,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: Styles.formFieldMargin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RowText(text: text),
          const SizedBox(height: 8),
          TextFormField(
            autovalidateMode: isSubmitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
            controller: textEditingController,
            obscureText: obscureText,
            onSaved: (value) {
              textEditingController.text = value ?? "";
            },
            onChanged: onChanged,
            validator: validator,
            keyboardType: textInputType,
            maxLength: maxLength,
            decoration: InputDecoration(
              counter: maxLength != null ? const Offstage() : null,
              filled: true,
              errorText: errorText,
              suffixIcon: suffixIcon,
              fillColor: Colors.white,
              contentPadding: Styles.formFieldPadding,
              border: Styles.formFieldBorder,
              hintText: 'Enter your ${text.toLowerCase()}',
              hintStyle: theme.textTheme.bodyText1!.copyWith(color: theme.indicatorColor.withOpacity(0.6)),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomEditFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController? textEditingController;
  final TextInputType textInputType;
  final String? initialValue;
  final Widget? suffix;
  final bool enabled;
  final bool readOnly;
  final bool hasSpace;

  const CustomEditFormField({
    Key? key,
    required this.hintText,
    this.textEditingController,
    required this.textInputType,
    this.enabled = true,
    this.readOnly = false,
    this.hasSpace = true,
    this.initialValue,
    this.suffix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: Styles.editFormFieldMargin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RowText(text: hintText, color: Colors.black54),
          if (hasSpace)
            const SizedBox(height: 2),
          TextFormField(
            controller: textEditingController,
            initialValue: initialValue,
            readOnly: readOnly,
            style: theme.textTheme.headline4!.copyWith(fontSize: 17),
            decoration: InputDecoration(
              contentPadding: hasSpace ? Styles.editFormFieldPadding : EdgeInsets.zero,
              border: Styles.editFormFieldBorder,
              focusedBorder: Styles.editFormFieldBorder,
              enabledBorder: Styles.editFormFieldBorder,
              suffix: suffix,
              enabled: enabled,
              isCollapsed: true,
              filled: false,
            ),
          ),
        ],
      ),
    );
  }
}


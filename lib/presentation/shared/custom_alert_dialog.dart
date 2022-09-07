import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';
import 'package:csean_mobile/presentation/shared/extensions/media_query_extensions.dart';

class CustomAlertDialog extends StatelessWidget {
  final String text;
  final bool isError;
  final Widget? title;

  const CustomAlertDialog({
    Key? key,
    required this.text,
    this.isError = false,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return AlertDialog(
      title: title,
      content: SizedBox(
        width: mediaQuery.getWidthForDialogs(),
        child: Row(
          children: [
            if (!isError) const CircularProgressIndicator(),
            SizedBox(width: isError ? 0 : 20),
            Text(text),
          ],
        ),
      ),
      contentPadding: title != null ? Styles.altAlertContentPadding : Styles.signAlertContentPadding,
      shape: Styles.alertDialogShape,
      actions: [
        if (isError)
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
      ],
    );
  }
}

class PickerAlertDialog extends StatelessWidget {
  final int itemCount;
  final Widget child;

  const PickerAlertDialog({
    Key? key,
    required this.itemCount,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return AlertDialog(
      content: SizedBox(
        width: mediaQuery.getWidthForDialogs(),
        height: mediaQuery.getHeightForDialogs(itemCount),
        child: child,
      ),
      contentPadding: Styles.pickerAlertContentPadding,
      shape: Styles.alertDialogShape,
    );
  }
}


class CommonAlertDialog extends StatelessWidget {
  final String titleText;
  final String contentText;
  final String? cancelText;
  final String actionText;
  final void Function()? cancelOnPressed;
  final void Function()? actionOnPressed;

  const CommonAlertDialog({
    Key? key,
    required this.titleText,
    required this.contentText,
    this.cancelText,
    required this.actionText,
    this.cancelOnPressed,
    required this.actionOnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    return AlertDialog(
      shape: Styles.alertDialogShape,
      title: Text(
        titleText,
        style: theme.textTheme.headline2,
      ),
      content: SizedBox(
        width: mediaQuery.getWidthForDialogs(),
        child: Text(
          contentText,
        ),
      ),
      contentPadding: Styles.alertContentPadding,
      actions: [
        if (cancelText != null)
          TextButton(
            onPressed: cancelOnPressed != null ? () => cancelOnPressed!() : () => Navigator.of(context).pop(),
            child: Text(cancelText!),
          ),
        TextButton(
          onPressed: actionOnPressed != null ? () => actionOnPressed!() : null,
          child: Text(actionText),
        ),
      ],
    );
  }
}
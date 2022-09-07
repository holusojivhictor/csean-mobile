import 'package:flutter/material.dart';

class ProceedButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final bool isBack;
  final bool isPressed;

  const ProceedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isBack = false,
    this.isPressed = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(theme.primaryColor),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
          ),
        ),
        child: Row(
          children: [
            Text(text, style: theme.textTheme.bodyText1!.copyWith(color: Colors.white)),
            SizedBox(width: !isBack ? 15 : 0),
            if (!isBack)
              isPressed ? const SizedBox(height: 25, width: 25, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) : const Icon(Icons.arrow_forward_outlined, size: 19),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}

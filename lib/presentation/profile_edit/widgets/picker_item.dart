import 'package:flutter/material.dart';

class PickerItem extends StatelessWidget {
  final String textString;
  final void Function()? onTap;

  const PickerItem({
    required this.textString,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap != null ? () => onTap!() : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(textString),
          ],
        ),
      ),
    );
  }
}
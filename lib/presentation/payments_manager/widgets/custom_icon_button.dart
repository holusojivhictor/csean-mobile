import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final String subTitle;
  final void Function() onPressed;

  const CustomIconButton({
    Key? key,
    required this.icon,
    required this.subTitle,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.white,
          shape: Styles.mainCardShape,
          child: IconButton(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            visualDensity: const VisualDensity(vertical: -3),
            onPressed: onPressed,
            icon: Icon(icon),
          ),
        ),
        Text(subTitle),
      ],
    );
  }
}

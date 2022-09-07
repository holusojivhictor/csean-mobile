import 'package:flutter/material.dart';

class IconTextRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  const IconTextRow({
    Key? key,
    required this.icon,
    required this.text,
    this.iconColor = Colors.black54,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 22, color: iconColor),
        const SizedBox(width: 5),
        Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 15, color: Colors.black87),
        ),
      ],
    );
  }
}

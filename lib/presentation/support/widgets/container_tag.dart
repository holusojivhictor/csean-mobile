import 'package:flutter/material.dart';

class ContainerTag extends StatelessWidget {
  final Color color;
  final bool hasBorder;
  final String tagText;
  const ContainerTag({
    Key? key,
    this.color = Colors.white,
    this.hasBorder = true,
    required this.tagText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: hasBorder ? Colors.grey.withOpacity(0.5) : Colors.white),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(tagText),
    );
  }
}

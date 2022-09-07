import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';

class CustomChoiceButton<T> extends StatelessWidget {
  final T value;
  final String valueText;
  final TextStyle? textStyle;
  final void Function(T value)? onPressed;
  final bool isSelected;

  const CustomChoiceButton({
    Key? key,
    required this.value,
    required this.valueText,
    required this.textStyle,
    required this.onPressed,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed != null ? () => onPressed!(value) : null,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black54),
        ),
        child: Padding(
          padding: Styles.edgeInsetSymmetric10,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ChoiceCircle(
                isSelected: isSelected,
              ),
              const SizedBox(width: 5),
              Text(
                valueText,
                style: textStyle,
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class ChoiceCircle extends StatelessWidget {
  final bool isSelected;
  const ChoiceCircle({
    Key? key,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
        border: Border.all(color: Colors.black54),
      ),
      child: Container(
        padding: Styles.edgeInsetAll5,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
        ),
      ),
    );
  }
}
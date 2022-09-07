import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';

class AltCommonChoiceButton<T> extends StatelessWidget {
  final T value;
  final String valueText;
  final TextStyle? textStyle;
  final void Function(T value)? onPressed;
  final bool isSelected;
  final IconData? iconData;

  const AltCommonChoiceButton({
    Key? key,
    required this.value,
    required this.valueText,
    required this.textStyle,
    required this.onPressed,
    required this.isSelected,
    this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onPressed != null ? () => onPressed!(value) : null,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? theme.primaryColor : theme.primaryColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: Styles.edgeInsetSymmetric8,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (iconData != null)
                AltChoiceCircle(
                  isSelected: isSelected,
                  iconData: iconData!,
                ),
              Padding(
                padding: EdgeInsets.only(left: iconData != null ? 5 : 10, right: 10),
                child: Text(
                  valueText,
                  style: textStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AltChoiceCircle extends StatelessWidget {
  final bool isSelected;
  final IconData iconData;

  const AltChoiceCircle({
    Key? key,
    required this.isSelected,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Icon(iconData, size: 14),
    );
  }
}
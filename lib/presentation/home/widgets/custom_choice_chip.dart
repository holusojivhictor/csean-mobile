import 'package:flutter/material.dart';

class CustomChoiceChip extends StatelessWidget {
  final String labelText;
  final bool selected;
  final Function(bool)? onSelected;

  const CustomChoiceChip({
    Key? key,
    required this.labelText,
    required this.selected,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(right: 15, top: 5),
      child: ChoiceChip(
        label: Text(labelText),
        labelStyle: theme.textTheme.bodyText2!.copyWith(color: theme.dividerColor),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        selected: selected,
        onSelected: onSelected,
        selectedColor: theme.primaryColor,
      ),
    );
  }
}

import 'package:csean_mobile/domain/app_constants.dart';
import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';

class ChoiceButtons extends StatelessWidget {
  final String selectedValue;
  final Function(String) onClick;
  const ChoiceButtons({
    Key? key,
    required this.onClick,
    this.selectedValue = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttons = membershipTypes.map((e) => _buildButton(context, e)).toList();

    return Wrap(
      alignment: WrapAlignment.start,
      children: buttons,
    );
  }

  Widget _buildButton(BuildContext context, String value) {
    final theme = Theme.of(context);
    final isSelected = selectedValue.contains(value);
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(Styles.edgeInsetHorizontal16),
          backgroundColor: MaterialStateProperty.all<Color>(!isSelected ? Colors.transparent : theme.primaryColor.withOpacity(0.6)),
          side: MaterialStateProperty.all<BorderSide>(const BorderSide()),
        ),
        child: Text(
          value,
          style: isSelected ? theme.textTheme.bodyText2!.copyWith(color: theme.dividerColor) : theme.textTheme.bodyText2,
        ),
        onPressed: () => onClick(value),
      ),
    );
  }
}

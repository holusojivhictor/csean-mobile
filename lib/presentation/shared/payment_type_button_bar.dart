import 'package:csean_mobile/domain/assets.dart';
import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:flutter/material.dart';

class PaymentTypeButtonBar extends StatelessWidget {
  final List<EventPaymentType> selectedValues;
  final Function(EventPaymentType) onClick;

  const PaymentTypeButtonBar({
    Key? key,
    required this.onClick,
    this.selectedValues = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttons = EventPaymentType.values.map((e) => _buildTextButton(context, e, Assets.translateEventPaymentType(e))).toList();

    return Wrap(
      spacing: 15,
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.start,
      children: buttons,
    );
  }

  Widget _buildTextButton(BuildContext context, EventPaymentType value, String valueText) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyText2;
    final isSelected = selectedValues.isEmpty || !selectedValues.contains(value);
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 30)),
        backgroundColor: MaterialStateProperty.all<Color>(!isSelected ? theme.primaryColor.withOpacity(0.7) : Colors.transparent),
        side: MaterialStateProperty.all<BorderSide>(!isSelected ? BorderSide.none : const BorderSide()),
      ),
      onPressed: () => onClick(value),
      child: Text(
        valueText,
        style: !isSelected ? textStyle!.copyWith(color: theme.dividerColor) : textStyle,
      ),
    );
  }
}

import 'package:csean_mobile/presentation/shared/choice/alt_common_choice_button.dart';
import 'package:csean_mobile/presentation/shared/utils/enum_utils.dart';
import 'package:flutter/material.dart';

typedef ChoiceButtonText<T> = String Function(T value, int index);
typedef ChoiceButtonIcon<T> = IconData Function(T value, int index);

class ChoiceBarWithIcon<TEnum> extends StatelessWidget {
  final TEnum selectedValue;
  final List<TEnum> values;
  final Function(TEnum)? onSelected;
  final List<TEnum> exclude;
  final ChoiceButtonText<TEnum> choiceText;
  final ChoiceButtonIcon<TEnum> iconData;
  final WrapAlignment alignment;

  const ChoiceBarWithIcon({
    Key? key,
    required this.selectedValue,
    required this.values,
    this.onSelected,
    this.exclude = const [],
    this.alignment = WrapAlignment.start,
    required this.choiceText,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final translatedValues = getTranslatedValues();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      child: Wrap(
        spacing: 10,
        runSpacing: 5,
        alignment: alignment,
        children: getButtons(context, translatedValues),
      ),
    );
  }

  List<TranslatedEnumWithIcon<TEnum>> getTranslatedValues() {
    return EnumUtils.getTranslatedAndSortedEnumWithIcon<TEnum>(values, choiceText, iconData, exclude: exclude);
  }

  List<Widget> getButtons(BuildContext context, List<TranslatedEnumWithIcon<TEnum>> translatedValues) {
    return translatedValues.map((e) => _buildChoiceButton(context, e.enumValue, e.translation, e.iconData)).toList();
  }

  Widget _buildChoiceButton(BuildContext context, TEnum value, String valueText, IconData iconData) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyText2!.copyWith(color: Colors.white);
    final isSelected = selectedValue == value;
    return AltCommonChoiceButton<TEnum>(
      value: value,
      isSelected: isSelected,
      valueText: valueText,
      textStyle: textStyle,
      iconData: iconData,
      onPressed: handleItemSelected,
    );
  }

  void handleItemSelected(TEnum value) {
    onSelected?.call(value);
  }
}


class ChoiceBarWithIconWithAllValue extends ChoiceBarWithIcon<int> {
  static int allValue = -1;

  final Function(int?)? onAllOrValueSelected;

  ChoiceBarWithIconWithAllValue({
    Key? key,
    int? selectedValue,
    this.onAllOrValueSelected,
    required List<int> values,
    required ChoiceButtonText<int> choiceText,
    required ChoiceButtonIcon<int> iconData,
    List<int> exclude = const [],
  }) : super(
    key: key,
    selectedValue: selectedValue ?? allValue,
    choiceText: choiceText,
    exclude: exclude,
    values: values..add(allValue),
    iconData: iconData,
  );

  @override
  List<TranslatedEnumWithIcon<int>> getTranslatedValues() {
    return EnumUtils.getTranslatedAndSortedEnumWithAllValueAndIcon(allValue, 'All', Icons.local_fire_department_outlined, values, choiceText, iconData, exclude: exclude);
  }

  @override
  void handleItemSelected(int value) {
    if (onAllOrValueSelected == null) {
      return;
    }

    final valueToUse = value == allValue ? null : value;
    onAllOrValueSelected!(valueToUse);
  }
}


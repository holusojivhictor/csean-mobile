import 'package:csean_mobile/presentation/shared/choice/custom_choice_button.dart';
import 'package:csean_mobile/presentation/shared/utils/enum_utils.dart';
import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';

typedef ChoiceButtonText<T> = String Function(T value, int index);

class CommonChoiceBar<TEnum> extends StatelessWidget {
  final TEnum selectedValue;
  final List<TEnum> values;
  final Function(TEnum)? onSelected;
  final List<TEnum> exclude;
  final ChoiceButtonText<TEnum> choiceText;
  final WrapAlignment alignment;

  const CommonChoiceBar({
    Key? key,
    required this.selectedValue,
    required this.values,
    this.onSelected,
    this.exclude = const [],
    this.alignment = WrapAlignment.start,
    required this.choiceText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final translatedValues = getTranslatedValues();
    return Padding(
      padding: Styles.edgeInsetHorizontal16,
      child: Wrap(
        spacing: 10,
        runSpacing: 5,
        alignment: alignment,
        children: getButtons(context, translatedValues),
      ),
    );
  }

  List<TranslatedEnum<TEnum>> getTranslatedValues() {
    return EnumUtils.getTranslatedAndSortedEnum<TEnum>(values, choiceText, exclude: exclude);
  }

  List<Widget> getButtons(BuildContext context, List<TranslatedEnum<TEnum>> translatedValues) {
    return translatedValues.map((e) => _buildChoiceButton(context, e.enumValue, e.translation)).toList();
  }

  Widget _buildChoiceButton(BuildContext context, TEnum value, String valueText) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyText2;
    final isSelected = selectedValue == value;
    return CustomChoiceButton<TEnum>(
      value: value,
      isSelected: isSelected,
      valueText: valueText,
      textStyle: textStyle,
      onPressed: handleItemSelected,
    );
  }

  void handleItemSelected(TEnum value) {
    onSelected?.call(value);
  }
}


class CommonChoiceBarWithAllValue extends CommonChoiceBar<int> {
  static int allValue = -1;

  final Function(int?)? onAllOrValueSelected;

  CommonChoiceBarWithAllValue({
    Key? key,
    int? selectedValue,
    this.onAllOrValueSelected,
    required List<int> values,
    required ChoiceButtonText<int> choiceText,
    List<int> exclude = const [],
  }) : super(
    key: key,
    selectedValue: selectedValue ?? allValue,
    choiceText: choiceText,
    exclude: exclude,
    values: values..add(allValue),
  );

  @override
  List<TranslatedEnum<int>> getTranslatedValues() {
    return EnumUtils.getTranslatedAndSortedEnumWithAllValue(allValue, 'All', values, choiceText, exclude: exclude);
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


import 'package:csean_mobile/presentation/shared/translated_drop_down.dart';
import 'package:csean_mobile/presentation/shared/utils/enum_utils.dart';
import 'package:flutter/material.dart';

import 'common_dropdown_button.dart';

class CustomFullDropdownButton<T> extends StatelessWidget {
  final String title;
  final T currentValue;
  final bool isExpanded;
  final List<T> items;
  final List<TranslatedEnum<T>> translatedItems;
  final void Function(T)? onChanged;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final bool isTranslated;

  const CustomFullDropdownButton({
    Key? key,
    required this.title,
    required this.currentValue,
    this.items = const [],
    this.translatedItems = const [],
    this.onChanged,
    this.isExpanded = true,
    this.isTranslated = false,
    this.margin = const EdgeInsets.only(bottom: 15),
    this.padding = const EdgeInsets.only(left: 10),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(),
      ),
      child: isTranslated
          ? TranslatedDropdown<T>(
              hint: title,
              currentValue: currentValue,
              isExpanded: isExpanded,
              withoutUnderline: true,
              values: translatedItems,
              onChanged: onChanged != null ? (v, _) => onChanged!(v!) : null,
            )
          : CommonDropdownButton<T>(
              hint: title,
              currentValue: currentValue,
              isExpanded: isExpanded,
              withoutUnderline: true,
              values: items,
              onChanged: onChanged != null ? (v, _) => onChanged!(v!) : null,
            ),
    );
  }
}

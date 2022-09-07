import 'package:csean_mobile/presentation/shared/extensions/iterable_extensions.dart';
import 'package:flutter/material.dart';

class TranslatedEnum<TEnum> {
  final TEnum enumValue;
  final String translation;

  TranslatedEnum(this.enumValue, this.translation);
}

class TranslatedEnumWithIcon<TEnum> {
  final TEnum enumValue;
  final String translation;
  final IconData iconData;

  TranslatedEnumWithIcon(this.enumValue, this.translation, this.iconData);
}

class EnumUtils {
  static List<TranslatedEnum<TEnum>> getTranslatedAndSortedEnum<TEnum>(
      List<TEnum> values,
      String Function(TEnum, int) itemText, {
        List<TEnum> exclude = const [],
        bool sort = true,
      }) {
    final filterValues = exclude.isNotEmpty
        ? values.where((el) => !exclude.contains(el))
        : values;
    final translatedValues = filterValues
        .mapIndex((filter, index) =>
        TranslatedEnum<TEnum>(filter, itemText(filter, index)))
        .toList();

    if (sort) {
      translatedValues.sort((x, y) => x.translation.compareTo(y.translation));
    }
    return translatedValues;
  }

  static List<TranslatedEnum<TEnum>> getTranslatedAndSortedEnumWithAllValue<TEnum>(
      TEnum allValue,
      String allValueText,
      List<TEnum> values,
      String Function(TEnum, int) itemText, {
        List<TEnum> exclude = const [],
        bool sort = true,
      }) {
    final filterValues = exclude.isNotEmpty
        ? values.where((el) => !exclude.contains(el))
        : values;
    final translatedValues = filterValues
        .mapIndex((filter, index) => TranslatedEnum<TEnum>(filter,
        filter == allValue ? allValueText : itemText(filter, index)))
        .toList();

    if (sort) {
      translatedValues.sort((x, y) => x.translation.compareTo(y.translation));
    }
    return translatedValues;
  }

  static List<TranslatedEnumWithIcon<TEnum>> getTranslatedAndSortedEnumWithIcon<TEnum>(
      List<TEnum> values,
      String Function(TEnum, int) itemText,
      IconData Function(TEnum, int) iconData, {
        List<TEnum> exclude = const [],
        bool sort = true,
      }) {
    final filterValues = exclude.isNotEmpty
        ? values.where((el) => !exclude.contains(el))
        : values;
    final translatedValues = filterValues
        .mapIndex((filter, index) =>
        TranslatedEnumWithIcon<TEnum>(filter, itemText(filter, index), iconData(filter, index)))
        .toList();

    if (sort) {
      translatedValues.sort((x, y) => x.translation.compareTo(y.translation));
    }
    return translatedValues;
  }

  static List<TranslatedEnumWithIcon<TEnum>> getTranslatedAndSortedEnumWithAllValueAndIcon<TEnum>(
      TEnum allValue,
      String allValueText,
      IconData allValueIcon,
      List<TEnum> values,
      String Function(TEnum, int) itemText,
      IconData Function(TEnum, int) iconData, {
        List<TEnum> exclude = const [],
        bool sort = true,
      }) {
    final filterValues = exclude.isNotEmpty
        ? values.where((el) => !exclude.contains(el))
        : values;
    final translatedValues = filterValues
        .mapIndex((filter, index) => TranslatedEnumWithIcon<TEnum>(filter,
        filter == allValue ? allValueText : itemText(filter, index), filter == allValue ? allValueIcon : iconData(filter, index)))
        .toList();

    if (sort) {
      translatedValues.sort((x, y) => x.translation.compareTo(y.translation));
    }
    return translatedValues;
  }
}
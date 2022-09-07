import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:csean_mobile/presentation/shared/dropdown_button_with_title.dart';
import 'package:csean_mobile/presentation/shared/utils/enum_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChapterChangeDropdown extends StatelessWidget {
  final ChapterType selectedValue;
  final bool isExpanded;
  final bool isActive;

  const ChapterChangeDropdown({
    Key? key,
    required this.selectedValue,
    this.isExpanded = true,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final translatedValues = EnumUtils.getTranslatedAndSortedEnum<ChapterType>(
      ChapterType.values, (type, _) => type.name,
    );

    return DropdownButtonWithTitle<ChapterType>(
      margin: EdgeInsets.zero,
      title: 'Chapter change',
      isExpanded: isExpanded,
      currentValue: translatedValues.firstWhere((element) => element.enumValue == selectedValue).enumValue,
      items: translatedValues,
      onChanged: isActive ? (v) => context.read<ProfileBloc>().add(ProfileEvent.chapterTypeChanged(newValue: v)) : null,
    );
  }
}

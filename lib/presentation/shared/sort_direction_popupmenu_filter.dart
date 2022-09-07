import 'package:csean_mobile/domain/assets.dart';
import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:flutter/material.dart';

import 'item_popup_menu_filter.dart';

class SortDirectionPopupMenuFilter extends StatelessWidget {
  final SortDirectionType selectedSortDirection;
  final Function(SortDirectionType) onSelected;
  final Icon icon;
  const SortDirectionPopupMenuFilter({
    Key? key,
    required this.selectedSortDirection,
    required this.onSelected,
    this.icon = const Icon(Icons.sort),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ItemPopupMenuFilter<SortDirectionType>(
      toolTipText: 'Sort direction',
      selectedValue: selectedSortDirection,
      values: SortDirectionType.values,
      onSelected: onSelected,
      icon: icon,
      itemText: (val, _) => Assets.translateSortDirectionType(val),
    );
  }
}

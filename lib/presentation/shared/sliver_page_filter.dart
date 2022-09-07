import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';

import 'search_box.dart';

typedef OnPressed = void Function();

class SliverPageFilter extends StatelessWidget {
  final String title;
  final String? search;
  final OnPressed onPressed;
  final bool hasFilter;
  final Function(String) searchChanged;
  const SliverPageFilter({
    Key? key,
    required this.title,
    this.search,
    required this.onPressed,
    required this.searchChanged,
    this.hasFilter = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showClearButton = search != null && search!.isNotEmpty;
    return SliverToBoxAdapter(
      child: Row(
        children: [
          SearchBox(
            value: search,
            showClearButton: showClearButton,
            hasFilter: hasFilter,
            searchChanged: searchChanged,
          ),
          if (hasFilter)
            InkWell(
              borderRadius: Styles.circleTapBorderRadius,
              onTap: () => onPressed(),
              child: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor.withOpacity(0.6),
                ),
                child: const Icon(Icons.filter_list_rounded, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}

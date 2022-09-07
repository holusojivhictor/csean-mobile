import 'package:flutter/material.dart';

class DropDownBar extends StatelessWidget {
  final List<String> items;
  final String selectedValue;
  final void Function(String)? onClick;
  final String hintText;
  const DropDownBar({
    Key? key,
    required this.items,
    required this.selectedValue,
    required this.onClick,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: selectedValue,
          items: items.map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value),
            );
          }).toList(),
          hint: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(hintText),
          ),
          onChanged: (v) => onClick!(selectedValue),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CommonDropdownButton<T> extends StatelessWidget {
  final String hint;
  final T currentValue;
  final List<T> values;
  final Function(T, BuildContext)? onChanged;
  final bool isExpanded;
  final bool withoutUnderline;

  const CommonDropdownButton({
    Key? key,
    required this.hint,
    required this.currentValue,
    required this.values,
    this.onChanged,
    this.isExpanded = true,
    this.withoutUnderline = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      isExpanded: isExpanded,
      hint: Text(hint),
      value: currentValue,
      underline: withoutUnderline ? Container(height: 0, color: Colors.transparent) : null,
      onChanged: onChanged != null ? (v) => onChanged!(v as T, context) : null,
      selectedItemBuilder: (context) => values.map((value) => Align(
        alignment: Alignment.centerLeft,
        child: Text(value.toString(), textAlign: TextAlign.center),
      )).toList(),
      items: values.map<DropdownMenuItem<T>>((value) => DropdownMenuItem<T>(
        value: value,
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: value != currentValue ? const SizedBox(width: 20) : const Center(child: Icon(Icons.check)),
            ),
            Expanded(
              child: Text(
                value.toString(),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }
}

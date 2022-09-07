import 'package:flutter/material.dart';

import '../../../theme.dart';

class BottomSheetTitle extends StatelessWidget {
  final String title;
  final String endText;
  final IconData icon;
  final double iconSize;
  final bool hasIcon;
  final bool hasEndText;
  final TextStyle? textStyle;
  final void Function()? onTap;

  const BottomSheetTitle({
    Key? key,
    required this.title,
    required this.icon,
    this.iconSize = 25,
    this.hasIcon = true,
    this.textStyle,
    this.hasEndText = false,
    this.endText = '',
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: Styles.edgeInsetVertical5,
      child: Row(
        children: <Widget>[
          if (hasIcon)
            Align(alignment: Alignment.centerLeft, child: Icon(icon, size: iconSize)),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: hasIcon ? 5 : 0),
                  child: Text(title, style: textStyle ?? theme.textTheme.headline6, overflow: TextOverflow.ellipsis),
                ),
                if (hasEndText)
                  GestureDetector(
                    onTap: onTap != null ? () => onTap!() : null,
                    child: Text(endText, style: theme.textTheme.bodyText1!.copyWith(color: theme.primaryColor), overflow: TextOverflow.ellipsis),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

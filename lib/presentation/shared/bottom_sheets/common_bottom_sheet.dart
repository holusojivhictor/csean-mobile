import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';

import 'bottom_sheet_title.dart';
import 'common_bottom_sheet_buttons.dart';
import 'modal_sheet_separator.dart';

class CommonBottomSheet extends StatelessWidget {
  final String title;
  final String endText;
  final IconData titleIcon;
  final Widget child;
  final Function? onOk;
  final Function? onCancel;
  final double iconSize;
  final bool showOkButton;
  final bool showCancelButton;
  final bool hasIcon;
  final bool hasEndText;
  final TextStyle? textStyle;
  final void Function()? onTap;

  const CommonBottomSheet({
    Key? key,
    required this.title,
    required this.titleIcon,
    this.onOk,
    this.onCancel,
    required this.child,
    this.iconSize = 25,
    this.showOkButton = true,
    this.showCancelButton = true,
    this.hasIcon = true,
    this.hasEndText = false,
    this.endText = '',
    this.textStyle,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        margin: Styles.modalBottomSheetContainerMargin,
        padding: Styles.modalBottomSheetContainerPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const ModalSheetSeparator(),
            BottomSheetTitle(
              title: title,
              endText: endText,
              icon: titleIcon,
              iconSize: iconSize,
              hasIcon: hasIcon,
              hasEndText: hasEndText,
              textStyle: textStyle,
              onTap: onTap != null ? () => onTap!() : null,
            ),
            child,
            if (showOkButton || showCancelButton)
              CommonBottomSheetButtons(
                showOkButton: showOkButton,
                showCancelButton: showCancelButton,
                onOk: onOk,
                onCancel: onCancel,
              ),
          ],
        ),
      ),
    );
  }
}

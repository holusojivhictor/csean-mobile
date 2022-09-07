import 'package:csean_mobile/presentation/profile/widgets/top_image.dart';
import 'package:csean_mobile/presentation/shared/details/constants.dart';
import 'package:flutter/material.dart';

import 'bottom_positioned_image.dart';

class TopLayout extends StatelessWidget {
  final String smallImage;
  final String demoImage;
  final bool isSmallNotNull;
  final bool isPictureSet;
  final bool isEdit;
  final Widget? appBar;
  final String savedImage;
  final bool update;

  const TopLayout({
    Key? key,
    required this.smallImage,
    required this.demoImage,
    required this.isSmallNotNull,
    required this.isPictureSet,
    required this.isEdit,
    required this.savedImage,
    required this.update,
    this.appBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final maxHeight = getTopHeightForPortrait(context, true);

    return Container(
      height: maxHeight,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
      ),
      child: Stack(
        fit: StackFit.loose,
        alignment: Alignment.topCenter,
        children: [
          TopImage(
            savedImage: savedImage,
            isPictureSet: isPictureSet,
            isEdit: isEdit,
          ),
          Positioned(
            bottom: 15,
            left: 15,
            child: BottomPositionedImage(
              update: update,
              isSmallNotNull: isSmallNotNull,
              smallImage: smallImage,
              demoImage: demoImage,
              isEdit: isEdit,
            ),
          ),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: appBar ?? const SizedBox(),
          ),
        ],
      ),
    );
  }
}
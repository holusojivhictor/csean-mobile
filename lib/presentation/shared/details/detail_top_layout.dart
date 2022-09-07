import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class DetailTopLayout extends StatelessWidget {
  final String image;
  final Color? color;
  final Widget? appBar;
  final BorderRadius? borderRadius;
  final bool isBlog;

  const DetailTopLayout({
    Key? key,
    required this.image,
    this.color,
    this.appBar,
    this.borderRadius,
    this.isBlog = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final maxHeight = getTopHeightForPortrait(context, false);
    return Container(
      height: maxHeight,
      decoration: BoxDecoration(color: color ?? theme.scaffoldBackgroundColor),
      child: Stack(
        fit: StackFit.passthrough,
        alignment: isBlog ? Alignment.center : Alignment.topCenter,
        children: [
          isBlog
              ? Image(
                  image: CachedNetworkImageProvider(image),
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                )
              : Image.asset(
                  image,
                  filterQuality: FilterQuality.high,
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

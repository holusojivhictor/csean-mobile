import 'dart:io';

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SizeUtils {
  static int getCrossAxisCountForGrids(
      BuildContext context, {
        int? forPortrait,
        int? forLandscape,
        bool isBlog = false,
        bool isOnMainPage = false,
      }) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final size = MediaQuery.of(context).size;
    var deviceType = getDeviceType(size);
    final refinedSize = getRefinedSize(size);
    int crossAxisCount = 1;

    if (Platform.isWindows) {
      deviceType = DeviceScreenType.desktop;
    }
    switch (deviceType) {
      case DeviceScreenType.mobile:
        crossAxisCount = isPortrait ? forPortrait ?? 2 : forLandscape ?? 2;
        break;
      case DeviceScreenType.tablet:
        switch (refinedSize) {
          case RefinedSize.small:
            crossAxisCount = isPortrait ? forPortrait ?? 2 : forLandscape ?? (isOnMainPage ? 3 : 4);
            break;
          case RefinedSize.normal:
          case RefinedSize.large:
            crossAxisCount = isPortrait ? forPortrait ?? 2 : forLandscape ?? (isOnMainPage ? 3 : 4);
            break;
          case RefinedSize.extraLarge:
            crossAxisCount = isPortrait ? forPortrait ?? 2 : forLandscape ?? (isOnMainPage ? 3 : 4);
            break;
        }
        break;
      case DeviceScreenType.desktop:
        if (size.width > 1680) {
          crossAxisCount = 5;
        } else if (size.width > 1280) {
          crossAxisCount = 4;
        } else if (size.width > 800) {
          crossAxisCount = 4;
        } else {
          crossAxisCount = 3;
        }
        break;
      default:
        break;
    }

    return isBlog ? (crossAxisCount + (crossAxisCount * 0.3).round()) : crossAxisCount;
  }
}

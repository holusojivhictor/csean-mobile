import 'package:csean_mobile/presentation/shared/app_fab.dart';
import 'package:csean_mobile/presentation/shared/extensions/scroll_controller_extensions.dart';
import 'package:flutter/material.dart';

mixin AppFabMixin<T extends StatefulWidget> on State<T>, SingleTickerProviderStateMixin<T> {
  late ScrollController scrollController;
  late AnimationController hideFabAnimController;
  bool isInitiallyVisible = false;
  bool hideOnTop = true;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    hideFabAnimController = AnimationController(vsync: this, duration: kThemeAnimationDuration, value: isInitiallyVisible ? 1 : 0);
    scrollController.addListener(() => scrollController.handleScrollForFab(hideFabAnimController, hideOnTop: hideOnTop));
  }

  @override
  void dispose() {
    scrollController.dispose();
    hideFabAnimController.dispose();
    super.dispose();
  }

  AppFab getAppFab() {
    return AppFab(scrollController: scrollController, hideFabAnimController: hideFabAnimController);
  }
}
import 'package:flutter/material.dart';

class AnimatedPageRoute extends PageRouteBuilder {
  final Widget page;

  AnimatedPageRoute({required this.page}) : super(
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => page,
    transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
      final curveAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.ease,
      );
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, 1.0),
          end: Offset.zero,
        ).animate(curveAnimation),
        child: child,
      );
    },
  );
}

class SlideAnimatedPageRoute extends PageRouteBuilder {
  final Widget page;

  SlideAnimatedPageRoute({required this.page}) : super(
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => page,
    transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    },
  );
}
